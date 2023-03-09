clear all
clc
%%
acc1 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4\healthy15');
acc2 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4\healthy10');
acc3 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4\healthy5');
% accA = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4\amputee_trainingData');
accA1 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements\amputee15_all');
accA2 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements\amputee10_all');
accA3 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements\amputee5_all');
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
acc3 = acc3.confMat(:,1:end-1);
accA1 = accA1.confMat(:,1:end-1);
accA2 = accA2.confMat(:,1:end-1);
accA3 = accA3.confMat(:,1:end-1);
% accA = accA.values;
numSub = 15;
numFolds = 4;
numSubA = 5;
cases = 3;
classes = 8;
data = zeros(numSub,cases);
dataA = zeros(numSubA,cases);
% confH = zeros(numSub*classes,classes,cases);
% confA = zeros(classes, classes*numSubA, cases);
% for s = 1:numSub
%     k = (1:classes) + classes*(s-1);
%     j = (s-1)*classes*numFolds + 1;
%     for f = 1:numFolds
%         confH(k,:,1) = confH(k,:,1) + acc1((1:classes) + (j-1) + classes*(f-1),:);
%         confH(k,:,2) = confH(k,:,2) + acc2((1:classes) + (j-1) + classes*(f-1),:);
%         confH(k,:,3) = confH(k,:,3) + acc3((1:classes) + (j-1) + classes*(f-1),:);
%     end
% end
% for s = 1:numSub
%     k = (1:classes) + classes*(s-1);
%     for c = 1:cases
%         data(s,c) = sum(diag(confH(k,:,c)))/sum(sum(confH(k,:,c)))*100;
%     end
% end
% for c = 1:cases
%     for f = 1:numFolds
%         k = (1:classes) + classes*(f-1);
%         confA(:,:,c) = confA(:,:,c) + accA(k + (c-1)*numFolds*classes,:);
%     end
% end
% for c = 1:cases
%     for s = 1:numSubA
%         k = (1:classes) + (s-1)*classes;
%         dataA(s,c) = sum(diag(confA(:,k,c)))/sum(sum(confA(:,k,c)))*100;
%     end
% end
for c = 1:cases
    switch c
        case 1
            acc = acc1;
            accA = accA1;
        case 2
            acc = acc2;
            accA = accA2;
        case 3
            acc = acc3;
            accA = accA3;
    end
    confH = zeros(classes, classes*numSub);
    confA = zeros(classes, classes*numSubA);
    for s = 1:numSub
        k = (1:classes) + classes*(s-1);
        j = (s-1)*classes*numFolds + 1;
        for f = 1:numFolds
            confH(:,k) = confH(:,k) + acc((1:classes) + (j-1) + classes*(f-1),:);
            if (s <= numSubA)
                confA(:,k) = confA(:,k) + accA((1:classes) + (j-1) + classes*(f-1),:);
            end
        end
        data(s,c) = sum(diag(confH(:,k)))/sum(sum(confH(:,k)))*100;
        if (s <= numSubA)
            dataA(s,c) = sum(diag(confA(:,k)))/sum(sum(confA(:,k)))*100;
        end
    end
end
%%
% confH(:,(1:8)+4*8) = [];
cM = zeros(8,8);
for s = 1:14
    cM = cM + confH(:,(1:8)+(s-1)*8);
end
%%
acc1 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\CV4\healthy5');
acc2 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\healthy5_h');
acc3 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\healthy5_fe');
acc4 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\healthy5_ps');
acc5 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\healthy5_sf');
accA1 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\amputee15_all');
accA2 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\amputee15_h');
accA3 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\amputee15_fe');
accA4 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\amputee15_ps');
accA5 = load('C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\SVMTrain\Movements\amputee15_sf');
% accA = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements\amputee_classes');
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
acc3 = acc3.confMat(:,1:end-1);
acc4 = acc4.confMat(:,1:end-1);
acc5 = acc5.confMat(:,1:end-1);
accA1 = accA1.confMat(:,1:end-1);
accA2 = accA2.confMat(:,1:end-1);
accA3 = accA3.confMat(:,1:end-1);
accA4 = accA4.confMat(:,1:end-1);
accA5 = accA5.confMat(:,1:end-1);
% accA = accA.a;
numSub = 15;
numFolds = 4;
numSubA = 5;
cases = 5;
classes = [8 4 6 6 6];
fields = {'all','hand','hand_fe','hand_ps','hand_sf'};
data = zeros(numSub,cases);
dataA = zeros(numSubA,cases);
for c = 1:cases
    switch c
        case 1
            acc = acc1;
            accA = accA1;
        case 2
            acc = acc2;
            accA = accA2;
        case 3
            acc = acc3;
            accA = accA3;
        case 4
            acc = acc4;
            accA = accA4;
        case 5
            acc = acc5;
            accA = accA5;
    end
    confH = zeros(classes(c), classes(c)*numSub);
    confA = zeros(classes(c), classes(c)*numSubA);
    for s = 1:numSub
        k = (1:classes(c)) + classes(c)*(s-1);
        j = (s-1)*classes(c)*numFolds + 1;
        for f = 1:numFolds
            confH(:,k) = confH(:,k) + acc((1:classes(c)) + (j-1) + classes(c)*(f-1),:);
            if (s <= numSubA)
                confA(:,k) = confA(:,k) + accA((1:classes(c)) + (j-1) + classes(c)*(f-1),:);
            end
        end
        data(s,c) = sum(diag(confH(:,k)))/sum(sum(confH(:,k)))*100;
        if (s <= numSubA)
            dataA(s,c) = sum(diag(confA(:,k)))/sum(sum(confA(:,k)))*100;
        end
    end
%     for s = 1:numSubA
%         k = (1:classes(c)) + classes(c)*(s-1);
%         sub = getfield(accA(s),fields{c});
%         for f = 1:numFolds
%             confA(:,k) = confA(:,k) + sub((1:classes(c)) + classes(c)*(f-1),:);
%         end
%         dataA(s,c) = sum(diag(confA(:,k)))/sum(sum(confA(:,k)))*100;
%     end
end
%%
% acc1 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CV4\LORO15');
% acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CV4\LORO10');
% acc3 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CV4\LORO5');
% accA = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CV4\amputee_trainingData');
acc1 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CV4\LORO10');
acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\Movements\healthy10_h');
acc3 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\Movements\healthy10_fe');
acc4 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\Movements\healthy10_ps');
acc5 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\Movements\healthy10_sf');
accA = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\Movements\amputee_classes');
% acc1 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CCA\healthy_5_20_SMOTE_all');
% acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CCA\healthy_5_40_SMOTE_all');
% acc3 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CCA\healthy_5_60_SMOTE_all');
% acc4 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Accuracy data\CCA\healthy_5_80_SMOTE_all');

acc1 = acc1.acc_avg(end,:)';
acc2 = acc2.acc_avg(end,:)';
acc3 = acc3.acc_avg(end,:)';
acc4 = acc4.acc_avg(end,:)';
acc5 = acc5.acc_avg(end,:)';
accA = accA.values;
numSub = 15;
numFolds = 4;
numSubA = 5;
cases = 5;
data = zeros(numSub,cases);
dataA = zeros(numSubA,cases);
dataAmed = zeros(numSubA,cases);
for s = 1:numSub
    k = (1:numFolds) + (s-1)*numFolds;
    data(s,:) = [mean(acc1(k)), mean(acc2(k)), mean(acc3(k)), mean(acc4(k)), mean(acc5(k))];
%     data(s,:) = [mean(acc1(k)), mean(acc2(k)), mean(acc3(k))];
end
for c = 1:cases
    k = (1:numFolds) + (c-1)*numFolds;
    dataA(:,c) = mean(accA(:,k),2);
    dataAmed(:,c) = median(accA(:,k),2);
end
%%
figure
subplot(1,2,1)
% boxplot_DINO(data,true,0.3)
% boxplotFC(data,{'AM','HG','HGFE','HGPS','OCWR'},[1,0,0]);
boxplotFC(data,{'15','10','5'},[1,0,0]);
xlabel('Repetitions (#)');
ylabel('Accuracy (%)');
% xticks(1:cases)
% xticklabels({'15 repetitions','10 repetitions','5 repetitions'})
% xticklabels({'Ext. 20','Ext. 40','Ext. 60','Ext. 80'})
% xticklabels({'All classes','Hand','Hand + flex/ext','Hand + pron/sup','Without side and fine grip'})
ylim([40 100])
title('Non-amputee participants')
subplot(1,2,2)
% boxplot_DINO(dataA,false,0.3)
% boxplotFC(dataA,{'AM','HG','HGFE','HGPS','OCWR'},[1,0,0]);
boxplotFC(dataA,{'15','10','5'},[1,0,0]);
xlabel('Repetitions (#)');
ylabel('Accuracy (%)');
% xticks(1:cases)
% xticklabels({'15 repetitions','10 repetitions','5 repetitions'})
% xticklabels({'All classes','Hand','Hand + flex/ext','Hand + pron/sup','Without side and fine grip'})
ylim([40 100])
title('Amputee participants')
%%
myFolder = 'C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4';
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
a = struct([]);
%%
myFolder = 'C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements';
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
%%
ind = 0;
for k = 1 : length(theFiles)
    if (contains(theFiles(k).name,'_sf'))
        ind = ind + 1;
        load(strcat(myFolder, '\',theFiles(k).name))
        a(ind).hand_sf = confMat(:,1:end-1);
    end
end
%%
folds = 32;
cases = 5;
classes = 8;
sub = 5;
values = zeros(folds*classes*sub,8+4+6+6+6);
for i = 1:size(a,2)
    k = (1:folds) + folds*(i-1);
    values(k,:) = [a(i).FF, a(i).Fr, a(i).MC, a(i).P2, a(i).PI]; 
end
%%
save('amputee_classes','a');
%%
values = zeros(5,4*numFolds);
for i = 1:(size(a,2)-2)
%     values(i,:) = [a(i + 2).LORO15, a(i + 2).LORO10, a(i + 2).LORO5];
    values(i,:) = [a(i + 2).all, a(i+1).hand, a(i+1).hand_fe, a(i+1).hand_ps];
end
%%
save('amputee_classes','values');
%%
med = zeros(numSubA,cases);
per25 = zeros(numSubA,cases);
per75 = zeros(numSubA,cases);
for c = 1:cases
    k = (1:numFolds) + (c-1)*numFolds;
    med(:,c) = median(values(:,k),2);
    per25(:,c) = prctile(values(:,k),25,2);
    per75(:,c) = prctile(values(:,k),75,2);
end
%% Spider plot
% polar_increments = 2*pi/5;
% theta = (0:polar_increments:2*pi) + pi/5/2;
% theta = theta([2 1 5 4 3]);
% iqr = [11.2, 7.5, 20, 6.5, 6.8;...
%     12.5, 15, 8.3, 11.7, 14.6;...
%     12.4, 6.2, 6.9, 5.1, 5.9;...
%     6.8, 2.8, 8.5, 17, 1.7;...
%     7.8, 16.1, 17.9, 12.6, 6.8];
% p75 = (dataAmed + iqr - 50)/50;
% p75(p75>1) = 1;
% p25 = (dataAmed - iqr - 50)/50;
% [x_stdmax,y_stdmax] = pol2cart(theta(1:end),p75);
% [x_stdmin,y_stdmin] = pol2cart(theta(1:end),p25);
figure
spider_plot(dataA(1,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','b','FillOption','on');
title('A1')
% hold on
% for i = 1:5
% plot([x_stdmin(1,i), x_stdmax(1,i)],[y_stdmin(1,i), y_stdmax(1,i)],'b','LineWidth',2.5);
% end
figure
spider_plot(dataA(2,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','r','FillOption','on');
title('A2')
% hold on
% for i = 1:5
% plot([x_stdmin(2,i), x_stdmax(2,i)],[y_stdmin(2,i), y_stdmax(2,i)],'r','LineWidth',2.5);
% end
figure
spider_plot(dataA(3,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','m','FillOption','on');
title('A3')
% hold on
% for i = 1:5
% plot([x_stdmin(3,i), x_stdmax(3,i)],[y_stdmin(3,i), y_stdmax(3,i)],'m','LineWidth',2.5);
% end
figure
spider_plot(dataA(4,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','g','FillOption','on');
title('A4')
% hold on
% for i = 1:5
% plot([x_stdmin(4,i), x_stdmax(4,i)],[y_stdmin(4,i), y_stdmax(4,i)],'g','LineWidth',2.5);
% end
figure
spider_plot(dataA(5,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','c','FillOption','on');
title('A5')
% hold on
% for i = 1:5
% plot([x_stdmin(5,i), x_stdmax(5,i)],[y_stdmin(5,i), y_stdmax(5,i)],'c','LineWidth',2.5);
% end
%%
figure
spider_plot(dataA(1,:),'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[0 0 0 0 0;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color','b','FillOption','on');
title('A1')
hold on
polar_increments = 2*pi/5;
theta = (0:polar_increments:2*pi) + pi/5/2;
[x_stdmax,y_stdmax] = pol2cart(theta(2),1);
[x_stdmin,y_stdmin] = pol2cart(theta(2),0.925 - 0.112);
plot([x_stdmin, x_stdmax],[y_stdmin, y_stdmax],'b','LineWidth',2.5)
%%
acc1 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fabio\Fa15');
acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fabio\Fa15_h');
acc3 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fabio\Fa15_fe');
acc4 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fabio\Fa15_ps');
acc5 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fabio\Fa15_sf');
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
acc3 = acc3.confMat(:,1:end-1);
acc4 = acc4.confMat(:,1:end-1);
acc5 = acc5.confMat(:,1:end-1);
c1 = zeros(8,8); c2 = zeros(4,4); c3 = zeros(6,6); c4 = zeros(6,6); c5 = zeros(6,6);
for f = 1:4
    c1 = c1 + acc1((1:8) + 8*(f-1),:);
    c2 = c2 + acc2((1:4) + 4*(f-1),:);
    c3 = c3 + acc3((1:6) + 6*(f-1),:);
    c4 = c4 + acc4((1:6) + 6*(f-1),:);
    c5 = c5 + acc5((1:6) + 6*(f-1),:);
end
a1 = sum(diag(c1))/sum(sum(c1))*100;
a2 = sum(diag(c2))/sum(sum(c2))*100;
a3 = sum(diag(c3))/sum(sum(c3))*100;
a4 = sum(diag(c4))/sum(sum(c4))*100;
a5 = sum(diag(c5))/sum(sum(c5))*100;