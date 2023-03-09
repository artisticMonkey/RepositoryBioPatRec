function [] = loadData()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Simulink initalization of parameters and data

% Load recording file in folder
if exist('simulinkData.mat')
    delete('simulinkData.mat')
end

recording = dir('*.mat');
data = load(recording.name);
fnames = fieldnames(data);
data = data.(fnames{1});


%% Define the scaling variables for the EMG data

% Scale by factor 600 (allows max values of ~3.6mV)
% Use 10MOhm and 33kOhm
data = data*1200;

% Center around 2.5V for Speedgoat output
data = data+2.5;

% Simulink demands that the data array has timestamps
sF = 500;
samples = length(data);
runtime = 1/sF*samples;
timeStamps = linspace(0,runtime,samples);

data = [timeStamps;data'];
% Save the data with specific name so the modelblock doesn't have to be
% changed
save('simulinkData.mat','data');


%% Set Model parameters


end

