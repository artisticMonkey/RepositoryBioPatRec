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

function [trSSSet, trSSOut] = GetSets_Stack_CV(sigFeatures, selFeatures)
features = selFeatures;
%Variables
movIdx    = [];
movIdxMix = [];

% Find the mixed movements by looking for "+"
% use of a temporal index to match the output, this assumes that the order
% of the output is the same as the order of the movements 
tempIdx = 1;
for i = 1 : size(sigFeatures.mov,1)
    if isempty(strfind(sigFeatures.mov{i},'+'))
        movIdx = [movIdx i];
        movOutIdx{i} = tempIdx;  % Index for the output of each movement
        tempIdx = tempIdx + 1;
    else
        movIdxMix = [movIdxMix i];
    end
end

nMi   = size(movIdx,2);           % Number of movements individuals
nMm   = size(movIdxMix,2);        % Number of movements mixed

trSSSets = size(sigFeatures.trSSFeatures,1);


NtrSSSet = trSSSets * nMi;

trSSSet = zeros(NtrSSSet, length(features));

trSSOut = zeros(NtrSSSet, nMi);

% Stack data sets for individual movements

for j = 1 : nMi
    e = movIdx(j);
    % Training
    for r = 1 : trSSSets
        sidx = r + (trSSSets*(j-1));
        li = 1;
        for i = 1 : length(features)
            le = li - 1 + length(sigFeatures.trSSFeatures(r,e).(features{i}));
            trSSSet(sidx,li:le) = sigFeatures.trSSFeatures(r,e).(features{i}); % Get each feature per channel
            li = le + 1;
        end
        trSSOut(sidx,j) = 1;
    end
end
% maxValue = max(trSSSet);
% minValue = min(trSSSet);
% rangeValue = maxValue - minValue;
% midRangeValue = (maxValue + minValue)/2;
% trSSSet = (trSSSet - midRangeValue) ./ (rangeValue/2);


% meanValue = mean(trSSSet,1);
% stdValue = std(trSSSet,1);
% trSSSet = (trSSSet - meanValue)./stdValue;
% meanSS = meanValue;
% stdSS = stdValue;