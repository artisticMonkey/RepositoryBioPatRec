% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
% Test the ANN MLP. This function was split from OneShotPatRec.
%
% ------------------------- Updates & Contributors ------------------------
% 2015-08-13 / Max Ortiz  / Creation

function [outMov outVector] = NetLab_MLPTest(patRecTrained, tSet)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
          
    outVector = mlpfwd(patRecTrained.MLP(1), tSet);
    
    if isfield(patRecTrained,'thOut')
        % Output according to a given threshold
        outMov = find(outVector>patRecTrained.thOut');
    else
        % The output movement is given by any prediction over 50%
        outMov = find(round(outVector));  % returns all indices for accepted movements
                               
        if size(patRecTrained.MLP,2) == 2                                    
            outVector(outMov) = mlpfwd(patRecTrained.MLP(2), tSet);
        end
  
    end
    
end

