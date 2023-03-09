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
%  Function to classifies the testing sets
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2014-11-07 / Le Khong     / Creation
% 2015-12-29 / Max Ortiz    / Rename to fit coding standard
% 2018-08-21 / Mannini-Clemente / Created Hand-Wrist version
% 20xx-xx-xx / Author       / Comment on update


function [outMov outVector] = SVMTest_TransHW(patRecTrained, tSet)
svmStruct = patRecTrained.SVM;
nM = size(svmStruct,2);

if size(tSet,1)>1
    error('ERRORE-01 SingleSampleTest: SVMTest_TransHW.m TO BE MODIFIED')
end

labels_w = svmStruct.movIDx_w;
labels_w(labels_w == 0) =15;
labels_w = unique(labels_w);
labels_h = svmStruct.movIDx_h;
labels_h(labels_h == 0) =15;
labels_h = unique(labels_h);

nMw = size(svmStruct.W,2);
nMh = size(svmStruct.H,2);

tSet_start = tSet;

for i = 1:nMw
    tSet = tSet_start;
% % %     outVector(i,1) = svmclassify(svmStruct(i),tSet);
% %     [~,score] = predict(svmStruct{i},tSet);
% %     Scores(:,i) = score(:,2);   
%         
    % scaling (svmtrain-svmclassify)
    if ~isempty(svmStruct.W(i).ScaleData)
        for c = 1:size(tSet, 2)
            tSet(:,c) = svmStruct.W(i).ScaleData.scaleFactor(c) * ...
                (tSet(:,c) +  svmStruct.W(i).ScaleData.shift(c));
        end
    end

    %SVMDECISION Evaluates the SVM decision function
    %   Copyright 2004-2012 The MathWorks, Inc.
    sv = svmStruct.W(i).SupportVectors;
    alphaHat = svmStruct.W(i).Alpha;
    bias = svmStruct.W(i).Bias;
    kfun = svmStruct.W(i).KernelFunction;
    kfunargs = svmStruct.W(i).KernelFunctionArgs;

    f_w(i,:) = (feval(kfun,sv,tSet,kfunargs{:})'*alphaHat(:)) + bias;
     
%     outVector_w(i) = sign(f_w(i,:));
    
end
% outVector_w(outVector_w == 0) = 1; % points on the boundary are assigned to class 1
% outVector_w(outVector_w == -1) = 2;% use "svmclassify.m" convention  

[~, out_oneVSall_w] = min(f_w); % have to use min to deal with MATLAB opposite convention
outClass_w = labels_w(out_oneVSall_w);

% % outMov = find(outVector);
% [~,outMov] = max(Scores,[],2);

for i = 1:nMh
    tSet = tSet_start;
% % %     outVector(i,1) = svmclassify(svmStruct(i),tSet);
% %     [~,score] = predict(svmStruct{i},tSet);
% %     Scores(:,i) = score(:,2);   
% %     
    
    % scaling (svmtrain-svmclassify)
    if ~isempty(svmStruct.H(i).ScaleData)
        for c = 1:size(tSet, 2)
            tSet(:,c) = svmStruct.H(i).ScaleData.scaleFactor(c) * ...
                (tSet(:,c) +  svmStruct.H(i).ScaleData.shift(c));
        end
    end

    %SVMDECISION Evaluates the SVM decision function
    %   Copyright 2004-2012 The MathWorks, Inc.
    sv = svmStruct.H(i).SupportVectors;
    alphaHat = svmStruct.H(i).Alpha;
    bias = svmStruct.H(i).Bias;
    kfun = svmStruct.H(i).KernelFunction;
    kfunargs = svmStruct.H(i).KernelFunctionArgs;

    f_h(i,:) = (feval(kfun,sv,tSet,kfunargs{:})'*alphaHat(:)) + bias;
     
%     outVector_h(i) = sign(f_h(i,:));
    
end
% outVector_h(outVector_h == 0) = 1; % points on the boundary are assigned to class 1
% outVector_h(outVector_h == -1) = 2;% use "svmclassify.m" convention  


[~, out_oneVSall_h] = min(f_h); % have to use min to deal with MATLAB opposite convention
outClass_h = labels_h(out_oneVSall_h);

% % outMov = find(outVector);
% [~,outMov] = max(Scores,[],2);
   
%% post processing on f values
outMov = zeros(size(outClass_w));

if (outClass_w == 15 & outClass_h ~= 15) 
    outMov = find(~cellfun('isempty',strfind (svmStruct.mov,svmStruct.hand_mov{outClass_h})));
elseif (outClass_h == 15 & outClass_w ~= 15)
    outMov = find(~cellfun('isempty',strfind (svmStruct.mov,svmStruct.wrist_mov{outClass_w})));
elseif (outClass_h == 15 & outClass_w == 15)
    outMov = length(svmStruct.mov)+1; %rest
elseif (outClass_h ~= 15 & outClass_w ~= 15)
    %if f_h(outClass_h,:) <= f_w(outClass_w,:)
    if f_h(out_oneVSall_h,:) <= f_w(out_oneVSall_w,:)
        outMov = find(~cellfun('isempty',strfind (svmStruct.mov,svmStruct.hand_mov{outClass_h})));
    else
        outMov = find(~cellfun('isempty',strfind (svmStruct.mov,svmStruct.wrist_mov{outClass_w})));
    end
end
outVector = [];




