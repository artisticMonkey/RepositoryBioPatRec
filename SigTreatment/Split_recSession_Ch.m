% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authorsí contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputeesí quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
% Function the slipt the information of recording sessions in different
% channels
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2011-07-21 /  Max Ortiz  / Creation
% 20xx-xx-xx / Author  / Comment on update

function recSession = Split_recSession_Ch(channels, recSession)

    recSession.tdata = recSession.tdata(:,channels,:);    
    recSession.nCh = 1:length(channels);
    recSession.vCh = recSession.vCh(channels);
    if isfield(recSession,'ramp')
        recSession.ramp.minData = recSession.ramp.minData(:,channels);
        recSession.ramp.maxData = recSession.ramp.maxData(:,channels,:);
    end
