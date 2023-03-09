% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and
% Chalmers University of Technology. All authors’ contributions must be kept
% acknowledged below in the section "Updates % Contributors".
%
% Would you like to contribute to science and sum efforts to improve
% amputees’ quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
%  Function to classifies the testing sets
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2014-11-07 / Le Khong     / Creation
% 2015-12-29 / Max Ortiz    / Rename to fit coding standard
% 2018-09-21 / Andrea Mannini   / Corrected multiclass output (min score instead of "find")
% 2022-04-12 / Katarina Dejanovic / Changed multiclass output using
% function predict (max score instead of min score)
% 20xx-xx-xx / Author       / Comment on update

function [outMov, outVector] = SVMTest(patRecTrained, tSet)
% svmStruct = patRecTrained.SVM;
% nM = size(svmStruct,2);
% 
% for i = 1:nM
%     outVector(i,1) = svmclassify(svmStruct(i),tSet);
% end
% outMov = find(outVector);
global score;

svmStruct = patRecTrained.SVM;
nM = size(svmStruct,2);
 
for i = 1:nM
%     outVector(i,1) = svmclassify(svmStruct(i),tSet);  
    
    data = tSet;
    % AM: 20180921
    % scaling (svmtrain-svmclassify)
%     if ~isempty(svmStruct(i).ScaleData)
%         for c = 1:size(data, 2)
%             data(:,c) = svmStruct(i).ScaleData.scaleFactor(c) * ...
%                 (data(:,c) +  svmStruct(i).ScaleData.shift(c));
%         end
%     end
    % KD: 20220412
    % scaling (fitcsvm-predict)
    if ~isempty(svmStruct{i}.Mu)
        data = (data - svmStruct{i}.Mu)./svmStruct{i}.Sigma;
    end

    
%     sv = svmStruct(i).SupportVectors;
%     alphaHat = svmStruct(i).Alpha;
%     bias = svmStruct(i).Bias;
%     kfun = svmStruct(i).KernelFunction;
%     kfunargs = svmStruct(i).KernelFunctionArgs;
%     f(i,:) = (feval(kfun,sv,data,kfunargs{:})'*alphaHat(:)) + bias;

%     sv = svmStruct{i};
%     f(i,:) = data*sv.Beta + sv.Bias;

    %KD: 20220412
    [~,f(i,:)] = predict(svmStruct{i},data);

%     landMarks = svmStruct{i}.SupportVectors;
% %     polyF = (1+landMarks*data').^3;
%     coeff = nthroot((svmStruct{i}.Alpha.*svmStruct{i}.SupportVectorLabels)',3);
%     polyF = 0;
%     for lM = 1:size(landMarks,1)
%         polyF = polyF + (coeff(lM)+coeff(lM)*landMarks(lM,:)*data').^3;
%     end
% %     polyF = (coeff*ones(size(landMarks,1),1)+coeff*landMarks*data').^3;
%     f(i) = polyF + svmStruct{i}.Bias;
%     f(i) = coeff*polyF + svmStruct{i}.Bias;
%     gausF = exp(-sum((landMarks - data).^2,2)./svmStruct{i}.KernelParameters.Scale);
%     gausF = norm(data - landMarks);
%     f(i) = (svmStruct{i}.Alpha.*svmStruct{i}.SupportVectorLabels)'*gausF + svmStruct{i}.Bias;
    
%     outclass = sign( f(i,:) );
%     groupnames = svmStruct.GroupNames;
%     [~,groupString,glevels] = grp2idx(groupnames); 
%     outclass(outclass == -1) = 2;
%     outVector3(i,1) = glevels(outclass(~isnan(outclass)),:);
    
    
end
% outMov = find(outVector);

% outVector = f<0; 
% [~, outMov] = min(f); % have to use min to deal with MATLAB opposite convention

%KD: 20220412
outVector = f(:,2)>= max(f(:,2));
% outVector = f>=max(f);
[~, outMov] = max(f(:,2));
if isfield(patRecTrained,'posteriorProbability')
    if (max(f(:,2)) < 0) && patRecTrained.posteriorProbability
        outMov = 0;
        outVector = zeros(nM);
    end
%     if (outMov == 5)&&(max(f(:,2)) < 0.5)
%         outMov = 0;
%         outVector = zeros(nM);
%     end
%     if (outMov ~= 5)&&(max(f(:,2)) < 0.15)
%         outMov = 0;
%         outVector = zeros(nM);
%     end
end
% [~, outMov] = max(f);
score(:,end+1) = f(:,2);