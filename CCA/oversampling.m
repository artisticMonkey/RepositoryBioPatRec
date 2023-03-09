% Function for oversmapling the calibration and expert user's data
% This function will oversample 
function [dataCalOversampled, dataExpertOversampled] = oversampling(dataCal, dataCalOut, dataExpert, dataExpertOut, dataExtension, flag_OS, flag_CCA)
classes = size(dataCalOut,2);
numFeatures = size(dataCal,2);
dataCalOversampled = [];
dataExpertOversampled = [];
for i = 1:classes
    movementInd = find(dataCalOut(:,i)); % finding the indeces for each movements of the calibration set
    cal_idx_mov = movementInd';
    switch flag_OS
        case 1 % Random point extraction
            if (flag_CCA)
                expTemp = dataExpert(dataExpertOut(:,i)==1,:);% choosing data from the expert to be used for calibration
                maxExp = max(expTemp);
                minExp = min(expTemp);
            end
            maxFeatures = max(dataCal(cal_idx_mov,:));
            minFeatures = min(dataCal(cal_idx_mov,:));
            newData = [];
            newDataExp = [];
            for f = 1:numFeatures
                % finding random points between the max and
                % min of the calibration data
                newData = [newData, (maxFeatures(f) - minFeatures(f)).*rand((dataExtension - length(movementInd)),1) + minFeatures(f)];
                if (flag_CCA)
                newDataExp = [newDataExp, (maxExp(f) - minExp(f)).*rand((dataExtension - 20),1) + minExp(f)];
                end
            end
            dataCalOversampled = [dataCalOversampled; dataCal(cal_idx_mov,:); newData];
            if(flag_CCA)
            dataExpertOversampled = [dataExpertOversampled; expTemp; newDataExp];
            end
        case 2 % SMOTE
            newData = [];
            if(flag_CCA)
                newDataExp = [];
                expTemp = dataExpert(dataExpertOut(:,i)==1,:);%transSetsExpert((1:20)+(i-1)*20,:); % choosing random data points from expert for calibration
            end
            for f = 1:numFeatures % augmement data for one feature at a time
                newData = [newData, SMOTE(dataCal(cal_idx_mov,f),sum(dataCalOut(cal_idx_mov,:),2),dataExtension, length(movementInd)-1)];%SMOTE(transTSets1(cal_idx_mov,f),sum(transTOuts1(cal_idx_mov,:),2),2,0,0)]; %(dataExtension >= 40)
                if ((dataExtension > 50)&&(flag_CCA))
                    newDataExp = [newDataExp, SMOTE(expTemp(:,f),sum(dataExpertOut(dataExpertOut(:,i)==1,:),2),dataExtension, 4)];%SMOTE(expTemp(:,f),sum(transOutsExpert((1:20)+(i-1)*20,:),2),3,0,1)];
                end
            end
            dataCalOversampled = [dataCalOversampled; newData];
            if(flag_CCA)
                if (dataExtension == 50)
                    newDataExp = expTemp; 
                end
                dataExpertOversampled = [dataExpertOversampled; newDataExp];
            end
        otherwise
            dataCalOversampled = [dataCalOversampled; dataCal(cal_idx_mov,:)];
            if (flag_CCA)
                dataExpertOversampled = [dataExpertOversampled; dataExpert(cal_idx_mov,:)];          
            end
    end
end
end