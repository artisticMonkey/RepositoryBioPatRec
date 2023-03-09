%clear all

%load('NNPredictionData.mat')

comPort = '/dev/tty.usbserial-A106TXYM';
baudRate = 460800;
delete(instrfindall);    
serialObj = serialport(comPort, baudRate, 'Databits', 8, 'Byteorder', 'big-endian');


ALC.testConnection(serialObj);

%%

alc = ALC();

nWindows = size(testData.featVect,1);
outIdx = zeros(nWindows,1);

testData.nChannels = 5;
testData.nFeatures = 4;

for win=1:nWindows
    testPackage = testData;
    testPackage.featVect = testPackage.featVect(win,:);
    outIdx(win) = alc.testClassifier(serialObj, testPackage);
end

outIdxALC = outIdx+1;

percentageSamePrediction = 100*sum(testData.predictedOut == outIdxALC)/length(outIdxALC)





%%
alc = ALC();

nWindows = size(testData.featVect,1);
outIdx = zeros(nWindows,1);
featVector = zeros(nWindows, testData.nMovements);

testData.nChannels = 5;
testData.nFeatures = 4;


for win=1:nWindows
    testPackage = testData;
    testPackage.featVect = testPackage.featVect(win,:);
    [outIdx(win), featVector(win,:)] = alc.testClassifierfeatVector(serialObj, testPackage);
end


difference = testData.predictedOutVector - featVector;
figure
stackedplot(difference)

figure
stackedplot(testData.predictedOutVector)

figure
stackedplot(featVector)


%% Test Features

% To run this, load a recSession and the corresponding patRec file
movement = 3;
% Create test data
nPackages = 50;
nSamples = patRec.tW*patRec.sF;
sampleIndex1 = 1:nSamples:nPackages*nSamples;
sampleIndex2 = nSamples:nSamples:nPackages*nSamples;


alc = ALC();
% Update the ALC with the patRec settings
alc.setPatRecSettings(serialObj, patRec)
           
% Get current parameters from ALC to double check 
alc.getRecSettings(serialObj);
nFeatures = numel(patRec.selFeatures);
outFeatureVector = zeros(nPackages,nFeatures*recSession.nCh);
matFeatVector = zeros(nPackages,nFeatures*recSession.nCh);
bioFeatVector = zeros(nPackages,nFeatures*recSession.nCh);

nCh = recSession.nCh;
testPackage.nChannels = nCh;
testPackage.nFeatures = nFeatures;
for package=1:nPackages
        testPackage.data = recSession.tdata(sampleIndex1(package):sampleIndex2(package) , : , movement);
        
        outFeatureVector(package,:) = alc.testFeatureExtraction(serialObj, testPackage);
        % Calculate features
        sp = length(testPackage.data(:,1));
        % TMABS
        tmabs = mean(abs(testPackage.data));
        matFeatVector(package,1:nCh) = tmabs;
        % TWL
        matFeatVector(package,nCh+1:2*nCh) = sum(abs(testPackage.data(2:sp,:) - testPackage.data(1:sp-1,:)));
        % TZC
        tmp = repmat(tmabs,[size(testPackage.data,1),1] );
        zc = ( testPackage.data >= tmp ) - (testPackage.data < tmp );
        matFeatVector(package,2*nCh+1:3*nCh) = sum((zc(1:sp-1,:) - zc(2:sp,:) ) ~= 0);
        % TSLPCH2
        diffData = diff(testPackage.data);      
        zc = (diffData > 0 ) - (diffData < 0);
        matFeatVector(package,3*nCh+1:end) = sum(abs(zc(1:end-1,:) - zc(2:end,:)) > 1 );
        
        [~, ~, oneShotPatRec , ~] = OneShotRealtimePatRec(testPackage.data, patRec, 0, 0);
        bioFeatVector(package,:) = oneShotPatRec.latestFeatureSet;
end

differenceMat = matFeatVector - outFeatureVector;
differenceBio = bioFeatVector - outFeatureVector;