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
% 2022-04-12 / Katarina Dejanovic / Changed the function for SVM (from
% svmtrain to fitcsvm)
% 20xx-xx-xx / Author       / Comment on update

function [SVM accV] = SVMTransAnalysis(dType, transSets, transOuts, autoscale)
nM = size(transOuts,2);
nTr = size(transSets,1);
default = 1;    % set default = 0 to optimise SVM parameters, or default = 1 to use default mode
for i = 1:nM
    % modify target vectors
    trGroup = zeros(nTr,1);
    tr = find(transOuts(:,i)); % find the target class i for training
    trGroup(tr,1) = 1;
    %---------------------------------------------------------------
    if default == 1 % use default parameters
    % Train SVM
%     svmStruct(i) = svmtrain(transSets,trGroup,'kernel_function', dType,...
%         'boxconstraint',1,'autoscale',autoscale); %,'tolkkt',0.1  , 'method','LS'
    % KD: 20220412
        if (dType == "rbf")
            svmStruct{i} = fitcsvm(transSets,trGroup,'KernelFunction', dType,...
                'BoxConstraint',5,'Standardize',autoscale,'KernelScale',1.2);
        elseif (dType == "polynomial")
            svmStruct{i} = fitcsvm(transSets,trGroup,'KernelFunction', dType,...
                'BoxConstraint',1,'PolynomialOrder',2,'Standardize',autoscale);
        else
            svmStruct{i} = fitcsvm(transSets,trGroup,'KernelFunction', dType,...
                'BoxConstraint',1,'Standardize',autoscale);
        end
    %---------------------------------------------------------------
    else % validate tuning parameters
                
    end
    %---------------------------------------------------------------
    
end
accV(nM+1) = 0;
SVM = svmStruct;