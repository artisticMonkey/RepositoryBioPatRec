% This function is to be used for training a linear discriminant analysis
% model
% transSets = training samples (rows are samples, collumns are features)
% transOuts = training labels (rows are samples, collumns are labels [0 1])
% LDA = linear disrciminant model

function [LDA, accV] = LDATransAnalysis(dType, transSets, transOuts)

default = 0;   % if it is set to 1, the NN will be created with default parameters
gamma = 0.5; % regularization parameter
[~, trOut] = find(transOuts); % transfoming the label matrix into array, where each class corresponds to one number

if default
    LDA = fitcdiscr(transSets,trOut); 
else
    LDA = fitcdiscr(transSets,trOut,"Gamma",gamma); 
end

accV = 0;

end