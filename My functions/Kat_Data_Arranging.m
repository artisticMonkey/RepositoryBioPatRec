clear all
close all
clc

load("FW_LS_S14_data_cut.mat");
%% Extracting data from the file
data = s6.Data;
log = [15.1, 16.1, 17.1, 19.1, 20.1, 0];
Data = cell(1,5);
len = zeros(5);
for i = 1:6
    Data{i} = data(find(data(:,7)==log(i)),1:6);
    len(i) = length(Data{i});
end
len_min = min(len);
for i = 1:5
    Data{i} = Data{i}(1:len_min,:); 
end
Data{6} = Data{6}(1:length(Data{6})/2,:);
%%
subject = DS1;
% data = subject(:,2:end);
% label = subject(:,1);
data = dataNew(:,1:6);
label = dataNew(:,7);
nM = 4;
nCh = 6;
dataSize = size(data,1);
Data = zeros(dataSize/nM,nCh,nM);
for i = 1:nM
    Data(:,:,i) = data(label(:,1)==i,:);
end
%% Filling the sturct with data
recSession.sF = s6.fs;
recSession.sT = (5+5)*4;
recSession.cT = 4;
recSession.rT = 1.5;
recSession.nM = 5;
recSession.nR = 4;
recSession.nCh = 6;
recSession.vCh = [];
recSession.dev = {};
recSession.comm = 'COM';
recSession.comn = '';
recSession.useAcceleGlove = 0;
recSession.mov = {'All fingers flexion'; 'All fingers extension'; 'Palmar grasp'; 'Poining index-ext, all flex'; 'Three digit pinch'};
recSession.date = [];
recSession.cmt = {};
recSession.ramp.minData = Data{6};
recSession.tdata = [];
for i = 1:5
    recSession.tdata = cat(3,recSession.tdata,Data{i});
end

%%
samples = 4000;
samplesToAdd = 500;
sampleRest = [0, 0, 0, 0];
for s = 1:20
    load(['DS' num2str(s) '.mat']);
    eval(['subject = DS' num2str(s) ';']);
    data = subject(:,2:end);
    label = subject(:,1);
    nM = 4;
    nCh = 6;
    nR = 50;
    dataSize = size(data,1);
    Data = zeros(dataSize/nM,nCh,nM);
    restData = zeros(samplesToAdd,nCh,nM);
    for i = 1:nM
        Data(:,:,i) = data(label(:,1)==i,:);
        restData(:,:,i) = Data((sampleRest(i) + 1):(sampleRest(i) + samplesToAdd),:,i);
    end
    tempData = zeros(dataSize/nM + samplesToAdd*50*2,nCh,nM);
    for i = 1:nM
        for r = 1:nR
            ind = (1:(samples + samplesToAdd*2)) + (r-1)*(samples + samplesToAdd*2);
            indD = (1:samples) + (r-1)*samples;
            tempData(ind,:,i) = [restData(:,:,i); restData(:,:,i); Data(indD,:,i)];
        end
    end
    Data = tempData;
    recSession.sF = 1000;
    recSession.sT = dataSize/4/recSession.sF;
    recSession.cT = 3.5;
    recSession.rT = 1.5;
    recSession.nM = nM;
    recSession.nR = nR;
    recSession.nCh = nCh;
    recSession.vCh = [];
    recSession.dev = {};
    recSession.comm = 'COM';
    recSession.comn = '';
    recSession.mov = {'Close hand'; 'Bidigital grasp'; 'Open hand'; 'Pointing index'};
    recSession.date = [];
    recSession.cmt = {};
    recSession.ramp.minData = zeros(2000,nCh);
    recSession.tdata = Data;
    save(['DS' num2str(s)],'recSession');
end
%% Adding extra rest time


%% Plotting the data
figure()
for i = 1:5
    bb = mean(abs(recSession.tdata(:,:,i)),2);
    subplot(1,5,i)
    plot(bb);
    axis tight
end

%%
figure()
for i = 1:5
    bb = mean(abs(recSession.tdata(4.2e04:2.76e05,:,i)),2);
    subplot(5,1,i)
    plot(bb);
    axis tight
end

%% Cleaning the data
recSession.tdata(1:0.3*10e4,:,1) = recSession.tdata(1:0.3*10e4,:,1)*0.5;
%recSession.tdata(3*10e4:3.5*10e4,:,5) = recSession.tdata(3*10e4:3.5*10e4,:,1)*0.1; % only for S8

%% Cutting the data
recSession.tdata = recSession.tdata(4.2e04:2.76e05,:,:);

%% Saving the new file
save('FW_LS_S14_data_cut.mat','recSession');
%% Ottobock and Trigno data
data = OttobockDataset;
labels = data(:,1);
Mnoise = mean(data(labels==8,3:8),1);
noise = data(labels==8,3:8);
samples = data(labels~=8,3:8);
cT = 5;
sF = 1000;
samplesToAdd = 4000;
newData = [];
newLabel = [];
% addRest = ones(samplesToAdd,1)*Mnoise;
addRest = noise(1:samplesToAdd,:);
for i = 1:15*7
    idx1 = (i-1)*cT*sF + 1;
    idx2 = i*cT*sF;
    if (idx2 > size(samples,1)) 
        idx2 = size(samples,1);
    end
    newData = [newData; samples(idx1:idx2,:); addRest];
    newLabel = [newLabel; labels(idx1:idx2); ones(samplesToAdd,1)*labels(idx1)];
end
Data = zeros(size(newData,1)/7,6,7);
for n = 1:7
    Data(:,:,n) = newData(newLabel==n,:);
end
%%
labels = data(:,1);
noise = data(labels==10,3:end);
nM = 9;
nCh = 6;
Data = zeros((size(data,1)-size(noise,1))/nM,nCh,nM);
for n = 1:nM
    Data(:,:,n) = data(labels==n,3:end);
end
%%
nM = 9;
nCh = 6;
labels = data(:,1);
repSamples = 8000;
dataNew = [];
for n = 1:nM
    movData = data(labels==n,:);
    movData = movData(5*repSamples+1:end,:);
    dataNew = [dataNew; movData];
end

noise = data(labels==10,3:end);
noise = noise(1:8000*2,:);
data = dataNew;
labels = data(:,1);
Data = zeros((size(data,1))/nM,nCh,nM);
for n = 1:nM
    Data(:,:,n) = data(labels==n,3:end);
end
%%
recSession.sF = 1000;
recSession.sT = 80;
recSession.cT = 5;
recSession.rT = 3;
recSession.nM = nM;
recSession.nR = 10;
recSession.nCh = nCh;
recSession.vCh = [];
recSession.dev = {};
recSession.comm = 'COM';
recSession.comn = '';
recSession.mov = {'Supination'; 'Pronation'; 'Pinch grasp'; 'Power grasp'; 'Lateral grasp'; 'Open hand'; 'Point finger'; 'Flexion'; 'Extension'};
recSession.date = [];
recSession.cmt = {};
recSession.ramp.minData = noise;
recSession.tdata = Data;
save('S17_1','recSession');

% x = x+l;
% for i = 1:3
%     dNew(x(i):(x(i)+1000),:) = nn;
% end
% 
% 
% figure
% plot(mean(dNew(data(:,1)==2,:),2))
% hold on 
% plot(high_pass(mean(dNew,2)))
% 
% md = mean(dNew,2);
% a = 1;
% b = 1/0.5.*ones(1,1)';
% figure
% plot(md)
% hold on
% plot(mean(filter(a,b,dNew),2))




