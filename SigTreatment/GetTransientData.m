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
% This function will create matrices of training, validation and testing data
% by splitting the original data
% It will also send the data to the routine to break down its
% characteristics
%
% input:   Data is a Nsamples x Nchannels x Nexercises matrix    
%          sigTreated struct with the information required for the data
%          treatment
% output:  trdata are the split training data from the original recording time 
%          vdata are the split validation data
%          tdata are the split testing data
%
% NOTE: Optimization could be implemented
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2015-10-25 / Gunter Kanitz  / Creation

function [transientdata] = GetTransientData (sigTreated)

    data = sigTreated.tdata;            % tData contains all training data
    nM   = length(data(1,1,:));          % Number of movements  
    tempdata = [];
    
    % Get Data
    if strcmp(sigTreated.twSegMethod,'Non Overlapped')

        warning('Non Overlapped window mode not implemented for transient features');

    elseif strcmp(sigTreated.twSegMethod,'Overlapped Cons')
        
        tWsamples = floor(sigTreated.tW * sigTreated.sF);              % Samples corresponding Time window
        oS = floor(sigTreated.wOverlap * sigTreated.sF);   % Samples correcponding overlap

        tempdataSize = size(data);
        tempdataSize(4) = floor((tempdataSize(1) - (tWsamples - oS)) / oS);
        tempdataSize(1) = tWsamples;
        tempdata = zeros(tempdataSize);
        
        for e = 1: nM
            for i = 1 : tempdataSize(4)
                iidx = 1 + (oS * (i-1));
                eidx = tWsamples + (oS *(i-1));
                tempdata(:,:,e,i) = data(iidx:eidx,:,e);
            end
        end



    elseif strcmp(sigTreated.twSegMethod,'Overlapped Rand')

    end
    
    
    transientdata = tempdata;
end