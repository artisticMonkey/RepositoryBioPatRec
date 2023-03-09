% Computation of Matthew's correlation coefficient (phi)
% The input argument is the confusion matrix (rows are the target class,
% collumns are the output class)
function phi = MCC(CM)
c     = trace(CM);    % number of correctly classified samples
s     = sum(sum(CM)); % total number of samples
t     = sum(CM,2)';   % number of times the class trully occured
p     = sum(CM,1);    % number of times the class was predicted
phi = (c*s - t*p')/sqrt(s^2 - p*p')/sqrt(s^2 - t*t');
end