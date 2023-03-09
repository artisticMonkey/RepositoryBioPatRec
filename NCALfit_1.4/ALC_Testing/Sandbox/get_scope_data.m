
% get_scope_data.m

clear 
clc

myScope = oscilloscope();

% The address of the oscilloscope
myScope.Resource = 'USB::0x0699::0x0408::C031188::INSTR';

% Connect the scope
connect(myScope);

% Enable channel 1 (GPIO1) and channel 2 (GPIO2)
enableChannel(myScope, 'CH1');
% Set the acquisition time and number of samples
Acquisition_Time = 4; %in seconds
NumSamples = 5e6;
set(myScope,'AcquisitionTime',Acquisition_Time);
set(myScope, 'WaveformLength',NumSamples);
% Start the acquisition
disp('Start')
pause(Acquisition_Time);

% End the acquis
disp('End');

% Get the waveform
[ch1] = getWaveform(myScope);

% Disconnect the oscilloscope
disconnect(myScope);


%Data Processing
 stim1_beg = find(ch1 <  - 0.1,1);
 stim1_mid = find(ch1(stim1_beg:end) > -0.1,1)+stim1_beg;
 stim1_end_beg = find(ch1(stim1_mid:end)>0.02,1)+stim1_mid;
 stim1_end_end = find(ch1(stim1_end_beg:end)<0.00,1)+stim1_end_beg;
 plot(ch1(stim1_beg:stim1_end_end))
 
 maxStim = min(ch1(stim1_beg:stim1_mid) );
 maxStimUp = max(ch1(stim1_end_beg:stim1_end_end) );
 aveStim = mean(ch1(stim1_beg:stim1_mid) );
 aveStimUp = max(ch1(stim1_end_beg:stim1_end_end) );
 
 
 %testCase.verifyEqual(
 
 %num_stims = ;
 
 
 
 
 