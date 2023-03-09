% Function for testing an artificial neural network for transient EMG data
% patRecTrained = variable which contains the ANN model
% tSet = test data set (rown are samples, collumns are features)
% outMov = number of class that is predicted
% outVector = not used

function [outMov, outVector] = ANNTest(patRecTrained, tSet)

outVector = 0;
ANN = patRecTrained.ANN;
[outMov,score] = predict(ANN,tSet);
end