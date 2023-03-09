% Function for downsampling repetitions of movements
% indeces     = indeces of the data which needs to be downsampled
% repBegining = number of repetitions that currently are in the data
% repEnd      = number of repetitions to which we want to downsample the data
% numData     = number of sampled which belong to one repetition
function indecesFinal = downsampleRepetitions(indeces, repBegining, repEnd, numData)
rp = randperm(repBegining,repEnd);
indTrInd = (1:numData) + numData.*(rp' - 1);
indTrInd = reshape(indTrInd',1,repEnd*numData);
indTrInd(indTrInd > length(indeces)) = [];
indecesFinal = indeces(indTrInd);
end