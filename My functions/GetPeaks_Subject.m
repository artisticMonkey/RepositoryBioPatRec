% Function to be use on a test set.
% Getting peaks from the test set using the parameters from the training
% set (threshold and noise value)
% GetPeaks_Subject is to be used for leave-one-subject-out crossvalidation,
% due to the normalization within the subject

function [transientSet, transientOut] = GetPeaks_Subject(sigFeatures, features, transLength, patRec, plotFlag, threshold, dNoiseMAV)

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
%     meanValue = mean(transientSet,1);
%     stdValue = std(transientSet,1);
%     transientSet = (transientSet - meanValue)./stdValue;
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

len = sum(transientOut(:,nMi));
minDist = 0.7*(len/sigFeatures.nR);
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
        %plotNoise = line([0 length(onsetSig)],[dNoiseMAV dNoiseMAV],'color','y');
    ylim([0 max(onsetSig)]);
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
    transient = reshape(transient, 1, []);
    transData(onsIdx, :) = transient;
    transLabel(onsIdx, :) = transientOut(onsets(onsIdx),:);
end

transientSet = transData;
transientOut = transLabel;

end