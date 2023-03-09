function [Xa, Xt] = SubspaceAlignment(S,T,d)
% S = (S - mean(S))./std(S);
% T = (T - mean(T))./std(T);
[~,Xs] = pca(S,d);
[~,Xt] = pca(T,d);
Xa = Xs*Xs'*Xt;
end