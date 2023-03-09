close all
clear all
load('score.mat')
%%
nFolds = 5;
nData = size(score,2)/nFolds;
nClass = 7;
scoreCorrect = ones(size(score,1),size(score,2))*nan;
scoreIncorrect = ones(size(score,1),size(score,2))*nan;
for f = 1:nFolds
    foldInd = nData*(f-1);
    scoreEval = score(:,(1:nData) + foldInd);
    for c = 1:nClass
        [~,maxInd] = max(scoreEval(:,(1:3) + (c-1)*3));
        correctInd = find(maxInd == c);
        incorrectInd = find(maxInd ~= c);
        scoreCorrect(c,correctInd + foldInd + (c-1)*3) = scoreEval(c,correctInd + (c-1)*3);
        scoreIncorrect(maxInd(incorrectInd),incorrectInd + foldInd + (c-1)*3) = scoreEval(maxInd(incorrectInd),incorrectInd + (c-1)*3);
    end
end
%%
figure
for c = 1:nClass
    subplot(7,1,c)
    histogram(scoreCorrect(c,:),3)
end
figure
for c = 1:nClass
    subplot(7,1,c)
    histogram(scoreIncorrect(c,:),3)
end