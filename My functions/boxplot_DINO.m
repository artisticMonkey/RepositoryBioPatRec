function boxplot_DINO(data, display_all, jitter)%, properties (of the boxplot)

%%% aggiungere i default (jitter = 0.3, display_all = true)

% boxplots the data
boxplot(data)

%%% remove outliers from data (for plotting purposes)
% find outliers information
outliersH = findobj(gca,'tag','Outliers');

% create matrix that will contain all data excluding outliers
dataNoOutliers = data;
for i = 1:length(outliersH)
    % if there is no outlier, do nothing
    if isnan(get(outliersH(i),'YData'))
    else
        % otherwhise, extract on which column we found outliers
        column = unique(get(outliersH(i),'XData'));
        
        % extract the indexes of the outliers
        rows   = dataNoOutliers(:,column) == get(outliersH(i),'YData');
        
        % merge all logical indexes in a single column vector
        rows   = any(rows,2);
        
        % remove the outliers from the data
        dataNoOutliers(rows,column) = NaN;
    end
end

% adds single samples overlayed, if required
if (display_all > 0)
    % calculate the offset in the X direction for each data point
    offsetPos = jitter*(rand(size(data))-0.5);
    
    % add the offset to the "nominal" X value (i.e. from 1 to the number of
    % boxplots)
    Xmatrix   = repmat(1:size(data,2),size(data,1),1) + offsetPos;
    
    % plot the individual data on top of the boxplot
    hold on
    if display_all == 1 % all data
        plot(Xmatrix, data,'ob')
    elseif display_all == 2 % all data excluding outliers
        plot(Xmatrix, dataNoOutliers,'ob')
    end
    hold off
end

% %% useful properties
% % position of the boxplots
% positions = [1 1.4 2 2.4];
% boxplot(M,'positions',positions)
% 
% coloured boxes
% a=[217 83 25]./255;
% b=[0 114 189]./255;
% color = [a; b; a; b]; % se sono 4
% h = findobj(gca,'Tag','Box');
% for j=1:length(h)
%    patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.3);
% end
% 
% % coloured outliers
% h = findobj(gcf,'tag','Outliers');
% for j=1:length(h)
%      plot(get(h(j),'XData'),get(h(j),'YData'),'r+','MarkerSize',5);
% end
% hold on 
