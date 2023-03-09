function [X, Xout, Xtest, XtestOut] = SimpleCalibration(Y, Yout, Ytest, YtestOut)
N = 20;
M = 8;
idx_train = 1:N:(N*M);
idx_test = setdiff(1:N*M,idx_train);
Xtest = Ytest(idx_test,:);
XtestOut = YtestOut(idx_test,:);
X = [Y; Ytest(idx_train,:)];
Xout = [Yout; YtestOut(idx_train,:)];
end