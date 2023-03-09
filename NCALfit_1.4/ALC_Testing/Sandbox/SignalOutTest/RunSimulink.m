loadData();
sF = 500;%% Set Parameter

%% Compile model and flash it to speedgoat
rtwbuild('SignalOutTest')

%%
% Set runtime in seconds
% set_param('SignalOutTest', 'StopTime', '10')
%%
tg.start


%%
outputlog = tg.OutputLog
%% Upsample by repeating

 n=3 ; x=(1:3)' % example
 r=repmat(x,1,n)';
 r=r(:)';


%%
a = sim('SignalOutTest','SimulationMode','normal');
b = a.get('simout');
assignin('base','b',b);

%%
fsys = SimulinkRealTime.fileSystem;
dir(fsys)
%% By AS: runs tg.start every X seconds


%% By AS: to add the TO signal and FROM speedgoat signals for comparison
% for this to work, to SG is labelled newData, and EMG.mat must be loaded
% into the workspace

newDataShifted = circshift(newData,-542, 1); %this middle value should be changed per reaction time

dataComp =[newDataShifted(:,1), allData(:,1)];
for i = 2:4
    dataCompTemp= [newDataShifted(:,i), allData(:,i)];
    dataComp = cat(2,dataComp, dataCompTemp);
end

%figure();
for l = 1:4
    subplot(2,2,l)
    plot(allData(:,l));
    hold on
    plot(newDataShifted(:,l));
    hold off
end    
%plot(dataComp,'DisplayName','dataComp')
