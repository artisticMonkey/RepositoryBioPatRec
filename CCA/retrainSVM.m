% This function gives back SVM model that has been retrained on support
% vectors and calibration data from the test subject
function model = retrainSVM(patRec,data,dataOut)
newTraining = [];
newTrainingOut = []; 
for class = 1:(length(patRec.mov) - 1)
    svIdx = []; % support vector indeces
    subIdx = 0;
%     for s = 1:length(indTrain)%(numSubjects - 1) % for every training subject find the support vectors
%         clIdx = find(features(indTrain(s)).out(:,class)) + subIdx;
%         subIdx = subIdx + size(features(indTrain(s)).out,1);
%         temp1 = clIdx(1);
%         temp2 = clIdx(end);
%         % support vectors that are saved are the ones
%         % correspoding to the class being examined
%         svIdx = [svIdx; find((patRec.patRecTrained.SVM(class).SupportVectorIndices <= temp2) & (patRec.patRecTrained.SVM(class).SupportVectorIndices >= temp1))];
%     end
    svIdx = find(patRec.patRecTrained.SVM{class}.SupportVectorLabels == 1); % find only support vectors that belong to the positive class
    dataPoints = length(svIdx);
%                         newTraining = [newTraining; patRec.patRecTrained.SVM(class).SupportVectors(svIdx,:)];
    newTraining = [newTraining; patRec.patRecTrained.SVM{class}.SupportVectors(svIdx,:)];
    temp = zeros(dataPoints,(length(patRec.mov) - 1));
    temp(:,class) = 1;
    newTrainingOut = [newTrainingOut; temp];
end
newTraining = [newTraining; data]; % training data consisting of support vectors and calibration data from the test subject
newTrainingOut = [newTrainingOut; dataOut];
% newTraining = data;
% newTrainingOut = createOuts(dataExtension,(length(patRec.mov) - 1));
model = OfflinePatRecTraining(patRec.alg, patRec.tType, '', newTraining, newTrainingOut, newTraining, newTrainingOut, patRec.mov, 1:length(patRec.mov), newTraining, newTrainingOut, false); % retraining of the SVM               
end