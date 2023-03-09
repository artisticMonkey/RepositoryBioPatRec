clear all
clc
%% For plotting boxplots for extended cal. (healthy)
user = "UTENTE";
% user = "Keti";
path1 = "C:\Users\";
path2 = "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fitcsvm\Polynomial_kernel\";
acc1 = load(path1 + user + path2 + "healthy_5_20_SMOTE_all");
acc2 = load(path1 + user + path2 + "healthy_5_40_SMOTE_all");
acc3 = load(path1 + user + path2 + "healthy_5_60_SMOTE_all");
acc4 = load(path1 + user + path2 + "healthy_5_80_SMOTE_all");
acc5 = load(path1 + user + path2 + "healthy_5_100_SMOTE_all");
% acc1r = load(path1 + user + path2 + "healthy_5_20_RP_all");
% acc2r = load(path1 + user + path2 + "healthy_5_40_RP_all");
% acc3r = load(path1 + user + path2 + "healthy_5_60_RP_all");
% acc4r = load(path1 + user + path2 + "healthy_5_80_RP_all");
% acc5r = load(path1 + user + path2 + "healthy_5_100_RP_all");
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
acc3 = acc3.confMat(:,1:end-1);
acc4 = acc4.confMat(:,1:end-1);
acc5 = acc5.confMat(:,1:end-1);
% acc1r = acc1r.confMat(:,1:end-1);
% acc2r = acc2r.confMat(:,1:end-1);
% acc3r = acc3r.confMat(:,1:end-1);
% acc4r = acc4r.confMat(:,1:end-1);
% acc5r = acc5r.confMat(:,1:end-1);
numSub = 14;
numFolds = 4;
cases = 5;
classes = 8;
data = zeros(numSub,cases);
% datar = zeros(numSub,cases);
for c = 1:cases
    switch c
        case 1
            acc = acc1;
%             accr = acc1r;
        case 2
            acc = acc2;
%             accr = acc2r;
        case 3
            acc = acc3;
%             accr = acc3r;
        case 4
            acc = acc4;
%             accr = acc4r;
        case 5
            acc = acc5;
%             accr = acc5r;
    end
    confH = zeros(classes, classes*numSub);
%     confHr = zeros(classes, classes*numSub);
    for s = 1:numSub
        k = (1:classes) + classes*(s-1);
        j = (s-1)*classes*numFolds + 1;
        for f = 1:numFolds
            confH(:,k) = confH(:,k) + acc((1:classes) + (j-1) + classes*(f-1),:);
%             confHr(:,k) = confHr(:,k) + accr((1:classes) + (j-1) + classes*(f-1),:);
        end
        data(s,c) = sum(diag(confH(:,k)))/sum(sum(confH(:,k)))*100;
%         datar(s,c) = sum(diag(confHr(:,k)))/sum(sum(confHr(:,k)))*100;
    end
end
%% For plotting boxplots for classes (healthy)
user = "UTENTE";
% user = "Keti";
path1 = "C:\Users\";
path2 = "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\";
acc1 = load(path1 + user + path2 + "healthy_5_60_SMOTE_all");
acc2 = load(path1 + user + path2 + "healthy_5_60_SMOTE_h");
acc3 = load(path1 + user + path2 + "healthy_5_60_SMOTE_fe");
acc4 = load(path1 + user + path2 + "healthy_5_60_SMOTE_ps");
acc5 = load(path1 + user + path2 + "healthy_5_60_SMOTE_sf");
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
acc3 = acc3.confMat(:,1:end-1);
acc4 = acc4.confMat(:,1:end-1);
acc5 = acc5.confMat(:,1:end-1);
numSub = 14;
numFolds = 4;
numSubA = 5;
cases = 5;
classes = [8 4 6 6 6];
data = zeros(numSub,cases);
for c = 1:cases
    switch c
        case 1
            acc = acc1;
        case 2
            acc = acc2;
        case 3
            acc = acc3;
        case 4
            acc = acc4;
        case 5
            acc = acc5;
    end
    confH = zeros(classes(c), classes(c)*numSub);
    for s = 1:numSub
        k = (1:classes(c)) + classes(c)*(s-1);
        j = (s-1)*classes(c)*numFolds + 1;
        for f = 1:numFolds
            confH(:,k) = confH(:,k) + acc((1:classes(c)) + (j-1) + classes(c)*(f-1),:);
        end
        data(s,c) = sum(diag(confH(:,k)))/sum(sum(confH(:,k)))*100;
    end
end
%% For plotting non- and retrained (healthy)/ or RP vs SMOTE
user = "UTENTE";
% user = "Keti";
path1 = "C:\Users\";
path2 = "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\";
acc1 = load(path1 + user + path2 + "healthy_5_60_SMOTE_all");
% acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CV4\healthy15');
acc2 = load(path1 + user + path2 + "retrained\healthy_5_60_SMOTE_all_retrained");
% acc2 = load('C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\healthy_5_60_RP_all');
acc1 = acc1.confMat(:,1:end-1);
acc2 = acc2.confMat(:,1:end-1);
numSub = 14;
numFolds = 4;
cases = 2;
classes = 8;
data = zeros(numSub,cases);
for c = 1:cases
    switch c
        case 1
            acc = acc1;
        case 2
            acc = acc2;
    end
    confH = zeros(classes, classes*numSub);
    for s = 1:numSub
        k = (1:classes) + classes*(s-1);
        j = (s-1)*classes*numFolds + 1;
        for f = 1:numFolds
            confH(:,k) = confH(:,k) + acc((1:classes) + (j-1) + classes*(f-1),:);
        end
        data(s,c) = sum(diag(confH(:,k)))/sum(sum(confH(:,k)))*100;
    end
end
%% Plotting boxplots
figure
% boxplot_DINO(data,true,0.3)
boxplotFC(data,{'20','40','60','80','100'},[1,0,0]);
% boxplotFC(data,{'AM','HG','HGFE','HGPS','OCWR'},[1,0,0]);
% boxplotFC(data,{'CCA','CCA + retraining'},[1,0,0]);
% xlabel('Data augmetation method')
xlabel('Repetitions to which calibration data is extended (#)');
ylabel('Accuracy (%)');
% xticks(1:cases)
% xticklabels({'15 repetitions','10 repetitions','5 repetitions'})
% xticklabels({'Ext. 20','Ext. 40','Ext. 60','Ext. 80'})
% xticklabels({'All classes','Hand','Hand + flex/ext','Hand + pron/sup','Without side and fine grip'})
ylim([50 100])
title('Non-amputee participants (SMOTE)')
%%
figure
subplot(1,4,1)
boxplotFC([datar(:,1), data(:,1)],{'RP','SMOTE'},[1,0,0]);
ylim([50 100])
xlabel('Extended to 20')
ylabel('Accuracy (%)')
subplot(1,4,2)
boxplotFC([datar(:,2), data(:,2)],{'RP','SMOTE'},[1,0,0]);
xlabel('Extended to 40')
ylim([50 100])
subplot(1,4,3)
boxplotFC([datar(:,3), data(:,3)],{'RP','SMOTE'},[1,0,0]);
xlabel('Extended to 60')
ylim([50 100])
subplot(1,4,4)
boxplotFC([datar(:,4), data(:,4)],{'RP','SMOTE'},[1,0,0]);
xlabel('Extended to 80')
ylim([50 100])
%% AMPUTEES: Getting data for spider plots
% myFolder = 'C:\Users\Keti\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA';
% filePattern = fullfile(myFolder, '*.mat'); 
% theFiles = dir(filePattern);
% a = struct([]);
% %%
% ind = 0;
% for k = 1 : length(theFiles)
%     if (contains(theFiles(k).name,'FF'))
%         ind = ind + 1;
%         load(strcat(myFolder, '\',theFiles(k).name))
%         a(ind).values = confMat(:,1:end-1);
%     end
% end
% temp = a(3).values;
% a(3).values = a(2).values;
% a(2).values = temp;
% save('FF','a');
user = "UTENTE";
%user = "Keti";
pathA = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\amputee_5_60_SMOTE_";
pathr = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\retrained\amputee_5_60_SMOTE_";
path2 = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Movements\amputee5_";
pathrEnd = "_retrained";
classCh = {'all','h','fe','ps','sf'};
for c = 1:length(classCh)
    a = load(pathA + classCh{c});
    acc(1).(classCh{c}) = a.confMat(:,1:end-1);
    a = load(path2 + classCh{c});
    acc(2).(classCh{c}) = a.confMat(:,1:end-1);
    a = load(pathr + classCh{c} + pathrEnd);
    acc(3).(classCh{c}) = a.confMat(:,1:end-1);
end
numSubA = 5;
cases = 5;
classes = [8, 4, 6, 6, 6];
numFolds = 4;
dataA = zeros(numSubA,cases);
data2 = zeros(numSubA,cases);
datar = zeros(numSubA,cases);
for c = 1:cases
    for s = 1:numSubA
        confA = zeros(classes(c), classes(c));
        conf2 = zeros(classes(c), classes(c));
        confr = zeros(classes(c), classes(c));
        k = numFolds*classes(c)*(s-1);
            for f = 1:numFolds
                confA = confA + acc(1).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
                conf2 = conf2 + acc(2).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
                confr = confr + acc(3).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
            end
        dataA(s,c) = sum(diag(confA))/sum(sum(confA))*100; 
        data2(s,c) = sum(diag(conf2))/sum(sum(conf2))*100; 
        datar(s,c) = sum(diag(confr))/sum(sum(confr))*100; 
    end
end
%% Plotting spider plots
figure
spider_plot([dataA(1,:); data2(1,:); datar(1,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color', [1, 0, 0; 0, 0, 1; 0, 1, 0],'FillOption','on');
title('A1')
legend('CCA','Within','CCA + retrained')
figure
spider_plot([dataA(2,:); data2(2,:); datar(2,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color',[1, 0, 0; 0, 0, 1; 0, 1, 0],'FillOption','on');
title('A2')
legend('CCA','Within','CCA + retrained')
figure
spider_plot([dataA(3,:); data2(3,:); datar(3,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color',[1, 0, 0; 0, 0, 1; 0, 1, 0],'FillOption','on');
title('A3')
legend('CCA','Within','CCA + retrained')
figure
spider_plot([dataA(4,:); data2(4,:); datar(4,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color',[1, 0, 0; 0, 0, 1; 0, 1, 0],'FillOption','on');
title('A4')
legend('CCA','Within','CCA + retrained')
figure
spider_plot([dataA(5,:); data2(5,:); datar(5,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color',[1, 0, 0; 0, 0, 1; 0, 1, 0],'FillOption','on');
title('A5')
legend('CCA','Within','CCA + retrained')
%% Bars - amputee - ext. data & classes
% clear all
clear acc
% extCal = {'20','40','60','80','100'};
extCal = {'20'};
% classCh = {'all','h','fe','ps','sf'};
classCh = {'all','h','sf'};
user = "UTENTE";
% user = "Keti";
% path = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\RngChanged\healthy_5_";
path = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fitcsvm\ModelAdaptationCCA\healthy_5_";
pathEnd = "_SMOTE_";
for ex = 1:length(extCal)
    for c = 1:length(classCh)
        a = load(path + extCal{ex} + pathEnd + classCh{c});
        acc(ex).(classCh{c}) = a.confMat(:,1:end-1);
    end  
end
%%
numSubA = 15;
numFolds = 4;
% classes = [8, 4, 6, 6, 6];
classes = [8, 4, 6];
casesC = 3;
% classes = 8;
% casesC = 1;
casesE = 1;
data = zeros(casesC,casesE,numSubA);
for ex = 1:casesE
    for c = 1:casesC
        for s = 1:numSubA
            confA = zeros(classes(c),classes(c));
            k = numFolds*classes(c)*(s-1);
            for f = 1:numFolds
                confA = confA + acc(ex).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
            end
            data(c,ex,s) = sum(diag(confA))/sum(sum(confA))*100;
        end
    end
end
%% Ploting spider plots for best acuracies (amputees)
A = {'A1','A2','A3','A4','A5'};
indBest = [3, 2, 3, 4, 3;...
           1, 2, 2, 4, 3;...
           1, 4, 2, 2, 3;...
           3, 4, 4, 2, 1;...
           3, 4, 3, 3, 2];
for s = 1:numSubA
    for c = 1:5
        dd(c) = data(c,indBest(s,c),s)';
    end
    figure
    spider_plot([dd; data2(s,:)],'AxesLabels',{'AM','HG','HGFE','HGPS','OCWR'},'AxesLimits',[50 50 50 50 50;...
    100 100 100 100 100],'AxesInterval',5,'AxesDisplay','one','Color',[1, 0, 0; 0, 0, 1],'FillOption','on');
    title(A{s})
    legend('CCA','Within')
end
%% Ploting bars
C = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560]};
A = {'A1','A2','A3','A4','A5'};
for s = 1:numSubA
    figure
    sb = superbar(data(:,:,s),'BarFaceColor',C);
    set(gca, 'XTick', [1:5])
    set(gca, 'XTickLabel', {'AM','HG','HGFE','HGPS','OCWR'})
    title(A{s});
    legend([sb(1),sb(6),sb(11),sb(16)],'20','40','60','80','Location','southeast');
    ylim([0 100])
end

%% Healthy - different experts
myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\CCA\expert_5_60_SMOTE';
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
numExp = 13;
conf = zeros(448,8,numExp);
for k = 1 : length(theFiles)
    load(strcat(myFolder, '\',theFiles(k).name))
    conf(:,:,k) = confMat(:,1:end-1);
end
conf = conf(:,:,[1 7 8 9 10 11 12 13 2 3 4 5 6]);
numFolds = 4;
numSub = 14;
classes = 8;
data = zeros(numSub,numExp);
for e = 1:numExp
    for s = 1:numSub
        cc = zeros(classes,classes);
        k = numFolds*classes*(s-1);
        for f = 1:numFolds
            cc = cc + conf((1:classes) + (f-1)*classes + k,:,e);
        end
        data(s,e) = sum(diag(cc))/sum(sum(cc))*100;
    end
end
%% Plotting error bars
Y = median(data);
E = (prctile(data,75) - prctile(data,25))./2;
figure
superbar(Y,'E',E);
ylim([50 100])
xticks(1:13);
xlabel('Expert subject')
ylabel('Accuracy (%)')
title('Non-amputee participants')
%% Getting data for just one case
% path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\";
% path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\ConfusionmatMEC\";
% path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\ConfusionmatInail\";
% path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\";
% acc = load(path + "cm1024_90450_wo");
% acc = load(path + "healthy15_all_2");
% acc = load(path + "cm");
% acc = load(path + "cmMinDist10_wl_rms");
% rejected = acc.confMat(:,end);
% acc = acc.confMat(:,1:end-1);
acc = confMat1(:,1:end-1);
numSub = 24;
numFolds = 5;
classes = 7;
dataInd = zeros(numSub,1);
accClass = zeros(classes,numSub);
conf = zeros(classes,classes,numSub);
for s = 1:numSub
    k = numFolds*classes*(s-1);
    for f = 1:numFolds
        conf(:,:,s) = conf(:,:,s) + acc((1:classes) + classes*(f-1) + k,:);
    end
    dataInd(s) = sum(diag(conf(:,:,s)))/sum(sum(conf(:,:,s)))*100;
    accClass(:,s) = diag(conf(:,:,s))./sum(conf(:,:,s),2)*100;
end
% dataInd(1,:) = [];
% myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\Work\WifiMioHand\WiFi data\Performances\Medium\';
% filePattern = fullfile(myFolder, '*.mat'); 
% theFiles = dir(filePattern);
% conf = [];
% for k = 1 : length(theFiles)
%     if (~contains(theFiles(k).name,"p"))
%         load([myFolder theFiles(k).name]);
%         conf = [conf; confMat1];
%     end
% end
%%
figure
boxplotFC([dataInd1, dataInd2],{'1','2'},[1 0 0]);
ylim([40 100])
%% For plotting the confusion matrix
CM = sum(conf,3);
figure()
cm = confusionchart(CM);
% cm.RowSummary = 'row-normalized';
% cm.Normalization = 'absolute';
cm.Normalization = 'row-normalized';
M = cm.NormalizedValues;
figure()
plotConfMat(M,{'La','Pi','Po','Ex','Fl','Pr','Su','Re'})
%% Getting data for varying number of training data
% path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\RngChanged\";
path = "C:\Users\UTENTE\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\";
% acc = load(path + "amputee_5_60_SMOTE_all_varTr");
acc = load(path + "cm");
acc = acc.confMat(:,1:end-1);
numSub = 20;
numTr = 19;
numFolds = 1;
classes = 4;
dataInd = zeros(numSub,numTr);
for t = 1:numTr
    j = numFolds*classes*numSub*(t-1);
    for s = 1:numSub
        conf = zeros(classes,classes);
        k = numFolds*classes*(s-1) + j;
        for f = 1:numFolds
            conf = conf + acc((1:classes) + classes*(f-1) + k,:);
        end
        dataInd(s,t) = sum(diag(conf))/sum(sum(conf))*100;
    end
end
%%
c = 5;
subplot(5,1,c);
hold all
plot(dataH(:,c),'b');
plot(dataInd,'r');
plot(dataH(:,c),'bo');
plot(dataInd,'ro');
xticks(1:numSub)
legend('CCA','CV4')
grid on
ylim([50 100])

%% Plotting bars for healthy and amputee (CV4, CCA and CCA+retraining)
clear acc
subject = "amputee";
extCal = '20';
% classCh = {'all','h','fe','ps','sf'};
classCh = {'all','h','sf'};
% classCh = {'all'};
user = "UTENTE";
% user = "Keti";
path = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fitcsvm\ModelAdaptationCCA\" + subject + "_5_";
pathCV4 = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fitcsvm\" + subject + "5_";
pathEnd = "_SMOTE_";
pathEndRetraining = "_retrained";

for c = 1:length(classCh)
    a = load(path + extCal + pathEnd + classCh{c});
%     ar = load(path + extCal + pathEnd + classCh{c} + pathEndRetraining);
    aCV4 = load(pathCV4 + classCh{c}); 
    acc.(classCh{c}) = a.confMat(:,1:end-1);
%     accR.(classCh{c}) = ar.confMat(:,1:end-1);
    accCV4.(classCh{c}) = aCV4.confMat(:,1:end-1);
end  

numSub = 5;
numFolds = 4;
classes = [8, 4, 6];
casesC = 3;
data = zeros(numSub,casesC);
% dataR = zeros(numSub,casesC);
dataCV4 = zeros(numSub,casesC);
for c = 1:casesC
    for s = 1:numSub
        conf = zeros(classes(c),classes(c));
%         confR = zeros(classes(c),classes(c));
        confCV4 = zeros(classes(c),classes(c));
        k = numFolds*classes(c)*(s-1);
        k4 = numFolds*classes(c)*s;
        for f = 1:numFolds
            conf = conf + acc.(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
%             confR = confR + accR.(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
            confCV4 = confCV4 + accCV4.(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
        end
        data(s,c) = sum(diag(conf))/sum(sum(conf))*100;
%         dataR(s,c) = sum(diag(confR))/sum(sum(confR))*100;
        dataCV4(s,c) = sum(diag(confCV4))/sum(sum(confCV4))*100;
    end
end
%% Plotting the bars
C = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980]};%, [0.9290 0.6940 0.1250]};
figure
% for c = 1:casesC
%     subplot(5,1,c)
%     sb = superbar([data(:,c), dataR(:,c), dataCV4(:,c)],'BarFaceColor',C);
%     ylim([50 100])
%     xticks(1:14)
%     legend([sb(1),sb(6),sb(11)],'CCA','CCA+retraining','CV4','Location','southeast');
%     ylabel('Accuracy (%)')
%     xlabel('Test subject')
% end
sb = superbar([mean(data)', mean(dataCV4)'],'E',[std(data)./2', std(dataCV4)./2'],'BarFaceColor',C);
ylim([50 100])
xticks(1:3)
legend([sb(1),sb(4)],'CCA with Model Adaptation','CV4','Location','southeast');
ylabel('Accuracy (%)')
set(gca, 'XTickLabel', {'AM','HG','OCWR'})
title('Amputee participants')
%% Electrode shift
clear acc acc1 accCV4
subject = "amputee";
clk = {'0','1'};
classCh = {'all','h','fe','ps','sf'};
user = "UTENTE";
% user = "Keti";
path = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\ElectrodeShift\" + subject+ "5_";
pathCV4 = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\RngChanged\" + subject + "5_";
pathEnd = "_CCA_";
for c = 1:length(classCh)
    for cl = 1:length(clk)
        a = load(path + classCh{c} + pathEnd + clk{cl});
        acc(cl).(classCh{c}) = a.confMat(:,1:end-1);
    end 
    a4 = load(pathCV4 + classCh{c});
    accCV4.(classCh{c}) = a4.confMat(:,1:end-1);
end
a1 = load(path + classCh{1} + "_" + clk{1});
acc1(1).(classCh{1}) = a1.confMat(:,1:end-1);
a1 = load(path + classCh{1} + "_" + clk{2});
acc1(2).(classCh{1}) = a1.confMat(:,1:end-1);

numSub = 5;
numFolds = 4;
classes = [8, 4, 6, 6, 6];
casesC = 5;
data = zeros(numSub,casesC,length(clk));
data1 = zeros(numSub,length(clk));
dataCV4 = zeros(numSub,casesC);
for c = 1:casesC
    for s = 1:numSub
        conf0 = zeros(classes(c),classes(c));
        conf1 = zeros(classes(c),classes(c));
        confCV4 = zeros(classes(c),classes(c));
        k = numFolds*classes(c)*(s-1);
        for f = 1:numFolds
            conf0 = conf0 + acc(1).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
            conf1 = conf1 + acc(2).(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
            confCV4 = confCV4 + accCV4.(classCh{c})((1:classes(c)) + classes(c)*(f-1) + k,:);
        end
        data(s,c,1) = sum(diag(conf0))/sum(sum(conf0))*100;
        data(s,c,2) = sum(diag(conf1))/sum(sum(conf1))*100;
        dataCV4(s,c) = sum(diag(confCV4))/sum(sum(confCV4))*100;
    end
end

for s = 1:numSub
    conf0 = zeros(classes(1),classes(1));
    conf1 = zeros(classes(1),classes(1));
    k = numFolds*classes(1)*(s-1);
    for f = 1:numFolds
        conf0 = conf0 + acc1(1).(classCh{1})((1:classes(1)) + classes(1)*(f-1) + k,:);
        conf1 = conf1 + acc1(2).(classCh{1})((1:classes(1)) + classes(1)*(f-1) + k,:);
    end
    data1(s,1) = sum(diag(conf0))/sum(sum(conf0))*100;
    data1(s,2) = sum(diag(conf1))/sum(sum(conf1))*100;
end
%% Boxplots
for c = 1:1%casesC
    figure
    boxplotFC([dataCV4(:,c), data1, data(:,c,1), data(:,c,2)],{'CV4','Grouped training (clk shift)','Grouped training (counterclk shift)','CCA (clk shift)','CCA (counterclk shift)'},[1 0 0])
    ylim([20 100])
    title('Amputee participants')
    ylabel('Accuracy (%)')
end

%% Electrode shift with varying training set
clear acc
user = "UTENTE";
subject = "healthy";
path = "C:\Users\" + user + "\OneDrive - Scuola Superiore Sant'Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Confusionmat\Fitcsvm\ElectrodeShift4Ch1\" + subject+ "3";
clockwise = "0";
pathEnd = "_all_CCA_" + clockwise;
% cases = {"CV5","4","8","12"};
% cases = {"CV5","3","9","13"};
cases = {"CV5","13"};

for c = 1:length(cases)
    if (c>1)
        a = load(path + cases{c} + pathEnd);
    else
        a = load(path + "_all_" + clockwise);
    end
    acc(c).conf = a.confMat(:,1:end-1);
end

numSub = 15;
classes = 8;
numFolds = 5;
data = zeros(numSub,length(cases));

for c = 1:length(cases)
    for s = 1:numSub
        conf = zeros(classes,classes);
        k = numFolds*classes*(s-1);
        for f = 1:numFolds
            conf = conf + acc(c).conf((1:classes) + classes*(f-1) + k,:);
        end
        data(s,c) = sum(diag(conf))/sum(sum(conf))*100;
    end
end

%%
figure
boxplotFC(dataH,{'Whithin-subject','CCA (clockwise)','CCA (counter-clockwise)'},[1 0 0])
title('Non-amputee participants (3 rep. for calibration)')
ylim([40 100])
ylabel('Accuracy (%)')
%%
confMat = confMat(:,1:7);
figure
plotConfMat(confMat,{'Open','Close','Pronation','Supination','Lateral grip','Pinch','Pointer'});
%% Force estimation (Ottobock data)
myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Preliminary Ottobock data\Accuracies\Force estiamtion\';
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
accuracies = [];
for k = 1 : length(theFiles)
    acc(k) = load([myFolder theFiles(k).name]);
    accuracies = [accuracies; acc(k).acc_avg(end,:)];
end
%% Dividing data into subjects
nSub = 6;
nFolds = 5;
nClass = 4;
dataSub = zeros(nSub, nFolds*nClass);
for s = 1:nSub
    ind = (1:nClass) + (s-1)*nClass;
    temp = reshape(accuracies(ind,:),1,nClass*nFolds);
    dataSub(s,:) = temp;
end

%% Divding data into classes
FLData = dataSub([1 2 4 5],:);
dataClass = zeros(nClass,nFolds*4);
for c = 1:nClass
    ind = (1:nFolds) + (c-1)*nFolds;
    temp = reshape(FLData(:,ind),1,nFolds*4);
    dataClass(c,:) = temp;
end