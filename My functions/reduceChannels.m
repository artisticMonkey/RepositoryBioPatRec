function newData = reduceChannels(data,channels,reducedChannelsInd)
reducedChannels = length(reducedChannelsInd);
collumns = size(data,2);
numFeatures = collumns/channels;
newCollumns = numFeatures*reducedChannels;
newData = zeros(size(data,1),newCollumns);
for c = 1:reducedChannels
    oldInd = (1:channels:collumns) + (reducedChannelsInd(c)-1);
    newInd = (1:reducedChannels:newCollumns) + (c-1);
    newData(:,newInd) = data(:,oldInd);
end
end