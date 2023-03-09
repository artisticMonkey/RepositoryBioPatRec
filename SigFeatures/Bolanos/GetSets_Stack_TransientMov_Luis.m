% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authorsí contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum effort sto improve 
% amputeesí quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% ------------- Function Description -------------
% This function will create matrices of training, validation and test sets
% - All movements will be STACK one over each other, this is, each set of
% movements will be the row and the colums are made of the features.
% - The number of columbs is given by the nuber of channels times the
% features
% - The value of the first features in each channel is then follow for the
% value of the second features in each channel and so on. 
%
% NOTE: The main difference with GetSets_Stack is that the mixed movements 
% are only considered in the testing set
%
% input:   trFeatures contains the splitted data, is a Nsplits x Nexercises structure matrix
%          vFeatures is similar to trFeatures 
%          features contains the name of the charactaristics to be used
% output:  trsets are the normalized training sets
%          vsets are the normalized validation sets
%          trOut contains the correspondet outputs
%          vOut contains the correspondet outputs
%
% ------------- Updates -------------
%  2011-10-03 / Max Ortiz / Created
% 20xx-xx-xx / Author  / Comment on update

function [transientSet, transientOut, threshold, maxVals, transientTSet, transientTOut, patchPropChannels] = GetSets_Stack_TransientMov(sigFeatures, features, transLength, patRec, plotFlag, propRatio)

global onThrCoeff ;

%Variables
movIdx    = [];
movIdxMix = [];
% Find the mixed movements by looking for "+"
% use of a temporal index to match the output, this assumes that the order
% of the output is the same as the order of the movements 
tempIdx = 1;
restIdx = 0;
for i = 1 : size(sigFeatures.mov,1)
    if isempty(strfind(sigFeatures.mov{i},'+'))
        if strcmp(sigFeatures.mov{i}, 'Rest')
            restIdx = i;
        end
        movIdx = [movIdx i];
        movOutIdx{i} = tempIdx;  % Index for the output of each movement
        tempIdx = tempIdx + 1;
    else
        movIdxMix = [movIdxMix i];
    end
end

nMi   = size(movIdx,2)-1;                       % Number of movements individuals
trSets = size(sigFeatures.transFeatures,1);     % effective number of sets for trainning
Ntrset = trSets * nMi;
transientSet = zeros(Ntrset, length(features));
transientOut = zeros(Ntrset, nMi);

% Stack data sets for individual movements
for j = 1 : nMi
    e = movIdx(j);
    % Transient
    transLen = size(sigFeatures.transFeatures ,1);
    for r = 1 : transLen
        sidx = r + (transLen*(j-1));
        li = 1;
        for i = 1 : length(features)
            le = li - 1 + length(sigFeatures.transFeatures(r,e).(features{i}));
            transientSet(sidx,li:le) = sigFeatures.transFeatures(r,e).(features{i}); % Get each feature per channel
            li = le + 1;
        end
        transientOut(sidx,j) = 1;
    end
end

% normalize dataset
origDataSet = transientSet;
try
for rowIdx = 1:size(transientSet,1)
    transientSet(rowIdx,:) = NormalizeSet(transientSet(rowIdx,:), patRec);
end
catch ex
    throw(ex);
end

mavIdx = find(cellfun(@(x) strcmp(x,'tmabs'), features),1,'first');
if isempty(mavIdx)
    mavIdx = find(cellfun(@(x) strcmp(x,'tmabsTr1'), features),1,'first'); 
end

% mavChIdx = (mavIdx-1) * sigFeatures.nCh + sigFeatures.nCh;  % BACO CORRETTO 20190116, works only if mav is the first feature
mavChIdx = ((mavIdx-1) * length(sigFeatures.nCh) +1): (mavIdx) * length(sigFeatures.nCh);
if isfield(patRec,'magnetData')
    if (length(patRec.magnetData.Features)==2)
        mavChIdx = mavChIdx(1):2:mavChIdx(end);
    end
end
patchPropChannels = zeros(patRec.nM-1,length(mavChIdx));       % channels that pass the selection
% onsetSig = smooth(mean(transientSet(:,mavChIdx),2),13);
onsetSig = mean(transientSet(:,mavChIdx),2);
onsetSig_to_plot = onsetSig;
onsetSig = high_pass(onsetSig);


% Filtering and subsampling of rest state
rampFlag = 1;
try
    minRampMAV = abs(patRec.control.rampTrainingData.ramp.minData);
    a = 1;
    b = 1/50.*ones(50,1)';
    minRampMAV = filter(b,a,minRampMAV);
    minRampMAV = downsample(minRampMAV,25);
    
    minFeatSet = min(origDataSet(:,1:sigFeatures.nCh(end)));
    maxFeatSet = max(origDataSet(:,1:sigFeatures.nCh(end)));
    scaledMinRamp = 2*(minRampMAV - minFeatSet)./(maxFeatSet - minFeatSet) - 1;
    dminRampMAv = high_pass(scaledMinRamp);
    if isfield(sigFeatures.ramp,'maxData')
        maxRampMAV = abs(sigFeatures.ramp.maxData);
        maxRampMAV = filter(b,a,maxRampMAV);
        maxRampMAV = downsample(maxRampMAV,25);
    end
%     dNoiseMAV = 3*std(dminRampMAv(10:end-10))  %DD 2019/11/11 - noise of dMAV at rest
   dNoiseMAV = 6*std(mean(dminRampMAv(10:end-10,:),2))+mean(mean(dminRampMAv(10:end-10,:),2))  %DD 2019/11/11 - noise of dMAV at rest
%     dNoiseMAV = 6*std(mean(scaledMinRamp(10:end-10,:),2))+mean(mean(scaledMinRamp(10:end-10,:),2))

%     dataPerRep = floor(size(transientSet,1)/nMi/sigFeatures.nR);
%     idxNoise = (dataPerRep-50):(dataPerRep-20);
%     dNoiseMAV = zeros(1,nMi);
%     for i = 1:nMi
%         for j = 1:sigFeatures.nR
%             idxNoiseMov = (idxNoise + (j-1)*dataPerRep) + (i-1)*size(transientSet,1)/nMi;
%             minRampMAV = transientSet(idxNoiseMov,mavChIdx);
%             dminRampMAV = high_pass(minRampMAV);
%             dNMAV(j) = 6*std(mean(dminRampMAV,2))+mean(mean(dminRampMAV,2));
%         end
%         dNoiseMAV(i) = mean(dNMAV);
%     end
%     dNoiseMAV = max(dNoiseMAV)
catch
    rampFlag = 0;
    dNoiseMAV = 0;
end

thrVals = [];
maxVals = [];
for j = 1 : nMi
    len = sum(transientOut(:,j));
    sig = onsetSig(logical(transientOut(:,j)));
    sig = smooth(sig,3); % smooth MAV j movement
    sig(1:5) = 0; % AM 20190117
%     minDist = 0.85*(len/sigFeatures.nR);
   minDist = 0.6*(len/sigFeatures.nR);
    [pks,~] = findpeaks( sig, 'MinPeakDistance', minDist, 'SortStr', 'descend', 'NPeaks', sigFeatures.nR);
%     pks = pks.*(pks<dNoiseMAV);
    pks(find(pks<dNoiseMAV)) = pks(find(pks<dNoiseMAV))+100;
%     thrVals(1,j) = min(pks); % min of peaks for j movement
    thrVals(1,j) = median(pks); % min of peaks for j movement - DD 2019/11/11 increase robustness against low noise peaks
    
    nIt = 800;
    res = zeros(nIt,2);
%     res(:,1) = linspace(0, thrVals(1,j), nIt)'; %From 0 instead of min(sig) becuase it's the derivative. Creating 200 thresholds from -1 to min peak of j movement
    if rampFlag
        res(:,1) = linspace(dNoiseMAV, thrVals(1,j), nIt)'; %From "dNoise" instead of min(sig) becuase it's the derivative. Creating 200 thresholds from -1 to min peak of j movement
    else
        res(:,1) = linspace(0, thrVals(1,j), nIt)'; %From 0 instead of min(sig) becuase it's the derivative. Creating 200 thresholds from -1 to min peak of j movement
    end
    for i = 1:nIt
        if sig(1) < res(i,1)                                    % the testing threshold has to be higher than -1
            [~,pos,width] = findpeaks( double(sig > res(i,1))); % find peaks for signal higher than threshold i
%             [~,pos,width] = findpeaks(double(sig > res(i,1)),'MinPeakDistance', minDist); %Better results for the derivative
            res(i,2) = numel(pos);                              % count found peaks % count found peaks 
            %if  numel(width(width >= 0.10*(len/sigFeatures.nR))) < 3
%             if  sum(width >= 0.10*(len/sigFeatures.nR)) < 3
%                 res(i,2) = 0;
%             end
        end
    end
        
%     if j == 6
%         thrVals(2,j) = min(res(res(:,2) == 7, 1));
%     else
    try
%         Luis code uses max instead of min and uses 0.25 as onThrCoeff
%         thrVals(2,j) = min(res(res(:,2) == sigFeatures.nR, 1)); % finding the min threshold that is able to localize the target onsets 
        thrVals(2,j) = median(res(res(:,2) == sigFeatures.nR, 1)); % finding the min threshold that is able to localize the target onsets 
        nValR = sigFeatures.nR;
        while (isnan(thrVals(2,j)) && (nValR ~= 0))
            nValR = nValR - 1;
            thrVals(2,j) = median(res(res(:,2) == nValR, 1));
        end
%     end  
%         thrVals(2,j) = median(res(res(:,2) == sigFeatures.nR, 1)); % finding the median threshold that is able to localize the target onsets 
    catch
        thrVals(2,j) = NaN;
    end
   
    maxVals(j) = median(sig(sig>thrVals(2,j)));
    
    %subplot(2,2,j); plot(sig,'k-'); hold on; plot(xlim,[thrVals(j) thrVals(j)],'b--'); plot(xlim,[maxVals(j) maxVals(j)],'r--'); hold off;
end

%threshold = max(thrVals(3,:)) + (min(thrVals(1,:)) - max(thrVals(2,:))) * 0.2;
% threshold = min(thrVals(2,:)) + (min(thrVals(1,:)) - max(thrVals(2,:))) * 0.2;
%threshold = max(thrVals(2,:)) + (min(thrVals(1,:)) - max(thrVals(2,:))) *0.1;
% threshold = onThrCoeff*min(thrVals(2,:)); %DD
threshold = onThrCoeff*min(thrVals(2,:)); %LB20190718

[~, onsets] = findpeaks(double(onsetSig > threshold), 'MinPeakDistance', minDist);
nPeaks = numel(onsets)
% check if onsets match number of movements
if numel(onsets) ~= sigFeatures.nR * nMi
    warning('Onset count does not match number of movements!')
end
if plotFlag
    figure; plot(onsetSig_to_plot,'k-'); hold on; plot(repmat(onsets,1,2)',repmat(ylim,numel(onsets),1)','r--'); hold off;
    figure; plotSignal = plot(onsetSig,'k-'); hold on;...
        plotOnsets = plot(repmat(onsets,1,2)',repmat(ylim,numel(onsets),1)','r--'); ...
        plotOnsetThreshold = line([0 length(onsetSig)],[threshold threshold],'color','g');...
        plotNoise = line([0 length(onsetSig)],[dNoiseMAV dNoiseMAV],'color','y');
    ylim([0 max(onsetSig)]);
    for mov = 1:patRec.nM-1
        %if plotFlag
            plotMedian = line([round(length(onsetSig)/nMi)*(mov-1) round(length(onsetSig)/nMi)*mov],[thrVals(1,mov) thrVals(1,mov)],'color','b');
            plotSelectedThreshold = line([round(length(onsetSig)/nMi)*(mov-1) round(length(onsetSig)/nMi)*mov],[thrVals(2,mov) thrVals(2,mov)],'color','c');
        %end
            line([round(length(onsetSig)/nMi)*(mov-1) round(length(onsetSig)/nMi)*mov],[thrVals(1,mov) thrVals(1,mov)],'color','b');
            line([round(length(onsetSig)/nMi)*(mov-1) round(length(onsetSig)/nMi)*mov],[thrVals(2,mov) thrVals(2,mov)],'color','c');
    end
    leg = legend([plotSignal plotOnsets(1) plotOnsetThreshold plotNoise plotMedian],...
        'dEMG envelope','Detected Onsets', 'Onset Threshold', 'Rest Noise', 'Median Peaks');
    hold off;
end

nWins = 1;
if transLength < sigFeatures.tW
    warning(fprintf('Length of transient larger then desired due to feature window length of %f seconds.', sigFeatures.tW));
else
    nWins = nWins + floor((transLength - sigFeatures.tW) / (sigFeatures.tW - sigFeatures.wOverlap));
end
        
transData = zeros(numel(onsets), size(transientSet,2) * nWins);
transLabel = zeros(numel(onsets),size(transientOut,2));
for onsIdx = 1:numel(onsets)
    transient = transientSet(onsets(onsIdx) + (1:nWins), :);
%     transient = transientSet(onsets(onsIdx), :);
    transient = reshape(transient, 1, []);
    transData(onsIdx, :) = transient;
    transLabel(onsIdx, :) = transientOut(onsets(onsIdx),:);
end

%---------Proportional control: choosing the best channels-----------------
if isfield(sigFeatures.ramp,'maxData')
    dataPerMovement = length(onsetSig)/nMi;
    currentPropOut = zeros(size(origDataSet,1),length(mavChIdx));  % variable for regural proportional control (with all channels included)
    proposedPropOut = zeros(size(origDataSet,1),length(mavChIdx)); % variable for proposed proportional control (only selected channels are included)
    % proposedMax = zeros(1,patRec.nM-1);
    for ch = 1:length(mavChIdx)
        for mov = 1:patRec.nM-1
            % finding the derivative of the MVC to know from which point does
            % the contraction start, and then taking the average of MVC from
            % that point (excluding the part of rest)
            dMaxMav = high_pass(maxRampMAV(:,ch,mov));
            [~,dInd] = max(dMaxMav);
            maxRampChMov = mean(maxRampMAV(dInd:end,ch,mov),1);
            movInd = (1:dataPerMovement) + dataPerMovement*(mov-1);
            sigSect = origDataSet(movInd,ch);
            [pks,~] = findpeaks( sigSect, 'MinPeakDistance', minDist, 'SortStr', 'descend', 'NPeaks', sigFeatures.nR);   % find MAV peaks values for j movement
            
            % traditional proportional control (changing the range to [0 1])
            currentPropOut(movInd,ch) = (origDataSet(movInd,ch) - minFeatSet(ch))./(maxRampChMov - minFeatSet(ch));
    
            propMargin = median(pks)/maxRampChMov; % ratio of median peaks and MVC
            % the propRatio does not allow channels with median of peaks close to
            % the MCV to be included in the proportional control
            if propMargin < propRatio   
                patchPropChannels(mov,ch) = 1;
                proposedPropOut(movInd,ch) = currentPropOut(movInd,ch);
            end
    
        end
    end
    
    if plotFlag
    figure('name', 'proposed propotional output');
    proposedPropOut(proposedPropOut == 0) = NaN;
    plot(mean(proposedPropOut,2,"omitnan")); 
    ylim([0, 1.1]);
    end
    % plotting the lines, to be able to differentiate between classes
    for mov = 1:patRec.nM - 1
        if plotFlag
        hold on
        plot([dataPerMovement*mov dataPerMovement*mov],[0 1.1],'k--')
        end
        movInd = (1:dataPerMovement) + dataPerMovement*(mov-1);
        proposedPropOutMov(mov) = mean(mean(proposedPropOut(movInd,:),2,"omitnan"),"omitnan");
    end
    
    if plotFlag
    figure
    imagesc(patchPropChannels);
    xlabel('channels');ylabel('movements');
    end
    patchPropChannels(end+1,:) = 0;
end
%% AM 20180921
% train_using_all = true;
% train_using_all = false;
train_using_all = patRec.trainAll;

% if (sigFeatures.nR<10)
%     nTest = 2;
% else
% %     nTest = 2;
%     nTest = 5;
% %     nTest = 7;
% %     nTest = 10;
% %     nTest = 15;
% end
% testId = randperm(sigFeatures.nR)-1;
% testId = testId(1:nTest);
nTest = patRec.numTestData;
testId = (0:nTest-1);

if train_using_all
    indTest = 1:numel(onsets);
    indTrain = 1:numel(onsets);
else % leave out an example for testing for each movement
%     indTest = floor(sigFeatures.nR/2):sigFeatures.nR:numel(onsets); %repetitions in the end
    indTest = 1:sigFeatures.nR:numel(onsets);
    indTest = testId' + indTest;
    indTest = sort(indTest(:))';
    indTrain = setdiff(1:numel(onsets),indTest);
end

transientSet = transData(indTrain,:);
transientOut = transLabel(indTrain,:);
transientTSet = transData(indTest,:);
transientTOut = transLabel(indTest,:);



