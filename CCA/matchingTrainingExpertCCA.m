% Function for matching the number of data points of the training and
% expert subject (CCA cannot be performed unless the number of data points
% is the same)
% dataTrain is a struct which holds the training data and the labels, as
% well as the threshold and normalization parameters
% dataExpert and dataExpert are matrices
% nR is the number of repetitions per movement
function [dataTrainChanged,dataExpertChanged] = matchingTrainingExpertCCA(dataTrain,dataExpert,dataExpertOut,nR)
dataExpertChanged = [];
dataTrainChanged = dataTrain;
for cl = 1:size(dataTrain.out,2)
    outs = sum(dataTrain.out(:,cl) == 1);
    if (outs < nR)
        k = (1:sum(dataTrain.out(:,cl) == 1)) + (cl-1)*nR;
        dataExpertChanged = [dataExpertChanged; dataExpert(k,:)];
    elseif (outs > nR)
        cutInd = find(dataTrain.out(:,cl) == 1);
        cutInd = cutInd(end - (length(cutInd) - nR - 1):end);
        dataTrainChanged.data(cutInd,:) = [];
        dataTrainChanged.out(cutInd,:) = [];
        k = find(dataExpertOut(:,cl) == 1);
        dataExpertChanged = [dataExpertChanged; dataExpert(k,:)];
    else
        k = find(dataExpertOut(:,cl) == 1);
        dataExpertChanged = [dataExpertChanged; dataExpert(k,:)];
    end
end
end