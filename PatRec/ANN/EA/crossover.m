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
% [Give a short summary about the principle of your function here.]
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 20xx-xx-xx / Max Ortiz  / Creation
% 20xx-xx-xx / Author  / Comment on update

function new_individuals = crossover(population,i1,i2,ngenes)

cp = 1 + fix(rand*(ngenes-1));

new_individuals(1,1:cp) = population(i1,1:cp);
new_individuals(2,1:cp) = population(i2,1:cp);

new_individuals(1,cp:ngenes) = population(i2,cp:ngenes);
new_individuals(2,cp:ngenes) = population(i1,cp:ngenes);

%for j = 1:ngenes
%    if (j < cp)
%        new_individuals(1,j) = population(i1,j);
%        new_individuals(2,j) = population(i2,j);
%    else
%        new_individuals(1,j) = population(i2,j);
%        new_individuals(2,j) = population(i1,j);
%    end
%end