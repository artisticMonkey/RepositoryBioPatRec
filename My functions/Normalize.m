function data_set = Normalize(data_set)

% mMin     = min(data_set);   % matrix min
% mMax     = max(data_set);   %matrix max
% mRange    = mMax - mMin;
% mMidrange = (mMax + mMin)/2;
meanValue = mean(data_set,1);
stdValue = std(data_set,1);
% Normalize by using the range which will create a distribution between
% 0 and 1
% data_set = (data_set - mMidrange) ./ (mRange/2);
data_set = (data_set - meanValue)./stdValue;

end