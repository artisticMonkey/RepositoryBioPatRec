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

function [trSet, trOut, tSet, tOut, movIdx, movOutIdx] = GetSets_Stack_IndvMov_Transient(sigFeatures, features, transLength)

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

n = 1;
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
    maxCh(j,:) = max(transientSet(n:r+n-1,:),[],1);
    n = n+r;
end

% nWins = 1;
% if transLength < sigFeatures.tW
%     warning(fprintf('Length of transient larger then desired due to feature window length of %f seconds.', sigFeatures.tW));
% else
%     nWins = nWins + floor((transLength - sigFeatures.tW) / (sigFeatures.tW - sigFeatures.wOverlap));
% end
% 
% transData = zeros(numel(onsets), size(transientSet,2) * nWins);
% transLabel = zeros(numel(onsets),size(transientOut,2));
% for onsIdx = 1:numel(onsets)
%     transient = transientSet(onsets(onsIdx) + (1:nWins), :);
%     transient = reshape(transient, 1, []);
%     transData(onsIdx, :) = transient;
%     transLabel(onsIdx, :) = transientOut(onsets(onsIdx),:);
% end
% 
% %% AM 20180921
% % train_using_all = true;
% train_using_all = false;
% 
% if (sigFeatures.nR<10)
%     nTest = 2;
% else
% %     nTest = 2;
%     nTest = 5;
% %     nTest = 7;
% %     nTest = 10;
% %     nTest = 15;
% end
% % testId = randperm(sigFeatures.nR)-1;
% % testId = testId(1:nTest);
% testId = (0:nTest-1);
% 
% if train_using_all
%     indTest = 1:numel(onsets);
%     indTrain = 1:numel(onsets);
% else % leave out an example for testing for each movement
%     indTest = floor(sigFeatures.nR/2):sigFeatures.nR:numel(onsets); %repetitions in the end
%     indTest = -testId'+indTest;
%     indTest = sort(indTest(:))';
%     indTrain = setdiff(1:numel(onsets),indTest);
% end
% 
% transientSet = transData(indTrain,:);
% transientOut = transLabel(indTrain,:);
% transientTSet = transData(indTest,:);
% transientTOut = transLabel(indTest,:);

dataSize = size(sigFeatures.transFeatures,1);
nR = sigFeatures.nR;
nRTest = 5;
oneRepetition = floor(dataSize/nR);
indTestData = (1:oneRepetition*nRTest)' + (dataSize*(0:(nMi - 1)));
indTestData = reshape(indTestData,1,oneRepetition*nRTest*nMi);
indTrainingData = setdiff(1:length(transientOut),indTestData);

trSet = transientSet(indTrainingData,:);
trOut = transientOut(indTrainingData,:);
tSet = transientSet(indTestData,:);
tOut = transientOut(indTestData,:);


% indTest = floor(sigFeatures.nR/2):sigFeatures.nR:numel(onsets); %repetitions in the end
% %     indTest = 1:sigFeatures.nR:numel(onsets);
%     indTest = testId' + indTest;
%     indTest = sort(indTest(:))';
%     indTrain = setdiff(1:numel(onsets),indTest);


