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
% This Function Projecting ICA Unmixing Matrix on Training,Validation and 
% Testing sets on Segmented Data. 
% 
% 
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2012-10-20 / Tanuj Kumar Aluru  / Creation
% 20xx-xx-xx / Author  / Comment on update


function [trData vData tData]=ApplySignalSeparation(sigTreated,trData, vData, tData) 

    if strcmp(sigTreated.sigSeparation.Alg,'ICA')
        [trData vData tData]=ICAPreprocess(sigTreated,trData,vData,tData);
    end
    