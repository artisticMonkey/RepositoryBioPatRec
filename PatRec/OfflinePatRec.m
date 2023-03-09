% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors’ contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees’ quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
% Function to execute the Offline traning once selected from the GUI in
% Matlab
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2011-07-26 / Max Ortiz / Creation
% 2011-10-03 / Max Ortiz / Addition of individual movements routine
% 2011-11-29 / Max Ortiz / Addition of the posibility different topologies
% 2012-10-10 / Max Ortiz / Addition of algConf 
% 2012-11-02 / Max Ortiz / Addition of floor noise 
% 2012-11-23 / Joel Falk-Dahlin / Added initialization of speeds
% 2013-01-02 / Max Ortiz / Added Feature Reduction variables
%                          Modified floor noise to compute only the first
%                          feature
% 2014-12-01 / Enzo Mastinu  / Added the handling part for the COM port number
                             % information into the parameters
% 2016-04-29 / Julian Maier / Added new fields sigDenoising, sigSeparation, mFilter, addArtifact to copy to patRec
% 2017-04-04 / Jake Gusman  / Added data from ramp training to patRec.control.propControl

% 20xx-xx-xx / Author  / Comment on update

function patRec = OfflinePatRec(sigFeatures, selFeatures, randFeatures, normSetsType, alg, tType, algConf, movMix, topology, confMatFlag, featReducAlg, plotFlag, transLearningFeatures,CVFeatures)

    %% patRec structure initialization
    global score;
    score = [];
%     new_mov_idx         = [3, 4, 5, 6, 7, 8];
%     sigFeatures.mov     = sigFeatures.mov(new_mov_idx);
%     sigFeatures.transFeatures = sigFeatures.transFeatures(:,new_mov_idx(1:(end - 1)));
    patRec.nM            = size(sigFeatures.mov,1);
    patRec.mov           = sigFeatures.mov;
    patRec.sF            = sigFeatures.sF;
    patRec.tW            = sigFeatures.tW;
    patRec.wOverlap      = sigFeatures.wOverlap;
    patRec.nCh           = sigFeatures.nCh;
    if isfield(sigFeatures,'vCh')
        patRec.vCh       = sigFeatures.vCh;
    end
    patRec.dev           = sigFeatures.dev;
    patRec.fFilter       = sigFeatures.fFilter;    
    patRec.sFilter       = sigFeatures.sFilter;   
    patRec.selFeatures   = selFeatures;     
    patRec.topology      = topology;
    patRec.featureReduction.Alg = featReducAlg;
    patRec.transAlg      = transLearningFeatures.transAlg;
    patRec.dataExtension = transLearningFeatures.dataExtension;
    patRec.tType         = tType;
    patRec.trainAll      = CVFeatures.trainAll;
    patRec.numTestData   = CVFeatures.testData;
    repetitionTime       = CVFeatures.repetitionTime;
    if (repetitionTime==0)
        repetitionTime = 8;
    end
    retrain = transLearningFeatures.retrain;
	
    if isfield(sigFeatures,'sigDenoising')
        patRec.sigDenoising = sigFeatures.sigDenoising;
    end
    
    if isfield(sigFeatures,'sigSeparation')
        patRec.sigSeparation = sigFeatures.sigSeparation;
    end
    
    if isfield(sigFeatures,'mFilter')
        patRec.mFilter = sigFeatures.mFilter;
    end
    
    if isfield(sigFeatures,'addArtifact')
        patRec.addArtifact = sigFeatures.addArtifact;
        patRec.addArtifact.mFilter = sigFeatures.mFilter;
    end
    
    if isfield(sigFeatures, 'comm') 
        patRec.comm = sigFeatures.comm;
        if isfield(sigFeatures, 'comn') 
            patRec.comn = sigFeatures.comn;
        end
    else
        patRec.comm = 'N/A';
    end

    if isfield(sigFeatures, 'useAcceleGlove')
        patRec.useAcceleGlove = sigFeatures.useAcceleGlove;
        if patRec.useAcceleGlove
            patRec.ag_port = sigFeatures.ag_port;
        end
    else
        patRec.useAcceleGlove = 0;
    end
    
    % Ramp training data
    if isfield(sigFeatures,'ramp')
        patRec.control.rampTrainingData.ramp = sigFeatures.ramp;
    end

    if isfield(sigFeatures,'magnetData')
        patRec.magnetData = sigFeatures.magnetData;
    end

    patchPropChannels = ones(patRec.nM,length(patRec.nCh));
    patchPropChannels(end,:) = 0;
    patRec.patchPropChannels = patchPropChannels;
    
    %% Start counting the training time
    trStart = tic;
    
    %% Randomize data (if requested)
    if randFeatures
        sigFeatures = Rand_sigFeatures(sigFeatures);
    end
    
     %% Get data sets

     if strcmp(movMix, 'All Mov')
        
        [trSets, trOuts, vSets, vOuts, tSets, tOuts, movIdx, movOutIdx] = GetSets_Stack(sigFeatures, selFeatures); 
        
     elseif strcmp(movMix, 'Individual Mov')
         
        [trSets, trOuts, vSets, vOuts, tSets, tOuts, movIdx, movOutIdx] = GetSets_Stack_IndvMov(sigFeatures, selFeatures);

     elseif strcmp(movMix, 'Mixed Output')
         
        [trSets, trOuts, vSets, vOuts, tSets, tOuts, movIdx, movOutIdx] = GetSets_Stack_MixedOut(sigFeatures, selFeatures);

     end
     patRec.movOutIdx = movOutIdx;
     movLables = sigFeatures.mov(movIdx);  
     
    %% Normalize
    [trSets vSets patRec] = NormalizeSets_TrV(normSetsType, trSets, vSets, patRec);     
      
    %% Transient % 
    global derivativeOnset;
    global propRatio;
    if (strcmp(alg,'SVMtHW')||strcmp(alg,'SVMt')) && ((~contains(patRec.topology,"Crossvalidation"))&&(~contains(patRec.topology,"CVLORO4")))
        if (derivativeOnset)
            if isfield(patRec,'magnetData')
                [transSets, transOuts, patRec.dThreshold, patRec.threshold, transTSets, transTOuts] = GetSets_Stack_TransientMov_Luis_Magnets(sigFeatures, selFeatures, 0.25, patRec, plotFlag); %AM 20180921
            else
                [transSets, transOuts, patRec.threshold, patRec.maxVals, transTSets, transTOuts, patRec.patchPropChannels] = GetSets_Stack_TransientMov_Luis(sigFeatures, selFeatures, 0.25, patRec, plotFlag, propRatio); %AM 20180921
                patRec.propRatio = propRatio;
            end
        else
            if isfield(sigFeatures,'nDataPerSubject')
                itter = length(sigFeatures.nDataPerSubject);
            else
                itter = 1;
            end
            propMthDiff = zeros(itter,patRec.nM - 1);
            for subject = 1:itter
                sigFeaturesSubject = sigFeatures;
                % taking data from one subject
                if isfield(sigFeatures,'nDataPerSubject')
                    indTest = (sum(sigFeatures.nDataPerSubject(1:(subject - 1))) + 1):sum(sigFeatures.nDataPerSubject(1:(subject)));
                    sigFeaturesSubject.transFeatures = sigFeatures.transFeatures(indTest,:);
                    indTestRamp = (sum(sigFeatures.ramp.nDataPerSubject(1:(subject - 1))) + 1):sum(sigFeatures.ramp.nDataPerSubject(1:(subject)));
                    sigFeaturesSubject.ramp.minData = sigFeatures.ramp.minData(indTestRamp,:);
                    sigFeaturesSubject.ramp.maxData = sigFeatures.ramp.maxData(indTestRamp,:,:);
                end
                pRatio = propRatio;
                [transSets, transOuts, patRec.threshold, patRec.maxVals, transTSets, transTOuts, patRec.normSets.minMovValues, patchPropChannels, proportionalMethodDifference] = GetSets_Stack_TransientMov(sigFeaturesSubject, selFeatures, 0.25, patRec, plotFlag, pRatio);  %AM 20180921
                while (sum(sum(patchPropChannels,2) < 1)) % increasing the ratio between median of peaks and MVC until for each movement we have a least one channel for proportional control
                    pRatio = pRatio + 0.1;
                    [transSets, transOuts, patRec.threshold, patRec.maxVals, transTSets, transTOuts, patRec.normSets.minMovValues, patchPropChannels, proportionalMethodDifference] = GetSets_Stack_TransientMov(sigFeaturesSubject, selFeatures, 0.25, patRec, plotFlag, pRatio);  %AM 20180921
                end
                pRatioSub(subject) = pRatio;
                patchPropChannels(end+1,:) = 0; % adding 0 for the rest class for all channels
                patRec.patchPropChannels = patchPropChannels;
                patRec.propRatio = pRatio;
                propMthDiff(subject,:) = proportionalMethodDifference;
            end
            figure ('name','Difference between current and proposed method for proportional control')
            movements = {'Open Hand','Close Hand','Flex Hand','Extend Hand','Pronation','Supination','Side Grip','Fine Grip'};
            for mov = 1:patRec.nM - 1
                subplot(2,4,mov)
                bar(propMthDiff(:,mov));
                ylim([0 35])
                title(movements{mov})
                xlabel('Subjects')
                ylabel('Percentage of difference (%)')
            end
            figure('name','Proportional ratio for each subject')
            bar(pRatioSub);
            ylim([0 1])
            xlabel('Subjects')
        end
        
        tSets = transTSets;
        tOuts = transTOuts;
    elseif strcmp(alg,'SVMcv') && (~contains(patRec.topology,"Crossvalidation"))
        % This part is just to obtain the parameters of the classifier for
        % online test
        [transSets, transOuts] = GetSets_Stack_CV(sigFeatures, selFeatures);
        tSets = transSets;
        tOuts = transOuts;
        [transSets, ~, patRec] = NormalizeSets_TrV(normSetsType, transSets, [], patRec); 
    else
        transSets= []; transOuts= [];
        transTSets= []; transTOuts = [];
        patRec.threshold = 0;
    end
    
    
    %% Floor noise
    if strcmp(movLables(end),'Rest')
        restIdx = find(trOuts(:,end));  % Get Indices of the rest sets
        restSets = trSets(restIdx,:);   % Get data sets related to rest
        restSets = mean(restSets);      % Mean for all windows
        
        % Compute the floor noise of the first feature only
        floorNoise = mean(restSets(1:size(patRec.nCh,2)));
        
        % Loop to compute the floor noise of each feature
%         sCh = 1;                        % starting channel
%         for i = 1 : size(patRec.selFeatures,1)
%             eCh = sCh + size(patRec.nCh,2)-1;
%             floorNoise(i) = mean(restSets(sCh:eCh));
%             sCh = eCh +1; 
%         end
        
        % Save floor noise in patRec
        patRec.floorNoise = floorNoise;
    end
    % Note: The floor noise must be computed after normalization so it can
    % be used as a threshold after SignalProcessing_Realtime in the
    % real-time testing

    %% Feature Reduction
    [trSets vSets,patRec]=FeatureReduction(trSets,vSets,patRec);
    
    %% Topology and algorithm selection
    if strcmp(patRec.topology,'Single Classifier')
        
        %patRec.patRecTrained = OfflinePatRecTraining(alg, tType, trSets, trOuts, vSets, vOuts, trLables, vLables, movLables);
        patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, false);

    elseif strcmp(patRec.topology,'Ago-antagonist') || ...
           strcmp(patRec.topology,'Ago-antagonistAndMixed')
        %Compute the number of DoF involved
        if strcmp(movLables(end),'Rest')
            nMov = size(movIdx,2) - 1;
            restIdx = size(movIdx,2);
        else
            nMov = size(movIdx,2);    
            restIdx = [];
        end

        % Run through all DoF and get mov 1 and 2 from each DoF plus a Mix.c
        for i = 1 : 2 : nMov
            movIdxX = [i i+1];
            disp(['Training DoF:' num2str(round(i/2))]);
 
            % Train only with the Ago-antagonist movements or also the
            % mixed of the remaining movements.
            % If the rest movement is present. It would be considered in
            % the training of each DoF
            if strcmp(patRec.topology,'Ago-antagonist') 
                [trSetsX, trOutsX, vSetsX, vOutsX] = ...
                ExtractSets_Stack(trSets, trOuts, vSets, vOuts, [movIdxX restIdx]);
                movIdxX(end+1) = restIdx;
            elseif strcmp(patRec.topology,'Ago-antagonistAndMixed') 
                [trSetsX, trOutsX, vSetsX, vOutsX, movIdxX, movLables] = ...
                ExtractSets_Stack_MixRest(trSets, trOuts, vSets, vOuts, [movIdxX restIdx], movLables);                
            end
            
            patRec.patRecTrained(round(i/2)) = OfflinePatRecTraining(alg, tType, algConf, trSetsX, trOutsX, vSetsX, vOutsX, movLables, movIdxX);
            
        end        
        
    elseif strcmp(patRec.topology,'One-vs-All') || ...
           strcmp(patRec.topology,'One-vs-All Th') 
        % Number of selected movementes, it might be different than patRec.nM
        nM = size(movIdx,2);    
        
        % Creat a binary classifiers per movements
        for i = 1 : nM
            disp(['Training movement:' num2str(i)]);
            movIdxX = i;
            [trSetsX, trOutsX, vSetsX, vOutsX, movIdxX, movLables] = ExtractSets_Stack_MixRest(trSets, trOuts, vSets, vOuts, movIdxX, movLables);
            patRec.patRecTrained(i) = OfflinePatRecTraining(alg, tType, algConf, trSetsX, trOutsX, vSetsX, vOutsX, movLables, movIdxX);
        end
        
        
    elseif strcmp(patRec.topology,'One-vs-One') || strcmp(patRec.topology,'One-vs-One DoF')
        
        nM = size(movIdx,2);    % Number of selected movementes, it might be different than patRec.nM
        
        % Creat a matrix with binary classifiers between each movements
        for i = 1 : nM
            for j = i+1 : nM
                disp(['Training movement:' num2str(i) ' vs ' num2str(j)]);
                movIdxX = [i j];
                [trSetsX, trOutsX, vSetsX, vOutsX] = ExtractSets_Stack(trSets, trOuts, vSets, vOuts, movIdxX);
                patRec.patRecTrained(i,j) = OfflinePatRecTraining(alg, tType, algConf, trSetsX, trOutsX, vSetsX, vOutsX, movLables, movIdxX);
            end
        end

    elseif strcmp(patRec.topology,'All-and-One')

        % Number of selected movementes, it might be different than pactRec.nM
        nM = size(movIdx,2);    
        % Creat a binary classifiers per movements (One-Vs-All)
        for i = 1 : nM
            movIdxX = i;
            disp(['Training movement:' num2str(i)]);
            [trSetsX, trOutsX, vSetsX, vOutsX, movIdxX, movLables] = ExtractSets_Stack_MixRest(trSets, trOuts, vSets, vOuts, movIdxX, movLables);
            patRec.patRecTrained(i) = OfflinePatRecTraining(alg, tType, algConf, trSetsX, trOutsX, vSetsX, vOutsX, movLables, movIdxX);
        end       

        % Creat a matrix with binary classifiers between each movements
        % (One-Vs-One)
        for i = 1 : nM
            for j = i+1 : nM
                movIdxX = [i j];
                disp(['Training movement:' num2str(i) ' vs ' num2str(j)]);
                [trSetsX, trOutsX, vSetsX, vOutsX] = ExtractSets_Stack(trSets, trOuts, vSets, vOuts, movIdxX);
                patRec.patRecTrainedAux(i,j) = OfflinePatRecTraining(alg, tType, algConf, trSetsX, trOutsX, vSetsX, vOutsX, movLables, movIdxX);
            end
        end
    elseif strcmp(patRec.topology,'Crossvalidation leave-one-repetition-out')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        rng(0);
        perf = struct([]);
        % in case multiple subjects were loaded, we need to run
        % crossvalidation multiple times
        if isfield(sigFeatures,'nDataPerSubject')
            itter = length(sigFeatures.nDataPerSubject);
        else
            itter = 1;
        end
        for subject = 1:itter
            sigFeaturesSubject = sigFeatures;
            % taking data from one subject in case of multiple subjects
            % loaded
            if isfield(sigFeatures,'nDataPerSubject')
                indTest = (sum(sigFeatures.nDataPerSubject(1:(subject - 1))) + 1):sum(sigFeatures.nDataPerSubject(1:(subject)));
                sigFeaturesSubject.transFeatures = sigFeatures.transFeatures(indTest,:);
            end
            nData = fix(size(sigFeaturesSubject.transFeatures,1)/sigFeaturesSubject.nR); % length of one movement
            nR = 19; % number of repetitions per movement used for training
            sigFeaturesSubject.nR = nR;
            for crossIndx = 1:10%sigFeaturesSubject.nR % choose how many fold you wish to have
                sigFeatures1 = sigFeaturesSubject; % training data
                sigFeatures2 = sigFeaturesSubject; % test data
                sigFeatures1.nR = sigFeaturesSubject.nR;
                sigFeatures2.nR = sigFeatures.nR - sigFeaturesSubject.nR;
                if (nR == 19)
                    % in case of Leave-One-Repetition out, there is no need
                    % for random choosing of training data
                    tIndx = (crossIndx - 1)*nData + 1:crossIndx*nData;
                    trIndx = setdiff(1:size(sigFeaturesSubject.transFeatures,1),tIndx);
                else
                    % choosing training data randomly
                    trIndx = (1:nData) + nData.*(randperm(sigFeatures.nR,nR)' - 1);
                    trIndx = reshape(trIndx',1,nR*nData);
                    tIndx = setdiff(1:size(sigFeaturesSubject.transFeatures,1),trIndx);
                end
                sigFeatures2.transFeatures = sigFeaturesSubject.transFeatures(tIndx,:);
                sigFeatures1.transFeatures = sigFeaturesSubject.transFeatures(trIndx,:);
                % finding the peaks of training and test data
                [transSets, transOuts, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeatures1, selFeatures, 0.25, patRec, plotFlag); %AM 20180921
                [transTSets, transTOuts] = GetPeaks(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV);
                % training the model
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, false);
                patRec.alg = alg;
                % testing the model
               [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
            end
        end
        
    elseif strcmp(patRec.topology,'Crossvalidation leave-one-subject-out')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Combining all training subjects to achieve one optimal threshold
        % for ODA
        perf = struct([]);
        for crossIndx = 1:length(sigFeatures.nDataPerSubject)
            sigFeatures1 = sigFeatures; % training subjects
            sigFeatures1.nR = sigFeatures.nR*(length(sigFeatures.nDataPerSubject) - 1);
            sigFeatures2 = sigFeatures; % test subject
            %indTest = ((crossIndx - 1)*sigFeatures.nDataPerSubject(crossIndx) + 1):(crossIndx*sigFeatures.nDataPerSubject(crossIndx));
            indTest = (sum(sigFeatures.nDataPerSubject(1:(crossIndx - 1))) + 1):sum(sigFeatures.nDataPerSubject(1:(crossIndx)));
            indTrain = setdiff(1:size(sigFeatures.transFeatures,1),indTest);
            sigFeatures2.nDataPerSubject = sigFeatures.nDataPerSubject(crossIndx);
            sigFeatures1.nDataPerSubject = sigFeatures.nDataPerSubject(setdiff(1:length(sigFeatures.nDataPerSubject),crossIndx));
            sigFeatures1.transFeatures = sigFeatures.transFeatures(indTrain,:);
            sigFeatures2.transFeatures = sigFeatures.transFeatures(indTest,:);
            if (strcmp(alg,'SVMtHW')||strcmp(alg,'SVMt'))
                [transSets, transOuts, patRec.threshold, patRec.maxVals, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossSubject(sigFeatures1, selFeatures, 0.25, patRec, plotFlag); %AM 20180921
                [transTSets, transTOuts] = GetPeaks_Subject(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, NoiseMAV);
            else
                transSets= []; transOuts= [];
                transTSets= []; transTOuts = [];
                patRec.threshold = 0;
            end
            patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts,false);
            patRec.alg = alg;
            [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
        end
     elseif strcmp(patRec.topology,'Crossvalidation leave-one-subject-out with transfer learning')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % for each subject we find an optimal ODA threshold, and for test
        % subject we choose min/median threshold
        flag_CCA  = strcmp(patRec.transAlg,'Canonical correlation analysis');
        flag_MA   = strcmp(patRec.transAlg,'Model adaptation');
        flag_RD   = strcmp(patRec.dataExtension,'Random data points');
        flag_SMT  = strcmp(patRec.dataExtension,'SMOTE');
        flag_OS = flag_RD + flag_SMT*2;
%         flag_CCA = 1;
        dataExtension = 50; % number to which data are oversampled (repetitions per movement)
        dataCalibrated = 10; % how many data per movement we take from test subject
        features = struct([]);
        %%% Removing some of the subjects from the data set
%         remove = [1 2 3 4 5];
%         sigFeatures = removeSubjects(sigFeatures,remove);
        %%% 
        if (flag_CCA) 
            % finding the peaks of the expert subject for CCA
            [transSetsExpert,transOutsExpert, sigFeatures] = CCAExpert(sigFeatures,1,selFeatures,patRec);
        end
        numSubjects = length(sigFeatures.nDataPerSubject);
        % find the peaks for all the subjects first to speed up the
        % algorithm
        for ind = 1:numSubjects
            indCurrent = ((ind - 1)*sigFeatures.nDataPerSubject(ind) + 1):(ind*sigFeatures.nDataPerSubject(ind)); % indeces for each subject
            sigFeaturesCurrent = sigFeatures;
            sigFeaturesCurrent.transFeatures = sigFeatures.transFeatures(indCurrent,:);
            % putting all the relevant data from each subject into the
            % struct 'features'
            [features(ind).data, features(ind).out, features(ind).threshold, features(ind).midRange, features(ind).range, ~] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeaturesCurrent, selFeatures, 0.25, patRec, plotFlag);
        end

        % Model adaptation: finding a SVM model for each subject
        if (flag_MA)
            for sub = 1:numSubjects
                modelSVM{sub} = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, features(sub).data, features(sub).out, false);
            end
        end
        numFeatures = size(features(1).data,2);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        perf = struct([]);
        %%% Begining of cross validation leave one subject out
        for trainingData = 1%1:(numSubjects - 5) % for loop for vaying number of training subjects
        for crossIndx = 1:numSubjects
            sigFeatures2 = sigFeatures; % test subject
            indTest = ((crossIndx - 1)*sigFeatures.nDataPerSubject(crossIndx) + 1):(crossIndx*sigFeatures.nDataPerSubject(crossIndx)); % getting indeces of test subject's data
            sigFeatures2.nDataPerSubject = sigFeatures.nDataPerSubject(crossIndx);
            sigFeatures2.transFeatures = sigFeatures.transFeatures(indTest,:);
            indTrain = setdiff(1:numSubjects,crossIndx); % making sure that the test subject is not in the training
%             indTrain = indTrain(5:end);
%             indTrain = indTrain(1:trainingData);
            transSets = []; transOuts = []; threshold = zeros(1,length(indTrain)); midRange = zeros(length(indTrain),numFeatures); range = zeros(length(indTrain),numFeatures);
            for train = 1:length(indTrain)%(numSubjects - 1)
                if (flag_CCA)
                    % in case that the training subject does not have the same number of data as the expert, we remove some of the data points from the expert user to be able to complete CCA
                    if (size(features(indTrain(train)).data,1) ~= sigFeatures2.nR*size(sigFeatures2.transFeatures,2)) 
                        [features(indTrain(train)),transSetsExpertTemporary] = matchingTrainingExpertCCA(features(indTrain(train)),transSetsExpert,transOutsExpert,sigFeatures.nR);
                    else
                        transSetsExpertTemporary = transSetsExpert;
                    end
                    [transSetsTemporary,~] = CCA(features(indTrain(train)).data,transSetsExpertTemporary); % projecting the training data into a new space
                    transSets = [transSets; transSetsTemporary];
                else
                    transSets = [transSets; features(indTrain(train)).data];
                end
                transOuts = [transOuts; features(indTrain(train)).out];
                % saving the ODA threshold and the normalization parameters
                threshold(train) = features(indTrain(train)).threshold;
                midRange(train,:) = features(indTrain(train)).midRange;
                range(train,:) = features(indTrain(train)).range;
            end
            patRec.threshold = min(threshold); % finding the median/min threshold
            midV = median(midRange,1); rangeV = median(range,1); % finding the median normalization parameters
            nData = fix(size(sigFeatures2.transFeatures,1)/sigFeatures2.nR); % length of one movement
            for random = 1:5 % 4 fold cross validation for test subject
                nR = 10; % number of repetitions in each fold (20 repetitions per movement/4 folds)
                sigFeatures2Tr = sigFeatures2; sigFeatures2Ts = sigFeatures2;
                sigFeatures2Tr.nR = dataCalibrated; sigFeatures2Ts.nR = nR;
                tIndx = (1:nR*nData) + (random - 1)*nR*nData; % choosing the nR consecutive repetitions for testing
                trIndx = setdiff(1:size(sigFeatures2.transFeatures,1),tIndx); % getting the rest of the repetitions for calibration
                % downsampling the calibration set to the number of repetitions set by the user (dataCalibrated)
                rng(0);
                trIndx = downsampleRepetitions(trIndx,sigFeatures.nR-nR,dataCalibrated,nData);
                sigFeatures2Ts.transFeatures = sigFeatures2.transFeatures(tIndx,:);
                sigFeatures2Tr.transFeatures = sigFeatures2.transFeatures(trIndx,:);
                % getting the threshold and normalization values from the
                % calibration set
                [transTSets1, transTOuts1, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeatures2Tr, selFeatures, 0.25, patRec, plotFlag); %AM 20180921
                [transTSets, transTOuts] = GetPeaks(sigFeatures2Ts, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV);
                %%% OVERSAMPLING 
                if (exist('transSetsExpert','var') == 0)
                    transSetsExpert = transTSets1; transOutsExpert = transTOuts1;
                end
                [calibrationSet, calibrationExpert] = oversampling(transTSets1,transTOuts1,transSetsExpert,transOutsExpert,dataExtension,flag_OS,flag_CCA);
                calibrationOut = createOuts(dataExtension,(length(patRec.mov) - 1));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                patRec.alg = alg;
                if (flag_CCA)
                    % obtaining matrix A which is used for projecting test data
%                     [patRec.patRecTrained, subInd] = modelAdaptation(patRec,modelSVM,transTSets1,transTOuts1,indTrain);
                    [calibrationSet, A] = CCA(calibrationSet,calibrationExpert);
                    transTSets = transTSets*A; % projecting the test data into a new space
%                     if (size(features(indTrain(subInd)).data,1) ~= sigFeatures2.nR*size(sigFeatures2.transFeatures,2)) 
%                         [features1,transSetsExpertTemporary] = matchingTrainingExpertCCA(features(indTrain(subInd)),calibrationSet,calibrationOut,sigFeatures.nR);
%                     else
%                         transSetsExpertTemporary = calibrationSet;
%                         features1 = features(indTrain(subInd));
%                     end
%                     [transSets,~] = CCA(features1.data,transSetsExpertTemporary);
%                     transOuts = features1.out;
                end
                autoscale = false;
%                 patRec.alg = alg;
%                 if (flag_MA)
%                     [patRec.patRecTrained, subInd] = modelAdaptation(patRec,modelSVM,transTSets,transTOuts,indTrain);
%                 else
                    patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, autoscale);
%                 end
                if(retrain) % RETRAINING THE SVM
                    patRec.patRecTrained = retrainSVM(patRec,calibrationSet,calibrationOut);
                end
                [perf(end + 1).performance, perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
            end
        end
        end
    elseif strcmp(patRec.topology,'Crossvalidation leave-one-subject-out median threshold')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % for each subject we find an optimal ODA threshold, and for test
        % subject we choose median threshold
        perf = struct([]);
        numPeaks = [];
        rng(0);
        features = struct([]);
%         remove = [1:10]; removeInd = [];
%         for r = 1:length(remove)
%             removeInd = [removeInd, ((remove(r) - 1)*sigFeatures.nDataPerSubject(1) + 1):(remove(r)*sigFeatures.nDataPerSubject(1))];
%         end
%         subjects = setdiff(1:size(sigFeatures.transFeatures,1),removeInd);
%         sigFeatures.nDataPerSubject = sigFeatures.nDataPerSubject(1:(20 - length(remove)));
%         sigFeatures.transFeatures = sigFeatures.transFeatures(subjects,:);
        numSubjects = length(sigFeatures.nDataPerSubject);
        % find the peaks for all the subjects first to speed up the
        % algorithm
        for ind = 1:length(sigFeatures.nDataPerSubject)
            indCurrent = ((ind - 1)*sigFeatures.nDataPerSubject(ind) + 1):(ind*sigFeatures.nDataPerSubject(ind)); % indeces for each subject
            sigFeaturesCurrent = sigFeatures;
            sigFeaturesCurrent.transFeatures = sigFeatures.transFeatures(indCurrent,:);
            % putting all the relevant data from each subject into the
            % struct 'features'
            [features(ind).data, features(ind).out, features(ind).threshold, features(ind).midRange, features(ind).range, ~] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeaturesCurrent, selFeatures, 0.25, patRec, plotFlag);
        end
        for trainingData = 1:(numSubjects - 1) % variating the number of subjects being used for training
            for crossIndx = 1:numSubjects
                sigFeatures2 = sigFeatures; % test subject
                indTest = ((crossIndx - 1)*sigFeatures.nDataPerSubject(crossIndx) + 1):(crossIndx*sigFeatures.nDataPerSubject(crossIndx));
                sigFeatures2.nDataPerSubject = sigFeatures.nDataPerSubject(crossIndx);
                sigFeatures2.transFeatures = sigFeatures.transFeatures(indTest,:);
                indTrain = setdiff(1:numSubjects,crossIndx); % making sure that the test subject is not in the training
                indTrain = indTrain(1:trainingData);
                transSets = []; transOuts = []; threshold = zeros(1,trainingData); midRange = zeros(trainingData,size(features(1).data,2)); range = zeros(trainingData,size(features(1).data,2));
                for train = 1:trainingData % uniting all the training subjects
                    transSets = [transSets; features(indTrain(train)).data];
                    transOuts = [transOuts; features(indTrain(train)).out];
                    threshold(train) = features(indTrain(train)).threshold;
                    midRange(train,:) = features(indTrain(train)).midRange;
                    range(train,:) = features(indTrain(train)).range;
                end
                patRec.threshold = median(threshold); % finiding the median threshold
                midV = median(midRange,1); rangeV = median(range,1); % finding the median normalization parameters
                autoscale = false;
                % training the algorithm
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, autoscale);
                patRec.alg = alg;
                % finding the peaks of the test subject using the
                % parameters from the training subjects
                [transTSets, transTOuts] = GetPeaks(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midV, rangeV, 0);
                numPeaks = [numPeaks, size(transTSets,1)];
                % recording the performance
                [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
            end
        end

    elseif strcmp(patRec.topology,'Crossvalidation leave-one-subject-out individual threshold1')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % for every subject we find the optimal threshold (including the
        % test subject)
        remove = 5 + 5; removeInd = [];
        for r = 1:length(remove)
            removeInd = [removeInd, ((remove(r) - 1)*sigFeatures.nDataPerSubject(1) + 1):(remove(r)*sigFeatures.nDataPerSubject(1))];
        end
        subjects = setdiff(1:size(sigFeatures.transFeatures,1),removeInd);
        sigFeatures.nDataPerSubject = sigFeatures.nDataPerSubject(1:(20 - length(remove)));
        sigFeatures.transFeatures = sigFeatures.transFeatures(subjects,:);
        perf = struct([]);
        numPeaks = [];
        rng(0);
        features = struct([]);
        sigFeaturesHealthy = sigFeatures;
        sigFeaturesHealthy.nDataPerSubject = sigFeatures.nDataPerSubject(6:end);
        sigFeaturesHealthy.transFeatures = sigFeatures.transFeatures(5*sigFeatures.nDataPerSubject(6):end,:);
        numSubjects = length(sigFeaturesHealthy.nDataPerSubject);
        for ind = 1:numSubjects
            indCurrent = ((ind - 1)*sigFeaturesHealthy.nDataPerSubject(ind) + 1):(ind*sigFeaturesHealthy.nDataPerSubject(ind));
            sigFeaturesCurrent = sigFeaturesHealthy;
            sigFeaturesCurrent.transFeatures = sigFeaturesHealthy.transFeatures(indCurrent,:);
            [features(ind).data, features(ind).out, features(ind).threshold, features(ind).midRange, features(ind).range, ~] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeaturesCurrent, selFeatures, 0.25, patRec, plotFlag);
        end
        for trainingData = 1:numSubjects
            for crossIndx = 1:5
                sigFeatures2 = sigFeatures; % test subject
                indTest = ((crossIndx - 1)*sigFeatures.nDataPerSubject(crossIndx) + 1):(crossIndx*sigFeatures.nDataPerSubject(crossIndx));
                sigFeatures2.nDataPerSubject = sigFeatures.nDataPerSubject(crossIndx);
                sigFeatures2.transFeatures = sigFeatures.transFeatures(indTest,:);
                transSets = []; transOuts = []; threshold = zeros(1,trainingData); midRange = zeros(trainingData,size(features(1).data,2)); range = zeros(trainingData,size(features(1).data,2));
                for train = 1:trainingData
                    transSets = [transSets; features(train).data];
                    transOuts = [transOuts; features(train).out];
                    threshold(train) = features(train).threshold;
                    midRange(train,:) = features(train).midRange;
                    range(train,:) = features(train).range;
                end
                patRec.threshold = median(threshold);
                midV = median(midRange,1); rangeV = median(range,1);
                autoscale = false;
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, autoscale);
                patRec.alg = alg;
                [transTSets, transTOuts] = GetPeaks(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midV, rangeV, 0);
                numPeaks = [numPeaks, size(transTSets,1)];
                [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
            end
        end
        
    elseif strcmp(patRec.topology,'Crossvalidation leave-one-subject-out individual threshold')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % for every subject we find the optimal threshold (including the
        % test subject)
        perf = struct([]);
        numSubjects = length(sigFeatures.nDataPerSubject);
        for ind = 1:length(sigFeatures.nDataPerSubject)
            indCurrent = ((ind - 1)*sigFeatures.nDataPerSubject(ind) + 1):(ind*sigFeatures.nDataPerSubject(ind));
            sigFeaturesCurrent = sigFeatures;
            sigFeaturesCurrent.transFeatures = sigFeatures.transFeatures(indCurrent,:);
            [features(ind).data, features(ind).out, features(ind).threshold, features(ind).midRange, features(ind).range, ~] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeaturesCurrent, selFeatures, 0.25, patRec, plotFlag);
        end
        for trainingData = 1:(numSubjects - 1)
            for crossIndx = 1:numSubjects
                indTrain = setdiff(1:numSubjects,crossIndx);
                indTrain = indTrain(1:trainingData);
                transSets = []; transOuts = [];
                for train = 1:trainingData
                    transSets = [transSets; features(indTrain(train)).data];
                    transOuts = [transOuts; features(indTrain(train)).out];
                end
                autoscale = false;
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, autoscale);
                patRec.alg = alg;
                transTSets = features(crossIndx).data;
                transTOuts = features(crossIndx).out;
                [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
            end
        end

    elseif strcmp(patRec.topology,'Crossvalidation leave-one-fold-out') 
        rng(0);
        perf = struct([]);
%         remove = [3, 6]; removeInd = []; removeIndNoise = [];
%         for r = 1:length(remove)
%             removeInd = [removeInd, ((remove(r) - 1)*sigFeatures.nDataPerSubject(1) + 1):(remove(r)*sigFeatures.nDataPerSubject(1))];
%             removeIndNoise = [removeIndNoise, ((remove(r)-1)*noiseDataPerSub + 1):remove(r)*noiseDataPerSub];
%         end
%         subjects = setdiff(1:size(sigFeatures.transFeatures,1),removeInd);
%         noiseSub = setdiff(1:size(sigFeatures.ramp.minData,1),removeIndNoise);
%         sigFeatures.nDataPerSubject = sigFeatures.nDataPerSubject(1:(6 - length(remove)));
%         sigFeatures.transFeatures = sigFeatures.transFeatures(subjects,:);
%         sigFeatures.ramp.minData = sigFeatures.ramp.minData(noiseSub,:);
        % checking if data that you loaded has multiple subjects or not
        if isfield(sigFeatures,'nDataPerSubject')
            itter = length(sigFeatures.nDataPerSubject);
            noiseDataPerSub = size(sigFeatures.ramp.minData,1)/length(sigFeatures.nDataPerSubject);
        else
            itter = 1;
        end
%         [~, ~, ~, ~, ~, ~, ~] = GetSets_Stack_TransientMov_Luis(sigFeatures, selFeatures, 0.25, patRec, plotFlag, propRatio); %AM 20180921
        realOut = [];
        waitNextPeak = 0.7; % for ODA, what percentage of window to wait until it is time to find the next peak
        diffForcePresent = 0; % for differences in data (if 1 data is from WiFiMioHand, if it is 0 it is some other data)
        nR = CVFeatures.testData; % number of repetitions per movement used for testing
        nRTr = sigFeatures.nR - nR; % number of repetitions per movement for training
        samplesPerRep = floor((repetitionTime)*sigFeatures.sF/(sigFeatures.wOverlap*sigFeatures.sF));
        timesOverlap = sigFeatures.tW/sigFeatures.wOverlap - 1;
        nData = samplesPerRep - timesOverlap;
        patRec.crossValParam.nData = nData;
        patRec.crossValParam.samplesPerRep = samplesPerRep;
        reduceCh = [];%[2 4 6 8]; % channels you would like to remove (if you don't want remove any put [])
        clockwise = 1; % which way you shift the electrodes (0 or 1)
        posteriorProbability = 0;
        gestureDistrict = 0;
        for subject = 1:itter
            sigFeaturesSubject = sigFeatures;
            % taking data from one subject
            if isfield(sigFeatures,'nDataPerSubject')
                indTest = (sum(sigFeatures.nDataPerSubject(1:(subject - 1))) + 1):sum(sigFeatures.nDataPerSubject(1:(subject)));
                sigFeaturesSubject.transFeatures = sigFeatures.transFeatures(indTest,:);
                if diffForcePresent
                    sigFeaturesSubject.ramp.minData = sigFeatures.ramp.minData{subject};
                else
                    sigFeaturesSubject.ramp.minData = sigFeatures.ramp.minData((1:noiseDataPerSub)+(subject-1)*noiseDataPerSub,:);
                end
            end
            nDataSS = floor(size(sigFeaturesSubject.trSSFeatures,1)/sigFeaturesSubject.nR);
%             nData = ceil(size(sigFeaturesSubject.transFeatures,1)/sigFeaturesSubject.nR); % length of one movement
%             nData = floor(size(sigFeaturesSubject.transFeatures,1)/sigFeaturesSubject.nR); % length of one movement
            sigFeaturesSubject.nR = nR;
            for crossIndx = 1:(sigFeatures.nR/nR) % Begining of cross-validation
                sigFeatures1 = sigFeaturesSubject; % training data
                sigFeatures2 = sigFeaturesSubject; % test data
                sigFeatures2.nR = sigFeaturesSubject.nR;
                sigFeatures1.nR = nRTr;
                if diffForcePresent
                    tIndx = reshape((0:(5*samplesPerRep):(sigFeatures.nR-1)*samplesPerRep) + (1:nData)',1,nData*nR) + (crossIndx - 1)*samplesPerRep;
                else
                    tIndx = (1:nR*nData) + (crossIndx - 1)*nR*nData; % test data indeces
                    tSSIndx = (1:nR*nDataSS) + (crossIndx - 1)*nR*nDataSS;
                    tIndx(tIndx > size(sigFeaturesSubject.transFeatures,1)) = [];
                    tSSIndx(tSSIndx > size(sigFeaturesSubject.trSSFeatures,1)) = [];
                end
%                 tIndx = reshape((0:(5*nData):(sigFeatures.nR-1)*nData) + (1:nData)',1,nData*nR) + (crossIndx - 1)*nData;
                trIndx = setdiff(1:size(sigFeaturesSubject.transFeatures,1),tIndx); % training data indeces
                trSSIndx = setdiff(1:size(sigFeaturesSubject.trSSFeatures,1),tSSIndx);
                % downsampling the training data (if needed)
%                 rng(0);
%                 trIndx = downsampleRepetitions(trIndx,sigFeatures.nR - nR,nRTr,nData);
                sigFeatures2.transFeatures = sigFeaturesSubject.transFeatures(tIndx,:);
                sigFeatures2.tSSFeatures   = sigFeaturesSubject.trSSFeatures(tSSIndx,:);
                sigFeatures1.transFeatures = sigFeaturesSubject.transFeatures(trIndx,:);
                sigFeatures1.trSSFeatures = sigFeaturesSubject.trSSFeatures(trSSIndx,:);
                
                % obtaining transient infomation for test and training data
                if strcmp(alg,'SVMt')
                    if diffForcePresent
                        [cvSets, cvOuts, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition1(sigFeatures1, selFeatures, 0.25, patRec, plotFlag, waitNextPeak); % training transient
                    else
                        [cvSets, cvOuts, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeatures1, selFeatures, 0.25, patRec, plotFlag, waitNextPeak); % training transient
                    end
                    [cvTSets, cvTOuts] = GetPeaks(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV, waitNextPeak); % test transient
                else
                    [cvSets, cvOuts] = GetSets_Stack_CV(sigFeatures1, selFeatures);
                    [cvTSets, cvTOuts] = GetSets_Stack_CV(sigFeatures2, selFeatures);
                    [cvSets, ~, patRec] = NormalizeSets_TrV(normSetsType, cvSets, [], patRec); 
                    
                end
                [realOut(end+1).out,~] = find(cvTOuts');
                if ~isempty(reduceCh) % in case you want to reduce the number of channels
                    cvSets = electrodeShift(cvSets,length(sigFeatures.nCh),clockwise,reduceCh);
                    cvTSets = electrodeShift(cvTSets,length(sigFeatures.nCh),clockwise,reduceCh);
                end
                
                if gestureDistrict
                    [cvOuts, cvTOuts, patRec] = gestureDistrictOuts(cvsOuts,cvTOuts,patRec);
                end
        
                % training the model
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, cvSets, cvOuts, false);
                patRec.alg = alg;
                % testing the model
                if posteriorProbability
                    patRec.patRecTrained.posteriorProbability = posteriorProbability;
                    for mov = 1:(patRec.nM - 1)
                        svmModel = patRec.patRecTrained.SVM{mov};
                        rng(0);
                        svmModel = fitPosterior(svmModel);
                        patRec.patRecTrained.SVM{mov} = svmModel;
                    end
                end
               [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, cvTSets, cvTOuts, confMatFlag);
            end
        end
        
    elseif strcmp(patRec.topology,'CVLORO4 with electrode shift') 
%         rng(0);
        flag_CCA  = strcmp(patRec.transAlg,'Canonical correlation analysis');
        flag_SA = strcmp(patRec.transAlg,'Subspace alignment');
        perf = struct([]);
        % checking if data that you loaded has multiple subjects or not
        if isfield(sigFeatures,'nDataPerSubject')
            itter = length(sigFeatures.nDataPerSubject);
        else
            itter = 1;
        end
        clockwise = 0; % direction of shift of the electrodes (0 or 1)
        dataExtension = 13; % number of repetitions to which you want to extend the training and calibration data (for CCA)
        nR = 4; % number of repetitions per movement used for testing
        nRCal = 3; % number of repetitions per movement for calibration
        nRTr = 13; % number of repetitions per movement for training
        reduceCh = [];%[2 4 6 8]; % channels that you want to remove (if you don't want remove any put [])
        for subject = 1:itter
            sigFeaturesSubject = sigFeatures;
            % taking data from one subject
            if isfield(sigFeatures,'nDataPerSubject')
            indTest = (sum(sigFeatures.nDataPerSubject(1:(subject - 1))) + 1):sum(sigFeatures.nDataPerSubject(1:(subject)));
            sigFeaturesSubject.transFeatures = sigFeatures.transFeatures(indTest,:);
            end
            nData = fix(size(sigFeaturesSubject.transFeatures,1)/sigFeaturesSubject.nR); % length of one movement
            sigFeaturesSubject.nR = nR;
            for crossIndx = 1:(sigFeatures.nR/nR) % Begining of the cross-validation
                sigFeaturesTr = sigFeaturesSubject; % training data
                sigFeaturesTs = sigFeaturesSubject; % test data
                sigFeaturesCal = sigFeaturesSubject; % calibration data
                sigFeaturesTs.nR = sigFeaturesSubject.nR;
                sigFeaturesCal.nR = nRCal;
                sigFeaturesTr.nR = sigFeatures.nR - nRCal - nR;
                tIndx = (1:nR*nData) + (crossIndx - 1)*nR*nData; % test data indeces
                trIndx = setdiff(1:size(sigFeaturesSubject.transFeatures,1),tIndx); % training data indeces
                % choosing the calibration data
                rng(0);
                rp = randperm(sigFeatures.nR-nR,nRCal);
                indTrInd = (1:nData) + nData.*(rp' - 1);
                indTrInd = reshape(indTrInd',1,nRCal*nData);
                calIndx = trIndx(indTrInd); % calibration data indeces
                trIndx = trIndx(setdiff(1:length(trIndx),indTrInd));
                sigFeaturesTs.transFeatures = sigFeaturesSubject.transFeatures(tIndx,:);
                sigFeaturesTr.transFeatures = sigFeaturesSubject.transFeatures(trIndx,:);
%                 sigFeaturesTr.transFeatures = sigFeaturesSubject.transFeatures(trIndx(1:length(trIndx)/13*nRTr),:);
%                 sigFeaturesTr.nR = sigFeaturesTr.nR/13*nRTr;
                sigFeaturesCal.transFeatures = sigFeaturesSubject.transFeatures(calIndx,:);
                
                % getting transient data for training, calibration and test
                % data
                [transSets, transOuts, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeaturesTr, selFeatures, 0.25, patRec, plotFlag); %AM 20180921
                [transCalSets, transCalOuts] = GetPeaks(sigFeaturesCal, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV);
                [transTsSets, transTsOuts] = GetPeaks(sigFeaturesTs, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV);
                
                if ~isempty(reduceCh) % in case you want to remove some channels
                    transSets = reduceChannels(transSets,length(sigFeatures.nCh),reduceCh);
                end
                % shifting electrodes of calibration and test data
                transCalSets = electrodeShift(transCalSets,length(sigFeatures.nCh),clockwise,reduceCh);
                transTsSets = electrodeShift(transTsSets,length(sigFeatures.nCh),clockwise,reduceCh);
                
                if flag_CCA
%                     indCCA = reshape(((1:5) + 10*(0:7)')',1,5*8);
%                     transSetsCCA = transSets(indCCA,:);
                    transCalSetsCCA = [];
                    transSetsCCA = [];
%                     indCCA = [];
%                     indCCAc = [];
                    for c = 1:(patRec.nM - 1)
                        movInd = find(transCalOuts(:,c));
                        movIndTr = find(transOuts(:,c));
%                         if (length(movInd)<=length(movIndTr))
%                             indCCA = [indCCA; movIndTr(1:length(movInd))];
%                             indCCAc = [indCCAc; movInd];
%                         else
%                             indCCA = [indCCA; movIndTr];
%                             indCCAc = [indCCAc; movInd(1:length(movIndTr))];
%                         end
                        newData = [];
                        newDataTr = [];
                        for f = 1:size(transSets,2)
                            newData = [newData, SMOTE(transCalSets(movInd,f),sum(transCalOuts(movInd,:),2), length(find(transOuts(:,c))), 2)]; % dataExtension
                            if (dataExtension > sigFeaturesTr.nR)
                                newDataTr = [newDataTr, SMOTE(transSets(movIndTr,f),sum(transOuts(movIndTr,:),2),dataExtension, 2)];
                            else
                                newDataTr = [newDataTr, transSets(movIndTr,f)];
                            end
                        end
                        transCalSetsCCA = [transCalSetsCCA; newData];
                        transSetsCCA = [transSetsCCA; newDataTr];
                    end
%                     transCalSetsCCA = transCalSets(indCCAc,:);
%                     transSetsCCA = transSets(indCCA,:);
%                     [~, Ats] = CCA(transCalSetsCCA, transSetsCCA);
                    [transSetsCCA,Atr] = CCA(transSetsCCA,transCalSetsCCA);
%                     transOutsCCA = createOuts(dataExtension, patRec.nM - 1);
                    transSets = transSets*Atr;
                    transTsSets = transTsSets*Ats;
                    transCalSets = transCalSets*Ats;
                elseif flag_SA
                    [Atr, Ats] = SubspaceAlignment(transSets, transCalSets, size(transSets,2));
                    transSets = transSets*Atr;
%                     transCalSets = transCalSets*Ats;
%                     transTsSets = transTsSets*Ats;
                end
                transSets = [transSets; transCalSets];
                transOuts = [transOuts; transCalOuts];
                % training the model
                patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, false);
                patRec.alg = alg;
                % testing the model
               [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTsSets, transTsOuts, confMatFlag);
            end
        end
       
    elseif strcmp(patRec.topology,'Crossvalidation for force estimation')
        % Only one movement is inspected at the time. The chosen movement
        % is extracted from all of the data, and the new data is relabeled
        % so that the classes indicate the force level
        rng(0);
        perf = struct([]);
        samplesPerRep = (repetitionTime)*sigFeatures.sF/(sigFeatures.wOverlap*sigFeatures.sF);
        timesOverlap = sigFeatures.tW/sigFeatures.wOverlap - 1;
        nData = samplesPerRep - timesOverlap;
        patRec.crossValParam.nData = nData;
        patRec.crossValParam.samplesPerRep = samplesPerRep;
        movementToObserve = 6;
        sigFeatures.nR = 5;
        forceLevels = 3;
        dataToObserve = sigFeatures.transFeatures(:,movementToObserve);
        dataPerForceLevel = size(dataToObserve,1)/forceLevels;
        for fL = 1:forceLevels
            idx = (1:dataPerForceLevel) + (fL-1)*dataPerForceLevel;
            if (fL == 1)
                newData = dataToObserve(idx);
            else
                newData(:,fL) = dataToObserve(idx);
            end
        end
        sigFeatures.transFeatures = newData;
        sigFeatures.mov = {'Low level';'Medium level';'High level';'Rest'};
        patRec.nM = size(sigFeatures.mov,1);
        patRec.mov = sigFeatures.mov;
        nR = 1;
        nRTr = sigFeatures.nR - nR;
        for crossIndx = 1:(sigFeatures.nR/nR) % Begining of cross-validation
            sigFeatures1 = sigFeatures; % training data
            sigFeatures2 = sigFeatures; % test data
            sigFeatures2.nR = nR;
            sigFeatures1.nR = nRTr;
            tIndx = (1:nR*nData) + (crossIndx - 1)*nR*samplesPerRep; % test data indeces
            trIndx = setdiff(1:size(sigFeatures.transFeatures,1),tIndx); % training data indeces
            sigFeatures2.transFeatures = sigFeatures.transFeatures(tIndx,:);
            sigFeatures1.transFeatures = sigFeatures.transFeatures(trIndx,:);
            
            % obtaining transient infomation for test and training data
            [transSets, transOuts, patRec.threshold, midRangeValue, rangeValue, NoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeatures1, selFeatures, 0.25, patRec, plotFlag); % training transient
            [transTSets, transTOuts] = GetPeaks(sigFeatures2, selFeatures, 0.25, patRec, plotFlag, patRec.threshold, midRangeValue, rangeValue, NoiseMAV); % test transient

            % training the model
            patRec.patRecTrained = OfflinePatRecTraining(alg, tType, algConf, trSets, trOuts, vSets, vOuts, sigFeatures.mov, movIdx, transSets, transOuts, false);
            patRec.alg = alg;
            [perf(end + 1).performance perf(end + 1).confMat perf(end + 1).tTime] = Accuracy_patRec(patRec, transTSets, transTOuts, confMatFlag);
        end

    else
        disp('Select topology');
        return;                
    end
    
    % Compute training/validation time.
    patRec.trTime = toc(trStart);
    
    %% Test accuracy of the patRec
    if (~contains(patRec.topology,"Crossvalidation")&&(~contains(patRec.topology,'CVLORO4')))
        patRec.alg = alg; % AM 20180921
        [performance confMat tTime] = Accuracy_patRec(patRec, tSets, tOuts, confMatFlag);
        patRec.tTime = tTime;
        %% Final data to the patRec
        patRec.performance  = performance;
        patRec.confMat      = confMat;
        patRec.date         = fix(clock);
        patRec.indMovIdx    = movIdx;
        patRec.nOuts        = size(movIdx,2);
        patRec.control.maxDegPerMov = ones(1,patRec.nOuts);
    else
%         save('peakNumber','numPeaks');
        patRec.tTime = perf.tTime;
        acc = 0; accTrue = 0; precision = 0; recall = 0; f1 = 0; acc_avg =[];
        specificity = 0; npv = 0;
        for i = 1:size(perf,2)
            % obtaining the accuracies for each test subject (or fold)
            %if (~isnan(sum(perf(i).performance.acc)))
                acc = acc + perf(i).performance.acc;
                accTrue = accTrue + perf(i).performance.accTrue;
                precision = precision + perf(i).performance.precision;
                recall = recall + perf(i).performance.recall;
                f1 = f1 + perf(i).performance.f1;
                specificity = specificity + perf(i).performance.specificity;
                npv = npv + perf(i).performance.npv;
                acc_avg = [acc_avg, perf(i).performance.acc];
            %end
        end
        save('accuracies','acc_avg');
        performance = struct;
        performance.acc = acc./size(perf,2);
        performance.accTrue = accTrue./size(perf,2);
        performance.precision = precision./size(perf,2);
        performance.recall = recall./size(perf,2);
        performance.f1 = f1./size(perf,2);
        performance.specificity = specificity./size(perf,2);
        performance.npv = npv./size(perf,2);
        patRec.performance  = performance;
        patRec.confMat      = perf.confMat;
        patRec.date         = fix(clock);
        patRec.indMovIdx    = movIdx;
        patRec.nOuts        = size(movIdx,2);
        patRec.control.maxDegPerMov = ones(1,patRec.nOuts);
%         confMat = zeros(size(perf(1).confMat));
%         for i = 1:length(perf) % combining all the confusion matrices into one
%             if(~isnan(sum(sum(perf(i).confMat))))
%                 confMat = confMat + perf(i).confMat;
%             end
%         end
        confMat = zeros(size(perf(i).confMat,1),size(perf(i).confMat,2));
        confMat1 = [];
        prediction = [];
        for i = 1:length(perf) % combining all the confusion matrices into one
            confMat1 = [confMat1; perf(i).confMat];
            confMat = confMat + perf(i).confMat;
            prediction(i).fold = perf(i).performance.prediction;
        end
        save('cm','confMat1');
        save('score','score');
        save('prediction','prediction');
        if (exist('realOut'))
            save('outs','realOut');
        end
        for i = 1:length(patRec.patRecTrained.SVM)
            disp(size(patRec.patRecTrained.SVM{i}.SupportVectors))
        end
    end   
    if confMatFlag
        figure;
        imagesc(confMat);
        title('Confusion Matrix')
        xlabel('Movements');
        ylabel('Movements');
    end
    % change the patRec.patRecTrained part and add the normalization
    % parameters to the structure
    if isfield(patRec.patRecTrained,'SVM')
        for i = 1:length(patRec.patRecTrained.SVM)
            disp(size(patRec.patRecTrained.SVM{i}.SupportVectors))
        end
    end

    if isfield(patRec,'dThreshold') && isfield(patRec,'threshold')
        dThreshold = patRec.dThreshold;
        threshold = patRec.threshold;
        save('ODAthreshold','dThreshold','threshold');
    end
end

