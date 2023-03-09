% original_features = the variable which holds the data that needs to be
% augmented
% original_mark = class labels of the data (Nx1 vector, N - number of data)
% dataExtension = number to which the data will be augmented
% neighbours = for KNN search of the data points (must be lower than the
% number of data)

function final_features = SMOTE(original_features, original_mark, dataExtension, neighbours)%, neighbours, double, repeat)

ind = find(original_mark == 1);
if (neighbours == 1)
    neighbours = 2;
end
% P = candidate points
P = original_features(ind,:);
T = P';

% X = Complete Feature Vector
X = T;

% Finding the 5 positive nearest neighbours of all the positive blobs
%I = nearestneighbour(T, X, 'NumberOfNeighbours', neighbours);
[I,dist] = knnsearch(X',X','k',neighbours);

[r c] = size(I);
S = [];
th=0.001;
repeat = (dataExtension - length(original_features))/(neighbours-1)/length(original_features) - 1;
if isinf(repeat)
    repeat = dataExtension;
end
if(floor(repeat)~=repeat)
    repeat = floor(repeat)+1;
end
for i=1:r
    for j=2:c
        index = I(i,j);
%         new_P=(1-th).*P(i,:) + th.*P(index,:);
        new_P = (P(index,:) - P(i,:)).*rand + P(i,:);
%         if (double)
            for h = 1:repeat
                new_P1 = (P(index,:) - P(i,:)).*rand + P(i,:);
                S = [S; new_P1];
            end
%         end
        S = [S; new_P];
    end
end
% if (double)
% for i = 1:5
%     new_P1 = (P(index,:) - P(i,:)).*rand + P(i,:);
%     S = [S; new_P1];
% end
% end
% original_features(outlier_idx,:) = [];
S = S(1:(dataExtension - length(original_features)));
original_features = [original_features;S];
[r c] = size(S);
mark = ones(r,1);
original_mark = [original_mark;mark];

% train_incl = ones(length(original_mark), 1);
% 
% I = nearestneighbour(original_features', original_features', 'NumberOfNeighbours', 4);
% I = I';
% for j = 1:length(original_mark)
%     len = length(find(original_mark(I(j, 2:4)) ~= original_mark(j,1)));
%     if(len >= 2)
%         if(original_mark(j,1) == 1)
%          train_incl(original_mark(I(j, 2:4)) ~= original_mark(j,1),1) = 0;
%         else
%          train_incl(j,1) = 0;   
%         end    
%     end
% end
final_features = original_features;%(train_incl == 1, :);
final_mark = original_mark;%(train_incl == 1, :);

% %%% Reverse K-NN
% 
% mitosis_features = new_feature_mat;
% mitosis_mark= new_mark;
% 
% % P = candidate points
% P = mitosis_features;
% T = P';
% 
% % X = Complete Feature Vector
% X = T;
% 
% % Finding the 5 positive nearest neighbours of all the positive blobs
% I = nearestneighbour(T, X, 'NumberOfNeighbours', 4);
% 
% I = I';
% len = length(new_mark);
% incl_blob = ones(len,1);
% total=[];
% for i=1:len
%     total = length(find(I(:,2:4)==i));
%     if(total <= 1)
%         incl_blob(i,1) = 0;
%     end
% end
% 
% final_mark = new_mark(find(incl_blob == 1));
% final_features = mitosis_features(find(incl_blob == 1),:);
% 
% 
% 
% 
% %%%
% 
% % % Updating the SVM file
% % [r c] = size(new_feature_mat);
% % fp = fopen('SVMtrainNew.txt', 'w');
% % for i = 1:r
% %     fprintf(fp, '%d ',new_mark(i,1));
% %     for j = 1:c
% %     
% %        fprintf(fp, '%d:%d ', j, new_feature_mat(i,j));     
% %     
% %     end
% %     fprintf(fp, '\n');
% % end
% % fclose('all');
% % 
% % new_mark = new_mark';
% % % Updating the Neural Network file
% % 
% % 
% % % save('NURtrainNew.mat','new_feature_mat');
% % % save('NURmarkNew.mat','new_mark');
% % 
% % mitosis_features = new_feature_mat;
% % mitosis_mark= new_mark';
% % % save('NURtrain.mat','mitosis_features');
% % % save('NURmark.mat','mitosis_mark');
% % 
end