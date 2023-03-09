% This function is to be used for training an artificial neural network
% (ANN) for transient EMG data
% transSets = training samples (rows are samples, collumns are features)
% transOuts = training labels (rows are samples, collumns are labels [0 1])
% ANN = neural network model

function [ANN, acc] = ANNTransAnalysis(tType, transSets, transOuts)

default = 0;        % if it is set to 1, the NN will be created with default parameters
layer = [30 30]; % layer size
lambda = 0.0001;    % regularization parameter

[~, trOut] = find(transOuts); % transfoming the label matrix into array, where each class corresponds to one number

if default
    ANN = fitcnet(transSets,trOut);
else
    ANN = fitcnet(transSets,trOut,"LayerSizes",layer,"Lambda",lambda);
end

acc = 0;

end