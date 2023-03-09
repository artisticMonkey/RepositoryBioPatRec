
clc

testData = recSession.tdata(:,:,:);

testData2 = [];
for i = 1:8
    
    tempData = [testData(:,:,i); recSession.tdata(:,:,i)];
    testData2(:,:,i) = tempData;
    
end

testData = testData2;


