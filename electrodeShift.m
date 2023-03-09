% data collumns are (channels)x(features), channels are next to each other 
function shiftedData = electrodeShift(data,channels,clockwise,reducedChannelsInd)
collumns = size(data,2);
numFeatures = collumns/channels;
shiftedData = data;
for c = 1:channels
    shiftInd = (1:channels:collumns) + c;
    normInd = shiftInd - 1;
    if (shiftInd(1)>channels)
        shiftInd = 1:channels:collumns;
    end
    if clockwise
        shiftedData(:,shiftInd) = data(:,normInd);
    else
        shiftedData(:,normInd) = data(:,shiftInd);
    end
end
if ~isempty(reducedChannelsInd)
    shiftedData = reduceChannels(shiftedData,channels,reducedChannelsInd);
end
end