function [featureSet, A] = CCASupervised(X,T)
A = pinv(X'*X)*X'*T;
%[a,~] = eig(A);
featureSet = X*A;
end