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
% ------------------- Function Description ------------------
% Function to Record Exc Sessions
%
% --------------------------Updates--------------------------
% 2015-4-22 / Enzo Mastinu / Function to get features vector

% 20xx-xx-xx / Author  / Comment



% It acquire tWs samples from the selected device
function fData = AcquireFeatures(deviceName, obj, nCh, nFeat)
    
    %%%%% ADS1299 %%%%%
    if strcmp(deviceName, 'ADS_BP')    
        fData = fread(obj,(nFeat*nCh),'float32');     
    end
   
end
