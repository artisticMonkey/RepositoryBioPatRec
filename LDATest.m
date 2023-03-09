% Function for testing a linear discriminant analysis model for transient EMG data
% patRecTrained = variable which contains the LDA model
% tSet = test data set (rown are samples, collumns are features)
% outMov = number of class that is predicted
% outVector = not used

function [outMov, outVector] = LDATest(patRecTrained, tSet)

outVector = 0;
LDA = patRecTrained.LDA;
[outMov, score, cost] = predict(LDA,tSet);
end