function [featureSet, A] = CCA(X,Y)
% X (nxf)
% Y (nxf)
% A (fxf)
A = pinv(X'*X)*X'*(pinv(Y'*Y)^(1/2)*Y')';
% A = pinv(X'*X)*X'*(Y*pinv(Y'*Y)^(1/2));
%[a,~] = eig(A);
featureSet = X*A;
end