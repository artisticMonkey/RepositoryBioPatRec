% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors? contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees? quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
% Function to pre-process bioelectric recordings. It's called from the
% treatment GUI and requires the handles.
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2012-07-07 / Max Ortiz  / Moved out from the preProcessing botton 
% 2014-12-06 / Max Ortiz  / Added downsampling option
% 2014-12-28 / Max Ortiz  / Added scaling option 
% 2015-12-08 / Eva Lendaro / Fixed problem on "Remove channels" whne used 
                          % with more then 9 channels
% 2014-04-01 / Julian Maier / Add artifacts option
% 20xx-xx-xx / Author     / Comment on update
% 20xx-xx-xx / Author     / Comment on update

function sigTreated = PreProcessingMagnets(handles)

    % Get the recSession
    set(handles.t_msg,'String','Loading recSession...');
    recSession = get(handles.t_recSession,'UserData');
       
    nM = str2double(get(handles.et_nM,'String'));
    cT = str2double(get(handles.et_cT,'String'));
    rT = str2double(get(handles.et_rT,'String'));
    sF = str2double(get(handles.et_sF,'String'));
    nR = str2double(get(handles.et_nR,'String'));
    nMag = str2double(get(handles.et_nMag,'String'));
    nCh = str2double(get(handles.et_nCh,'String'));
    nCh = 1:nCh;
    muscle = get(handles.t_muscle,'UserData');
    contents = cellstr(get(handles.lb_magInput,'String'));
    inputSig = contents(get(handles.lb_magInput,'Value'));
    mDim = 6; % dimension of data from one magnet
   
    %% Magnets readout
    sF
    cFrames = cT*sF;
    rFrames = rT*sF;
    singleMovFrames = cFrames + rFrames;
        
    if (nMag/length(nCh) <= 2) && nMag ~= 0 
        poses_grasp = recSession.tdata;
        rest_data   = recSession.ramp.minData;
        tdata = [];
        rdata = [];
       for i = nCh
            dist = poses_grasp(:,(1:3)+mDim*(muscle(i,1)-1),:) - poses_grasp(:,(1:3)+mDim*(muscle(i,2)-1),:);
            distR = rest_data(:,(1:3)+mDim*(muscle(i,1)-1)) - rest_data(:,(1:3)+mDim*(muscle(i,2)-1));
            angR  = atan2(vecnorm(cross(rest_data(:,(4:6)+mDim*(muscle(i,1)-1)),rest_data(:,(4:6)+mDim*(muscle(i,2)-1)),2),2,2),dot(rest_data(:,(4:6)+mDim*(muscle(i,1)-1)),rest_data(:,(4:6)+mDim*(muscle(i,2)-1)),2));
            for k = 1:nM
                temp1 = poses_grasp(:,(4:6)+mDim*(muscle(i,1)-1),k);
                temp2 = poses_grasp(:,(4:6)+mDim*(muscle(i,2)-1),k);
                angularDist(:,1,k) = atan2(vecnorm(cross(temp1,temp2,2),2,2),dot(temp1,temp2,2));
            end
            dxyz_rest(:,i) = median(distR,1);

            D_restAv(i) = vecnorm(dxyz_rest(:,i));
            D_rest  = vecnorm(distR,2,2);
            D_train = vecnorm(dist,2,2);
            

            if size(inputSig,1) == 2
                tdata = cat(2,tdata,D_restAv(i) - D_train);
                tdata = cat(2,tdata,angularDist);
                rdata = [rdata, D_restAv(i) - D_rest, angR];
            elseif cell2mat(inputSig) == 'Lin. Displacement'
                tdata = cat(2,tdata,D_restAv(i) - D_train);
                rdata = [rdata, D_restAv(i) - D_rest];
            elseif cell2mat(inputSig) == 'Ang. Displacement'
                tdata = cat(2,tdata,angularDist);
                rdata = [rdata, angR];
            end
            clear dist contraction rest angleDist angle
       end 
       recSession.ramp.minData = rdata; % changin the rest noise from 36 to dim to dim of chosen channels
       recSession.magnetData.Features   = inputSig;
       recSession.magnetData.pairs      = muscle;
       if size(tdata,3) ~= nM
            % Separate the movements if needed
            index = 1;
            movFrames = cFrames*nR;
            for i = 1:nM
                treatData(:,:,i) = tdata(index:index+movFrames-1,:);
                index = index + movFrames;
            end
       else
            treatData = tdata;
        end
    elseif nMag == 0
%         tdata = zeros(cFrames*nR*nM,size(nCh,2));
%         cIdx = find(diff(recSession.label)==1);
%         cIdx = [1; cIdx]';
%         rIdx = find(diff(recSession.label)==-1)';
%         distance = recSession.tdata;
%         for i = 1:size(nCh,2)
%             contraction = [];
%             rest = [];
%             for j = 1:nM
%                 for k = 1:nR
%                     contraction = cat(1,contraction,distance(cIdx(j+(6*(k-1))):cIdx(j+(6*(k-1)))+cFrames-1,i));
%                 end
%             end
%       
%             for k = rIdx
%                 rest = cat(1,rest,distance(k+1:k+rFrames,i));
%             end
%             
%             D_restAv(i) = median(rest,1);
% 
%             restDist(:,i) = D_restAv(i) - rest;
%             tdata(:,i) = D_restAv(i) - contraction;
%             
%             clear contraction rest 
%         end
%         xPosRest = restDist(:,(1:11)*2-1);
%         yPosRest = restDist(:,(1:11)*2);
%         recSession.avRest = sqrt(xPosRest.^2 + yPosRest.^2);
%         xPos = tdata(:,(1:11)*2-1);
%         yPos = tdata(:,(1:11)*2);
%         tdata = sqrt(xPos.^2 + yPos.^2);
%         nCh = nCh(1:length(nCh)/2);
%         for ii = 1:size(tdata,2)
%             treatData(:,ii,:)=reshape(tdata(:,ii),2850,nM);
%         end
%         
%         rng(0);
%         peaksSelec = sort(randperm(nR,4));
%         peaksRemov = peaksSelec*cFrames;
%         treatData([peaksRemov(1)-cFrames+1:peaksRemov(1),peaksRemov(2)-cFrames+1:peaksRemov(2),...
%             peaksRemov(3)-cFrames+1:peaksRemov(3),peaksRemov(4)-cFrames+1:peaksRemov(4),],:,:) = [];
%         nR = size(treatData,1)/size(peaksSelec,2);
    end
    
%     if size(inputSig,1) == 2
%        nCh = wextend('1D','zpd',nCh,length(nCh),'r');
%     end
    

    recSession.tdata = treatData;
    
    % Add the movements to the struct
%     for i = 1:nM
%         recSession.mov{i} = ['Grasp ' num2str(i,'%d')];
%     end
%     recSession.mov = recSession.mov';
 
    
%     if size(recSession.tdata,3) == nM 
%         if size(recSession.tdata,2) ~= length(nCh)
%             recSession.tdata = recSession.tdata(:,length(nCh),:);
%         end
%     end
  
    if (size(recSession.tdata,2) ~= length(recSession.nCh))
        recSession.nCh = 1:size(recSession.tdata,2);
    end

   
    movSel = get(handles.lb_movements,'Value'); 
    if nM ~= length(movSel)        
        recSession = Split_recSession_Mov(movSel, recSession);
    end                
    
%     %Remove channels, if required %---------------------------------------
%     chSel = get(handles.lb_nCh,'Value');        
% 
%     if length(recSession.nCh) ~= length(chSel)
%         allCh = get(handles.lb_nCh,'String');    
%         for i = 1 : length(chSel)
%             channels(i) = str2double(allCh(chSel(i),:));
%         end
%         
%         recSession = Split_recSession_Ch(channels, recSession);
%         
%     end    

    % Downsample, if required %---------------------------------------
    sF = str2double(get(handles.et_sF,'String'));        
    dS = str2double(get(handles.et_downsample,'String'));        
    if sF ~= dS
        if recSession.sF < dS
            errordlg('The downsample frequency is higher than the original sF','Error');
            set(handles.t_msg,'String','Error in downsample frequency');
            set(handles.et_downsample,'String',num2str(recSession.sF));
        else
            recSession = Downsample_recSession(recSession, dS);        
        end
    end

    % Add noise, if required %---------------------------------------
    pStd = str2double(get(handles.et_noise,'String'));        
    if pStd ~= 0    
        recSession = AddNoise_recSession(recSession, pStd);        
    end
    recSession.noise = pStd;
    
    % Scaling, if required %---------------------------------------
    scalingV = get(handles.pm_scaling,'Value');    
    scalingS = get(handles.pm_scaling,'String');    
    scalingBits  = str2double(scalingS{scalingV});
    if scalingV ~= 1    % If other than None
        recSession = Scale_recSession(recSession, scalingBits);
    end
    recSession.scaled = scalingBits;
    
    %% Change from recSession to sigTreated
    
    %Remove trasient %---------------------------------------------------
%     cTp = str2double(get(handles.et_cTp,'String'));
    sigTreated = getSigTreated(recSession, handles);
%     sigTreated 
    %Add rest as a movement data %---------------------------------------
    if get(handles.cb_rest,'Value')
        sigTreated = AddRestAsMovement(sigTreated, recSession);
        % It informs the user of the changes made, however it conflics when
        % a whole folder is treated
%        set(handles.et_nM,'String',num2str(sigTreated.nM));
%        set(handles.lb_movements,'Value',1:sigTreated.nM);
%        set(handles.lb_movements,'String',sigTreated.mov);

%         movSel = [movSel sigTreated.nM];
%         set(handles.lb_movements,'Value',movSel);
    end
	
	%Add motion if required %---------------------------------------------
    if get(handles.cb_AddArtifact,'Value')
        if isempty(get(handles.cb_AddArtifact,'UserData'))
            % Set addArtifact params
            addArtifact = ChoiceArtifact(sigTreated);
            if isempty(addArtifact)
                set(handles.cb_AddArtifact,'Value',0);
                disp('No artifacts added.')
            else
                set(handles.cb_AddArtifact,'UserData',addArtifact)
            end
        end
        if ~isempty(get(handles.cb_AddArtifact,'UserData'))
            % Get addArtifact params
            sigTreated.addArtifact = get(handles.cb_AddArtifact,'UserData');
            % Insert artifacts in sigTreated.trData
            set(handles.t_msg,'String','Artifacts added.');
            sigTreated = AddArtifactOffline(sigTreated);
            disp('Artifacts added.')
        end
    end
    set(handles.cb_AddArtifact,'Enable','off');
    
    % Upload sigtreated to the GUI----------------------------------------
    set(handles.t_sigTreated,'UserData',sigTreated);
    set(handles.t_msg,'String','sigTreated uploaded');
    
