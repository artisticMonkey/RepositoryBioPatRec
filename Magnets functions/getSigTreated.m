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
% Function to compute Traning Data according to the contraction time
% percentage (cTp)
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 20xx-xx-xx / Max Ortiz  / Creation
% 2011-07-19 / Max Ortiz  / Updated to consider cTp before and after
%                           contraction
% 2017-10-25 / Gunter Kanitz / Retain original training data to extract
                             % parameters for transient control
% 20xx-xx-xx / Author  / Comment on update

function sigTreated = getSigTreated(recSession, handles)

%     recSession.sF      = str2double(get(handles.et_sF,'String'));
%     recSession.cT      = str2double(get(handles.et_cT,'String'));
%     recSession.rT      = str2double(get(handles.et_rT,'String'));
%     recSession.nR      = str2double(get(handles.et_nR,'String'));
%     recSession.nM      = str2double(get(handles.et_nM,'String'));
%     recSession.nCh     = linspace(1,str2double(get(handles.et_nCh,'String')),str2double(get(handles.et_nCh,'String')));
    recSession.nMag    = str2double(get(handles.et_nMag,'String'));
    
    tdata = recSession.tdata;
    cTp = str2num(handles.et_cTp.String);
    %cTp = 1;%0.5; %0.66667; %0.4;
    nM = recSession.nM;
    if recSession.nMag == 0
        recSession.nR = size(recSession.tdata,1)/150;
        recSession.nCh = recSession.nCh(1:length(recSession.nCh)/2);
        nR = recSession.nR;
    else
        nR = recSession.nR;
    end
    cT = recSession.cT;
    rT = recSession.rT;
    sF = recSession.sF;
    nCh = recSession.nCh;
    % New structured for the signal treated
    sigTreated      = recSession;
    sigTreated.cTp  = cTp;
    eRed            = (1-cTp)/2;    % effective reduction at the begining and at the end of contraction
    for ex = 1 : nM
        tempdata =[];
        for rep = 1 : nR
            % Samples of the exersice to be consider for training
            % (sF*cT*(cTp-1)) Number of the samples that wont be consider for training
            % (sF*cT*rep) Number of samples that takes a contraction
            % (sF*rT*rep) Number of samples that takes a relaxation
            
            is = fix((sF*cT*(1-cTp-eRed)) + (sF*cT*(rep-1)) + (sF*rT*(rep-1)) + 1);
            fs = fix((sF*cT*(cTp+eRed)) + (sF*cT*(rep-1)) + (sF*rT*(rep-1)));
            tempdata = [tempdata ; tdata(is:fs,:,ex)];
        end
        trData(:,:,ex) = tempdata;
    end
    
    % New structured for the signal treated
%     sigTreated      = recSession;
    sigTreated.trData = trData;
end