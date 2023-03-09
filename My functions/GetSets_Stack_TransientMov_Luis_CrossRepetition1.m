% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors’ contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum effort sto improve 
% amputees’ quality of life? Join this project! or, send your comments to:
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
function [transientSet, transientOut, threshold, midRangeValue, rangeValue, dNoiseMAV] = GetSets_Stack_TransientMov_Luis_CrossRepetition1(sigFeatures, features, transLength, patRec, plotFlag, varargin)

global onThrCoeff ;
rangeValue = 0;
midRangeValue = 0;
meanValue = 0;
stdValue = 0;
%Variables
movIdx    = [];
movIdxMix = [];

if (length(varargin)==1)
    waitNextPeak = varargin{1};
else
    waitNextPeak = 0.7;
end

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
%     meanValue = mean(transientSet,1);
%     stdValue = std(transientSet,1);
%     transientSet = (transientSet - meanValue)./stdValue;
%     midRangeValue = meanValue;
%     rangeValue = stdValue;
    maxValue = max(transientSet);
    minValue = min(transientSet);
    rangeValue = maxValue - minValue;
    midRangeValue = (maxValue + minValue)/2;
    transientSet = (transientSet - midRangeValue) ./ (rangeValue/2);
% for rowIdx = 1:size(transientSet,1)
%     transientSet(rowIdx,:) = NormalizeSet(transientSet(rowIdx,:), patRec);
% end
% for c = 1:nMi
%     cInd = find(transientOut(:,c) == 1);
%     meanValue = mean(transientSet(cInd,:),1);
%     stdValue = std(transientSet(cInd,:),1);
%     transientSet(cInd,:) = (transientSet(cInd,:) - meanValue)./stdValue;
% end
catch ex
    throw(ex);
end

mavIdx = find(cellfun(@(x) strcmp(x,'tmabs'), features),1,'first');
if isempty(mavIdx)
    mavIdx = find(cellfun(@(x) strcmp(x,'tmabsTr1'), features),1,'first'); 
end

% mavChIdx = (mavIdx-1) * sigFeatures.nCh + sigFeatures.nCh;  % BACO CORRETTO 20190116, works only if mav is the first feature
mavChIdx = ((mavIdx-1) * length(sigFeatures.nCh) +1): (mavIdx) * length(sigFeatures.nCh);

% onsetSig = smooth(mean(transientSet(:,mavChIdx),2),13);
onsetSig = mean(transientSet(:,mavChIdx),2);
onsetSig_to_plot = onsetSig;
onsetSig = high_pass(onsetSig);


% Filtering and subsampling of rest state
rampFlag = 1;
try
    dataPerRep = floor(size(transientSet,1)/nMi/sigFeatures.nR);
    idxNoise = (dataPerRep-50):(dataPerRep-20); % taking the last part of the repetition recording
    dNoiseMAV = zeros(1,nMi);
    for i = 1:nMi
        for j = 1:sigFeatures.nR
            idxNoiseMov = (idxNoise + (j-1)*dataPerRep) + (i-1)*size(transientSet,1)/nMi;
            minRampMAV = transientSet(idxNoiseMov,mavChIdx);
            dminRampMAV = high_pass(minRampMAV);
            dNMAV(j) = 6*std(mean(dminRampMAV,2))+mean(mean(dminRampMAV,2)); % noise level after every repetitions
        end
        dNoiseMAV(i) = mean(dNMAV); % average noise level between contractions of a specific movement
    end
    dNoiseMAV = max(dNoiseMAV) 
catch
    rampFlag = 0;
end

thrVals = [];
maxVals = [];
for j = 1 : nMi
    len = sum(transientOut(:,j));
    sig = onsetSig(logical(transientOut(:,j)));
    sig = smooth(sig,3); % smooth MAV j movement
    sig(1:5) = 0; % AM 20190117
    minDist = waitNextPeak*(len/sigFeatures.nR);
%    minDist = 0.7*(len/sigFeatures.nR);
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
%           thrVals(2,j) = max(res(res(:,2) == sigFeatures.nR, 1));
%         if isnan(thrVals(2,j))
%             thrVals(2,j) = thrVals(1,j);
%         end
        nValR = sigFeatures.nR;
        while (isnan(thrVals(2,j)) && (nValR ~= 0))
            nValR = nValR - 1;
            thrVals(2,j) = median(res(res(:,2) == nValR, 1));
        end
%     end  
%         thrVals(2,j) = median(res(res(:,2) == sigFeatures.nR, 1)); % finding the median threshold that is able to localize the target onsets 
    catch
        thrVals(2,j) = NaN;
%         thrVals(2,j) = thrVals(1,j);
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
    ylim([0 max(onsetSig)]);
    for mov = 1:nMi
        %if plotFlag
            plotNoise = line([round(length(onsetSig)/nMi)*(mov-1) round(length(onsetSig)/nMi)*mov],[dNoiseMAV dNoiseMAV],'color','y');
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



%% AM 20180921
train_using_all = true;
%train_using_all = false;

if (sigFeatures.nR<10)
    nTest = 2;
else
%     nTest = 2;
    nTest = 5;
%     nTest = 7;
%     nTest = 10;
%     nTest = 15;
end
% testId = randperm(sigFeatures.nR)-1;
% testId = testId(1:nTest);
testId = (0:nTest-1);

% if length(varargin) == 1
%     indTest = varargin{1}:sigFeatures.nR:numel(onsets);
%     indTrain = setdiff(1:numel(onsets),indTest);
% else
    if train_using_all
        indTest = 1:numel(onsets);
        indTrain = 1:numel(onsets);
    else % leave out an example for testing for each movement
        indTest = floor(sigFeatures.nR/2):sigFeatures.nR:numel(onsets); %repetitions in the end
        indTest = -testId'+indTest;
        indTest = sort(indTest(:))';
        indTrain = setdiff(1:numel(onsets),indTest);
    end
% end

transientSet = transData(indTrain,:);
transientOut = transLabel(indTrain,:);
transientTSet = transData(indTest,:);
transientTOut = transLabel(indTest,:);



