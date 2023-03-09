clear all
close all 
clc
%%
% features1 = load('AM.mat');
% features2 = load('FC.mat');
%%
% Specify the folder where the files live.
% myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\DataFeatures\Inail2\';
% myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\Preliminary Ottobock data\Features\';
myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\Work\WifiMioHand\WiFi data\FeaturesAll\';
% myFolder = 'C:\Users\UTENTE\OneDrive - Scuola Superiore Sant''Anna\Desktop\faks\master\Master thesis\Katarina\MEC_codes\Data\Subjects_1024\';
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    features(k) = load([myFolder theFiles(k).name]);
end
sigFeatures = struct;
sigFeatures = features(1).sigFeatures;
sigFeatures.nDataPerSubject = size(sigFeatures.transFeatures,1);
sigFeatures.ramp = rmfield(sigFeatures.ramp,'minData');
sigFeatures.ramp.minData{1} = features(1).sigFeatures.ramp.minData;
% sigFeatures.ramp = size(sigFeatures.ramp.maxData,1);
% ii = [3 4 6 7 8 9 11 12 13 14];
% ii = 3:15;
for i = 2:length(features)%length(ii)%
%     index = index + sigFeatures.nDataPerSubject(i-1);
    sigFeatures.nDataPerSubject(i) = size(features(i).sigFeatures.transFeatures,1);
%     sigFeatures.ramp.nDataPerSubject(i) = size(features(i).sigFeatures.ramp.maxData,1);
    sigFeatures.transFeatures = [sigFeatures.transFeatures; features(i).sigFeatures.transFeatures];
%     sigFeatures.ramp.minData = [sigFeatures.ramp.minData; features(i).sigFeatures.ramp.minData];
    sigFeatures.ramp.minData{i} = features(i).sigFeatures.ramp.minData;
%     sigFeatures.ramp.maxData = cat(1,sigFeatures.ramp.maxData, features(i).sigFeatures.ramp.maxData);
end
%%
% save('AllSubjects15_Tr.mat','sigFeatures');
% save('InailSubjects2.mat','sigFeatures');
save('WiFi_AllDS.mat','sigFeatures');
%%
clear all
close all
clc
%%
myFolder = 'C:\Users\Keti\Desktop\faks\master\Master thesis\Katarina\BioPatRec_ALC_transient_milano\DataFeatures\Intramuscular_cleaned';
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    features(k) = load(theFiles(k).name);
end
sigFeatures = struct;
sigFeatures = features(1).sigFeatures;
sigFeatures.nDataPerSubject = size(sigFeatures.transFeatures,1);
index = 1;
for i = 2:length(features)
    index = index + sigFeatures.nDataPerSubject(i-1);
    sigFeatures.nDataPerSubject(i) = size(features(i).sigFeatures.transFeatures,1);
    sigFeatures.transFeatures = [sigFeatures.transFeatures; features(i).sigFeatures.transFeatures];
    sigFeatures.trFeatures = [sigFeatures.trFeatures; features(i).sigFeatures.trFeatures];
    sigFeatures.vFeatures = [sigFeatures.vFeatures; features(i).sigFeatures.vFeatures];
    sigFeatures.tFeatures = [sigFeatures.tFeatures; features(i).sigFeatures.tFeatures];
    sigFeatures.ramp.minData = [sigFeatures.ramp.minData; features(i).sigFeatures.ramp.minData];
end
sigFeatures.trSets = size(sigFeatures.trFeatures,1);
sigFeatures.vSets = size(sigFeatures.vFeatures,1);
sigFeatures.tSets = size(sigFeatures.tFeatures,1);
%%
save('AllSubjectFeatures_Intramuscular_cleaned_scaled.mat','sigFeatures');