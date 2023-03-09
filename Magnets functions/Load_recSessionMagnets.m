% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec � which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors� contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees� quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% ------------------- Function Description ------------------
% Funtion to load "recSession" in GUI_PatRec
%
% --------------------------Updates--------------------------
% 2011-06-30 / Max Ortiz  / Creation
% 2011-07-19 / Max Ortiz  / Modified to only load the recSession, 
%                           the signal processing has been dived inside 
%                           the GUI_SigTreatment

function Load_recSessionMagnets(recSession, handles)

    % Removed useless fields from previus versions (EMG_AQ)
    if isfield(recSession,'trdata')
        recSession = rmfield(recSession,'trdata');         
    end
    if isfield(recSession,'cTp')
        recSession = rmfield(recSession,'cTp');         
    end
    
    % Open Fig and load information            
    
    %st = GUI_GetSigFeatures();
    st = GUI_SigTreatmentMagnets();
    stdata = guidata(st);
    set(stdata.et_nMag,'String','6');
    set(stdata.et_nCh,'String','3');
    set(stdata.pb_preProcessing,'Enable','off');
    set(stdata.et_downsample,'Enable','off');
    set(stdata.cb_rest,'Enable','off');
    set(stdata.pm_scaling,'Enable','off');
    set(stdata.cb_AddArtifact,'Enable','off');
    set(stdata.lb_magInput,'Enable','off');
    
    
    set(stdata.et_sF,'String',num2str(recSession.sF));
    set(stdata.et_downsample,'String',num2str(recSession.sF));
    set(stdata.et_nM,'String',num2str(recSession.nM));
    set(stdata.et_nR,'String',num2str(recSession.nR));
    set(stdata.et_cT,'String',num2str(recSession.cT));
    set(stdata.et_rT,'String',num2str(recSession.rT));
    set(stdata.lb_movements,'String',recSession.mov);
    set(stdata.lb_movements,'Value',1:recSession.nM);
    
    if length(recSession.nCh) == 1
        recSession.nCh = 1:recSession.nCh;
        nCh = recSession.nCh;
    end    
    if length(recSession.nCh) ~= length(recSession.tdata(1,:,1))
        set(stdata.t_msg,'String','Error in the number of channels');
        set(handles.t_msg,'String','Error in the number of channels');
    end

    
    %Load the whole recSession
    set(stdata.t_recSession,'UserData',recSession);
    % Save this GUI handles
    set(stdata.t_mhandles,'UserData',handles);  