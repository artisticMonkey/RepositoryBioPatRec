function [coeffs, RMSerrors] = trainingREG(movs, recSession, nCh, tW, plots)

%% Collect data from recSession structure
nMovs = size(movs,2);
labelsMovs = recSession.mov(movs,1:end);
sF = recSession.sF;
nSamples = size(recSession.tdata,1);

%% Treat the raw data
wS = tW*sF;       % samples per window
nW = nSamples/wS; % number of windows
for i = 1:nMovs
    % collect it
    tmpData = recSession.tdata(:,:,movs(i));
    % window it
    wData = reshape(tmpData, wS, nW, nCh); 
    % extract MABS
    mabs = mean(abs(wData),1);
    % store it
    mabsData(i,:,:) = reshape(mabs, nW, nCh);
end

%% Prepare input function X
X = [];
for i = 1:nMovs
    X = [X mabsData(i,:,:)];
end
X = squeeze(X);

%% Prepare fitting function y
if isfield(recSession, 'ramp') 
    % this is meant only for trapezoidal ramp track recording
    % doesn't work if you provide a regular ramp track recording
    rampSamples = sF*3/wS;
    steadySamples = sF*2/wS;
    restSamples = sF*3/wS;
    y_1rep = [0:1/rampSamples:1-1/rampSamples ones(1,steadySamples) 1-1/rampSamples:-1/rampSamples:0 zeros(1,restSamples)];
    y_nR = [];
    for i = 1:recSession.nR
        y_nR = [y_nR y_1rep];
    end
    y = zeros(nMovs,length(y_nR)*nMovs);
    for i = 1:nMovs
        y(i,(i-1)*length(y_nR)+1:(i-1)*length(y_nR)+length(y_nR)) = y_nR;
    end
else
    % regular recording
    steadySamples = sF*recSession.cT/wS;
    restSamples = sF*recSession.rT/wS;
    y_1rep = [ones(1,steadySamples) zeros(1,restSamples)];
    y_nR = [];
    for i = 1:recSession.nR
        y_nR = [y_nR y_1rep];
    end
    y = zeros(nMovs,length(y_nR)*nMovs);
    for i = 1:nMovs
        y(i,(i-1)*length(y_nR)+1:(i-1)*length(y_nR)+length(y_nR)) = y_nR;
    end
end
%% Plot MABS features
if plots
    figure;
    title('MABS features');
    for i = 1:nCh
        subplot(nCh+1,1,i);
        plot(X(:,i),'b');
        grid on;
        ylabel(sprintf('channel(%i,:)',i));
    end
    subplot(nCh+1,1,nCh+1);
    plot(y');
    xlabel('time windows');
end

%% Linear regression
coeffs = mvregress(X,y');

%% Estimate new function
new_y = X*coeffs;
% only positive values are allowed (mabs)
new_y(find(new_y<0)) = 0;

%% Plot new out
if plots
    figure;
    hold
    for i = 1:nMovs
        plot(y(i,:)+2*(i-1),'k');
        plot(new_y(:,i)+2*(i-1),'r');
    end
    %legend('y','$\hat{y}$','Interpreter','latex')
    xlabel('time windows');
    %yticks([0:2:nMovs*2]);
    %yticklabels(movs);
    [m idx] = max(new_y');
    idx(m<0.35) = 0;
    idx(idx==8)=15;
    idx(idx==7)=13;
    idx(idx==6)=11;
    idx(idx==5)=9;
    idx(idx==4)=7;
    idx(idx==3)=5;
    idx(idx==2)=3;
    plot(idx,'x b');
    legend('y','y hat','winner class')
end

%% Calculate error
for i = 1:nMovs
    RMSerrors(i) = sqrt(mean((y(i,:) - new_y(:,i)').^2));
end
