% Function for giving transient data of the esxpert user
% expertIndex is the index of the expert user
function [expertSet, expertOut, sigFeatures] = CCAExpert(sigFeatures, expertIndex, selFeatures, patRec)
sigFeatures_expert = sigFeatures;
expertSubject = expertIndex - 1; % index of the subject in the data set
indExpert = (1:sigFeatures.nDataPerSubject(1)) + expertSubject*sigFeatures.nDataPerSubject(1);
sigFeatures_expert.transFeatures = sigFeatures.transFeatures(indExpert,:);
indRest = setdiff(1:size(sigFeatures.transFeatures,1),indExpert);
sigFeatures.transFeatures = sigFeatures.transFeatures(indRest,:);
sigFeatures.nDataPerSubject = sigFeatures.nDataPerSubject(2:end);
[expertSet, expertOut, ~, ~, ~, ~] = GetSets_Stack_TransientMov_Luis_CrossRepetition(sigFeatures_expert, selFeatures, 0.25, patRec, 0); 
end