function [model, bestInd] = modelAdaptation(patRec,modelSVM,dataTest,dataOut,indTrain)
bestAcc = 0;
bestInd = 0;
for sub = 1:length(indTrain)
    patRecInd = patRec;
    patRecInd.patRecTrained = modelSVM{indTrain(sub)};
    [performance(sub), ~, ~] =  Accuracy_patRec(patRecInd, dataTest, dataOut, 1);
    if performance(sub).acc(end) > bestAcc
        bestAcc = performance(sub).acc(end);
        bestInd = sub;
    end
end
model = modelSVM{bestInd};
end