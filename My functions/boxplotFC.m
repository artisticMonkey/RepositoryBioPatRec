function boxplotFC(varargin)
% minimalistic box plot. NaN values are not ignored.
% Currently works only with matrices of data or with rows (but still more than
% 1 group)
%
% ARGUMENTS:
%           1- DATA:    a matrix. Each column is a box plot. NaNs are
%                       ignored.
%           2- LABELS:  a cell array. OPTIONAL. If not provided numbers
%                       will be used instead
%
%           OR

%           1- DATA:    a row vector of data
%           2- GROUPS:  a row vector the same size of DATA, indicating to
%                       which group the corresponding data is associated
%                       to. Only numbers are supported to indicate groups
%
%           AND
%
%           3- dataPointsInfo: a 3-elements array containing:
%                          1. a flag indicating if the mean has to be
%                          plotted (1) or not (0)
%                          2. a flag indicating if single data points do
%                          not have to be plotted (0), have to be plotted
%                          (1), or have to be plotted, excluding outliers
%                          (2)
%                          2. the amount of jitter to be added on the X
%                          axis when plotting the individual data points.
%
%
% HISTORY
% 2020-01-19 (FC): added support for groups of different size.
%                  added support for the visualization of individual data
%                  points as hollow circles and of the mean as a diamond
%                  modified the size of the boxplot parts
%                  added support for single boxplots
% 2018-07-16 (FC): the median now ignores NaNs
% 2018-04-20 (FC): corrected bug responsible for not plotting labels
% 2017-08-28 (FC): introduced tick line for 2nd-3rd quartiles, thin line
%                  for whole distribution (before it was lines for 2nd-3rd
%                  quartiles, then empty and horizontal line for min and
%                  max distribution limits)
% 2017-08-10 (FC): Created and confirmed to work as intended

%%% manage input arguments
switch nargin
    case 0
        error(message('No data to plot'));
    case 1
        % if a single argument is passed, this must be data, with one
        % column per boxplot
        data   = varargin{1};
        dataPointsInfo = [0 0 0];
    case 2
        % if two arguments are passed, the first can be a column vector. If
        % so
        if(isvector(varargin{1}))
            % the second argument must be groups
            temp   = varargin{1};
            labels = unique(varargin{2});
            %%% depending on the groups, a new data matrix is filled with
            %%% data
            % preallocate data matrix for speed
            data = NaN*ones(length(temp), length(labels));
            % for each group
            for i=1:length(labels)
                % calculate the size of the group
                groupSize = sum(varargin{2}==labels(i));
                % fill the data matrix
                data(1:groupSize,i) = temp(varargin{2}==labels(i));
            end
        else
            %%% if the first argument is not a vector, then it must be the
            %%% matrix with the data, and the second one must contain the
            %%% labels.
            data   = varargin{1};
            labels = varargin{2};
        end
        dataPointsInfo = [0 0 0];
    case 3
        %%% same as with two arguments, but the third argument decides if I
        %%% want to plot single data points and/or mean as well
        if(isvector(varargin{1}))
            % the second argument must be groups
            temp   = varargin{1};
            labels = unique(varargin{2});
            % depending on the groups, a new data matrix is filled with
            % data
            % preallocate data matrix for speed
            data = NaN*ones(length(temp), length(labels));
            % for each group
            for i=1:length(labels)
                % calculate the size of the group
                groupSize = sum(varargin{2}==labels(i));
                % fill the data matrix
                data(1:groupSize,i) = temp(varargin{2}==labels(i));
            end
        else
            data   = varargin{1};
            if isempty(varargin{2})
            else
                labels = varargin{2};
            end
        end
        dataPointsInfo = varargin{3};
    otherwise
        warning(message('Too many input arguments. Arguments after the third one will be ignored'));
end

%%% prepare the data for drawing the plot
% number of columns is the number of plots
ColsNum = size(data,2);

% quartiles define the central part of the plot
MedPoints = nanmedian(data);
p         = prctile(data,[25 75]);
% if a single group is passed, p becomes a row vector. I have to fix this
% to make it compatible with the other cases.
if isvector(data)
    p = p';
end
p25       = p(1,:);
p75       = p(2,:);

% calculate the mean as well
MeanPoints = nanmean(data);

% % calculate length of wiskers (same as standard boxplot)
% w   = 1.5;
% wiskers      = NaN*ones(2,ColsNum);
% wiskers(1,:) = p25 - w*(p75-p25);
% wiskers(2,:) = p75 + w*(p75-p25);

%%% find outliers (same as standard boxplot, check matlab help)
w = 1.5;
DistLim        = NaN*ones(2,ColsNum);
DistLim(1,:)   = p25 - w*(p75-p25);
DistLim(2,:)   = p75 + w*(p75-p25);
dataWOoutliers = data;
outliersPos    = false(size(data,1),ColsNum);
for i = 1:ColsNum
    % outliers below the minimum threshold
    outliersSingleLo = data(:,i)<DistLim(1,i);
    % outliers above the maximum threshold
    outliersSingleHi = data(:,i)>DistLim(2,i);
    % all outliers for one column
    outliersSingle   = outliersSingleLo | outliersSingleHi;
    % store in boolean matrix all outliers positions
    outliersPos(:,i) = outliersSingle;
end
% number of outliers for each column (needed to plot the marker)
outliersNum = sum(outliersPos);
% delete outliers from data (replace with NaN)
dataWOoutliers(outliersPos) = NaN;


% calculate length of wiskers (max and min of data, without outliers)
wiskers      = NaN*ones(2,ColsNum);
wiskers(1,:) = nanmin(dataWOoutliers);
wiskers(2,:) = nanmax(dataWOoutliers);

% create the vectors of X values
X   = 1:ColsNum;
X_Q = [X' X']'; % quartiles
%X_W = [(X-0.1)' (X+0.1)']'; % wiskers


% create the vectors of Y values
Y_Q = [p25; p75]; % quartiles

%%% PLOT
hold on
% single data points
if dataPointsInfo(2) == 0
    % do not plot single data points
else
    % plot them
    % extract information about jitter
    jitter = dataPointsInfo(3);
    
    % calculate the offset in the X direction for each data point
    offsetPos = jitter*(rand(size(data))-0.5);
    
    % add the offset to the "nominal" X value (i.e. from 1 to the number of
    % boxplots)
    Xmatrix   = repmat(1:size(data,2),size(data,1),1) + offsetPos;
    
    % plot the individual data on top of the boxplot
    if dataPointsInfo(2) == 1 % all data
        plot(Xmatrix, data,'o','markersize',5, 'markeredgecolor', [0.6 0.6 0.6])
    elseif dataPointsInfo(2) == 2 % all data excluding outliers
        plot(Xmatrix, dataWOoutliers,'o','markersize',5, 'markeredgecolor', [0.6 0.6 0.6])
    end
end

% boxplot
for i=1:ColsNum
    % wiskers
%     plot(X_W(:,i), [wiskers(1,i) wiskers(1,i)],'k')
%     plot(X_W(:,i), [wiskers(2,i) wiskers(2,i)],'k')
    plot(X_Q(:,i), [wiskers(1,i) Y_Q(1,i)],'k','linewidth',1.5)
    plot(X_Q(:,i), [Y_Q(2,i) wiskers(2,i)],'k','linewidth',1.5)

    % Q1 - Q3
    plot(X_Q(:,i), Y_Q(:,i),'color',[0.5 0.5 0.5],'linewidth',5);%3
        
    % outliers
    X_O = X(i)*ones(outliersNum(i),1);
    plot(X_O, data(outliersPos(:,i),i),'kx','markersize',8)%5
end

% median
plot(X_Q(1,:), MedPoints,'k.','markersize',15)%15

% mean
if dataPointsInfo(1) == 1
    plot(X_Q(1,:), MeanPoints,'k>','markersize',5)%15
end

hold off
xlim([X(1)-1 X(end)+1])
set(gca,'xtick',X_Q(1,:))
if exist('labels','var')
    set(gca,'xticklabel',labels)
end



