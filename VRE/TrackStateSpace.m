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
% Function to track the state space position of the system during TAC-test
% The results can be viewed in GUI_SSPresentation later.
%
% TrackStateSpace('initialize',patRec,allowance) - Initializes all
%    parameters needed to keep track of the state space system. Should be
%    executed before TAC-test starts
%
% TrackStateSpace('target', movIndex, distance) - Creates a target position
%    in state space. movIndex should be the patRec.movOutIdx, that
%    corresponds to the targeted motion, distance a number that sets the
%    distance to the target in all DoFs.
%
% TrackStateSpace('move', outMov, speeds) - Moves the system in state space
%
% ssTracker = TrackStateSpace('read') - Return a structure containing all
%    the state space information.
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2012-11-23 / Joel Falk-Dahlin  / Creation
% 20xx-xx-xx / Author  / Comment on update

function  ssObj = TrackStateSpace(varargin)

persistent classifiers controllers controlParams movMatrix ssTargets ssTrajectories allowance

if ischar(varargin{1})
    
    if strcmpi(varargin{1},'initialize')
        
        patRec = varargin{2};
        allowance = varargin{3};
        
        movMatrix = CreateMovMatrix(patRec);
        ssTargets = [];
        ssTrajectories = [];
        
        classifiers = {patRec};
        
        if isfield(patRec,'controlAlg')
            
            controllers = patRec.controlAlg.name;
            controlParams = {cell(1,1)};
            params = fieldnames(patRec.controlAlg.parameters);
            paramVec = [];
            for i = 1:length(params)
                paramName = params(i);
                paramValue = patRec.controlAlg.parameters.(params{i});
                paramVec = [paramVec; paramName, {paramValue}];
            end
            controlParams{1}{1} = paramVec;
            
        else
            controllers = {'None'};
            controlParams = {{[]}};
        end
        
    elseif strcmpi(varargin{1},'target')
        
        index = varargin{2};
        distance = varargin{3};
        
        if length(index) > 1
            movement = sum( movMatrix(index,:) );
        else
            movement = movMatrix(index,:);
        end
        
        newTarget = movement.*distance;
        ssTargets = [ssTargets, {newTarget}]; % Save the new target
        
        newTrajectory = zeros(1,size(newTarget,2));
        ssTrajectories = [ssTrajectories; {newTrajectory}];   % Create new position
        
    elseif strcmpi(varargin{1},'move')
        
        ssTrajectory = ssTrajectories{end};
        ssPos = ssTrajectory(end,:);
        outMov = varargin{2};
        speeds = varargin{3};
        openFlag = varargin{4};
        plotStruct = varargin{5};
        ToggleStruct = varargin{6};
%         outMovIdx = [];
         
%         for i = 1:length(classifiers{1}.movOutIdx)
%             if length(outMov) == length(classifiers{1}.movOutIdx{i})
%                 if classifiers{1}.movOutIdx{i} == outMov'
%                     outMovIdx = i;
%                     break;
%                 end
%             end
%         end
%         
%         if isempty(outMovIdx)
%             outMovIdx = length(classifiers{1}.movOutIdx);
%         end
        
        newPos = MoveSS(ssPos,movMatrix,outMov,speeds,openFlag); % Calculate new position in state space
        
        %Real time plot of status
        plotTarget = [ssTargets{end},ssTargets{end}];
        plotPos = [newPos,newPos];
        negPlotTarget = -(plotTarget<0).*plotTarget;
        negPlotPos = -(plotPos<0).*plotPos;
        
        % Spider Plot
%         reset(plotStruct);
%         radarplot(plotStruct,[[ssPos(1:4).*(ssPos(1:4)>0),negPlotPos(1:3),ssPos(5).*(ssPos(5)>0)];[ssTargets{end}(1:4).*(ssTargets{end}(1:4)>0),negPlotTarget(1:3),ssTargets{end}(5).*(ssTargets{end}(5)>0)]],{'open hand','flex hand','pronation','side grip','close hand','extend hand','supination','fine grip'},{'r','g'},{'b','r'},{'no','.'},11);
%         set(plotStruct,'visible','off');
              

        newTrajectory = [ssTrajectory; newPos]; % Update the trajectory
        ssTrajectories{end} = newTrajectory; % Save the trajectory
        
        % Closeness Toggles
        nearVector = ssTargets{1,end}-newPos;
        nearZone = find(abs(nearVector)<10);
        noNearZone = find(~(abs(nearVector)<10));
        OH_count = 0; 
        
        if ~isempty(noNearZone)
            for DOF = noNearZone
                switch DOF
                    case 1
                        set(ToggleStruct.txt_CH,'BackgroundColor',[1 1 1]);
                        OH_count = OH_count + 1;
                    case 2
                        set(ToggleStruct.txt_FH,'BackgroundColor',[1 1 1]);
                        set(ToggleStruct.txt_EH,'BackgroundColor',[1 1 1]);
                    case 3
                        set(ToggleStruct.txt_P,'BackgroundColor',[1 1 1]);
                        set(ToggleStruct.txt_S,'BackgroundColor',[1 1 1]);
                    case 4
                        set(ToggleStruct.txt_SG,'BackgroundColor',[1 1 1]);
                        OH_count = OH_count + 1;
                    case 5
                        set(ToggleStruct.txt_FG,'BackgroundColor',[1 1 1]);
                        OH_count = OH_count + 1;
                end
                if OH_count == 3
                    set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                end
            end
        end
        
        sideFlag = 1;
        closeFlag = 1;
        if ~isempty(nearZone)
            for DOF = nearZone
                switch DOF
                    case 1
                        if abs(nearVector(DOF)) > 5
                            if nearVector(DOF) > 0
                               set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 1]); 
                               set(ToggleStruct.txt_CH,'BackgroundColor',[1 1 1]);
                               closeFlag = 0;
                            else
                                set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                                set(ToggleStruct.txt_CH,'BackgroundColor',[0 1 1]);
                            end
                        else 
                            set(ToggleStruct.txt_CH,'BackgroundColor',[0 1 0]);
                            if ssTargets{1,end}(1) ~= 0 
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 0]);
                                closeFlag = 0;
                            end
                        end
                    case 2
                        if abs(nearVector(DOF)) > 5
                            if nearVector(DOF) > 0
                               set(ToggleStruct.txt_FH,'BackgroundColor',[0 1 1]); 
                               set(ToggleStruct.txt_EH,'BackgroundColor',[1 1 1]);
                            else
                                set(ToggleStruct.txt_FH,'BackgroundColor',[1 1 1]);
                                set(ToggleStruct.txt_EH,'BackgroundColor',[0 1 1]);
                            end
                        else
                            set(ToggleStruct.txt_FH,'BackgroundColor',[0 1 0]);
                            set(ToggleStruct.txt_EH,'BackgroundColor',[0 1 0]);
                        end
                    case 3
                        if abs(nearVector(DOF)) > 5
                            if nearVector(DOF) > 0
                               set(ToggleStruct.txt_P,'BackgroundColor',[0 1 1]); 
                               set(ToggleStruct.txt_S,'BackgroundColor',[1 1 1]);
                            else
                                set(ToggleStruct.txt_P,'BackgroundColor',[1 1 1]);
                                set(ToggleStruct.txt_S,'BackgroundColor',[0 1 1]);
                            end
                        else
                            set(ToggleStruct.txt_P,'BackgroundColor',[0 1 0]);
                            set(ToggleStruct.txt_S,'BackgroundColor',[0 1 0]);
                        end
                    case 4
                        if abs(nearVector(DOF)) > 5 
                            if nearVector(DOF) > 0
                               set(ToggleStruct.txt_SG,'BackgroundColor',[0 1 1]); 
                               set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                            else
                                set(ToggleStruct.txt_SG,'BackgroundColor',[1 1 1]);
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 1]);
                                sideFlag = 0;
                            end
                        else
                            set(ToggleStruct.txt_SG,'BackgroundColor',[0 1 0]);
                            if ssTargets{1,end}(4) ~= 0
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 0]);
                                sideFlag = 0;
                            elseif ssTargets{1,end}(1) == 0 && ssTargets{1,end}(4) == 0 && ssTargets{1,end}(5) == 0
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 0]);
                            elseif newPos(4)<=0 && closeFlag
                                set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                            end
                        end
                    case 5
                        if abs(nearVector(DOF)) > 5 
                            if nearVector(DOF) > 0
                               set(ToggleStruct.txt_FG,'BackgroundColor',[0 1 1]); 
                               set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                            else
                                set(ToggleStruct.txt_FG,'BackgroundColor',[1 1 1]);
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 1]);
                            end
                        else
                            set(ToggleStruct.txt_FG,'BackgroundColor',[0 1 0]);
                            if ssTargets{1,end}(5) ~= 0
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 0]);
                            elseif ssTargets{1,end}(1) == 0 && ssTargets{1,end}(4) == 0 && ssTargets{1,end}(5) == 0
                                set(ToggleStruct.txt_OH,'BackgroundColor',[0 1 0]);
                            elseif newPos(5)<=0 && sideFlag && closeFlag
                                set(ToggleStruct.txt_OH,'BackgroundColor',[1 1 1]);
                            end
                        end
                end
            end
        end
        
        
        
    elseif strcmpi(varargin{1},'read')
        
        ssObj.classifiers = classifiers;
        ssObj.controllers = controllers;
        ssObj.controlParams = controlParams;

        ssObj.ssTrajectories = ssTrajectories;
        
        ssObj.ssTargets = ssTargets;
        ssObj.nReps = 1;
        ssObj.allowance = allowance;
        
    elseif strcmpi(varargin{1},'single')
        ssTrajectory = ssTrajectories{end};
        ssTarget = ssTargets{end};
        
        ssOrigin = zeros(1,size(ssTrajectory,2));
        userPath = CalculatePathLength(ssTrajectory, ssTarget, allowance);
        perfectPath = CalculatePathLength([ssOrigin; ssTarget], ssTarget, allowance);
        
        %Will round the value to nearest value with accuracy of 3-decimal
        %places.
        ssObj = round((perfectPath / userPath)*1000) / 1000;
    end
    
else

end
