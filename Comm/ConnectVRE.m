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
% -------------------------- Function Description -------------------------
% Used to Connect a VRE session to a struct.
% Can be used for Realtime, Training, Motion Test etc.
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2013-01-29 / Nichlas Sander  / Creation
% 2015-12-01 / Morten Bak Kristoffersen / Added arm/leg selection.

function handles = ConnectVRE(handles, program)
    if ~isfield(handles,'vre_Com')
        open(program);
        handles.vre_Com = tcpip('127.0.0.1',23068,'NetworkRole','server');
        fopen(handles.vre_Com);
    if ~isfield(handles, 'vre_leg') % Default is not using the leg
        fwrite(handles.vre_Com,sprintf('%c%c%c%c','c',char(1),char(1),char(1)));
        fread(handles.vre_Com,1);
    else
        fwrite(handles.vre_Com,sprintf('%c%c%c%c','c',char(1),char(2),char(1)));
        fread(handles.vre_Com,1);
    end
    end
    handles = DisableIfExists(handles,'pb_socketConnect');
    handles = DisableIfExists(handles,'pb_VRleg');
    handles = DisableIfExists(handles,'pb_socketConnect2');
    handles = DisableIfExists(handles,'pb_ARarm');
    handles = DisableIfExists(handles,'pb_ARleg');
    handles = EnableIfExists(handles,'pb_socketDisconnect');
    handles = EnableIfExists(handles,'pb_Camera');
    handles = EnableIfExists(handles,'pb_ActivateArm');
    
%     fread(handles.vre_Com,1); % 20191002 - DD new VRE compatibility
end

function handles = EnableIfExists(handles,field)
    if isfield(handles,field)
        set(handles.(field),'Enable','on');
    end
end

function handles = DisableIfExists(handles,field)
    if isfield(handles,field)
        set(handles.(field),'Enable','off');
    end
end