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

function recSession = Initialize(hObject,handles)

    % Get the recSession
    set(handles.t_msg,'String','Loading recSession...');
    recSession = get(handles.t_recSession,'UserData');
       
    nM = str2double(get(handles.et_nM,'String'));
    cT = str2double(get(handles.et_cT,'String'));
    rT = str2double(get(handles.et_rT,'String'));
    sF = str2double(get(handles.et_sF,'String'));
    nR = str2double(get(handles.et_nR,'String'));
    nMag = str2double(get(handles.et_nMag,'String'));
    inputSig = str2double(get(handles.lb_magInput,'String'));
%     nCh = linspace(1,str2double(get(handles.et_nCh,'String')),str2double(get(handles.et_nCh,'String')));
    nCh = str2double(get(handles.et_nCh,'String'));
    if nCh > nchoosek(nMag,2)   % check the number of channels, in case the number is larger than the possible number of combinations for the given magnets
        nCh = nchoosek(nMag,2);
    end
    
    if nMag ~= 0        
        st = GUI_MagnetSelection(handles);
        stdata = guidata(st);
        for i = 1:nCh
            set(eval(strcat('stdata.et_mag1Ch',num2str(i))),'Enable','on');
            set(eval(strcat('stdata.et_mag2Ch',num2str(i))),'Enable','on');
        end
        for i = (nCh+1):15
            set(eval(strcat('stdata.et_mag1Ch',num2str(i))),'Enable','off');
            set(eval(strcat('stdata.et_mag2Ch',num2str(i))),'Enable','off');
        end

        waitfor(GUI_MagnetSelection)
        muscle = getappdata(0,'muscle');
        set(handles.t_recSession,'UserData',recSession);
        set(handles.t_muscle,'UserData',muscle);
        guidata(hObject,handles);
    end
    
    
    
    
    
