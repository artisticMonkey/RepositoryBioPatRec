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

function [SVM accV] = SVMTransAnalysisHW(dType, transSets, transOuts, mov , movIdx )
nM = size(transOuts,2);
nTr = size(transSets,1);
default = 1;    % set default = 0 to optimise SVM parameters, or default = 1 to use default mode

mov = mov(1:end-1); % discard rest

% parse available movements
hand_mov = {'Open Hand', 'Close Hand', 'Side Grip', 'Fine Grip', 'Rest'};
[hand_index, movIDx_h] = ismember(mov,hand_mov);
wrist_mov = {'Flex Hand', 'Extend Hand', 'Pronation', 'Supination', 'Rest'};
[wrist_index, movIDx_w] = ismember(mov,wrist_mov);

% armMovements = {
%     'Open Hand'; 'Close Hand'; 'Flex Hand'; 'Extend Hand'; 'Pronation'; 'Supination'; 'Side Grip'; 'Fine Grip'; 'Agree'; 'Pointer'; 'Thumb Extend'; 'Thumb Flex'; 'Thumb Abduc'; 'Thumb Adduc'; 'Flex Elbow'; 'Extend Elbow'; 'Index Extend'; 'Index Flex'; 'Middle Extend'; 'Middle Flex'; 'Ring Extend'; 'Ring Flex'; 'Little Extend'; 'Little Flex';};
% all_mov_list =  armMovements;
% all_mov_list(end+1)=  {'Rest'};


nM_w = sum(wrist_index)+1;
nM_h = sum(hand_index)+1;

transOuts_original = transOuts;
transOuts_h = [transOuts(:,hand_index) ];
transOuts_w = [transOuts(:,wrist_index)];
% mov_h = hand_mov([find(hand_index); 5]);
% mov_w = wrist_mov([find(wrist_index); 5]);
% mov_h = hand_mov([movIDx_h(hand_index); 5]);
% mov_w = wrist_mov([movIDx_w(wrist_index); 5]);
transOuts_h = [transOuts_h 1-sum(transOuts_h,2)];
transOuts_w = [transOuts_w 1-sum(transOuts_w,2)];

%% HAND
for i = 1:nM_h
    % modify target vectors
    trGroup = zeros(nTr,1);
    tr = find(transOuts_h(:,i)); % find the target class i for training
    trGroup(tr,1) = 1;
    %---------------------------------------------------------------
    if default == 1 % use default parameters
    % Train SVM
%     svmStruct_h(i) = svmtrain(transSets,trGroup,...
%                             'kernel_function', dType,... 
%                              'boxconstraint',1 ...
%                              ... ,'autoscale','false'...
%                              );
                         
    svmStruct_h{i} = fitcsvm(transSets,trGroup,...
                            'KernelFunction', dType,... 
                            'BoxConstraint',1,...
                            'Standardize',false,'Prior','uniform','OutlierFraction',0 ... % added to restore similar results
                         );    
                         
    %---------------------------------------------------------------
    else % validate tuning parameters
                
    end
    %---------------------------------------------------------------    
end
SVM_h = svmStruct_h;


%% WRIST
for i = 1:nM_w
    % modify target vectors
    trGroup = zeros(nTr,1);
    tr = find(transOuts_w(:,i)); % find the target class i for training
    trGroup(tr,1) = 1;
    %---------------------------------------------------------------
    if default == 1 % use default parameters
    % Train SVM
%     svmStruct_w(i) = svmtrain(transSets,trGroup,...
%                             'kernel_function', dType,... 
%                              'boxconstraint',1 ...
%                              ... ,'autoscale','false'...
%                              );
	svmStruct_w{i} = fitcsvm(transSets,trGroup,...
                            'KernelFunction', dType,... 
                             'BoxConstraint',1,...
                            'Standardize',false,'Prior','uniform','OutlierFraction',0 ... % added to restore similar results
                         );
    %---------------------------------------------------------------
    else % validate tuning parameters
                
    end
    %---------------------------------------------------------------    
end
SVM_w = svmStruct_w;

accV(nM+1) = 0;

SVM.W = SVM_w;
SVM.H = SVM_h;
SVM.hand_mov  = hand_mov;
SVM.wrist_mov = wrist_mov;
SVM.mov = mov;
SVM.movIDx_w = movIDx_w;
SVM.movIDx_h  = movIDx_h;

