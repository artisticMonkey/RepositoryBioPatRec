% Function for removing data from sigFeatures which belong to particular
% subjects
% subRemove = index of the subject you wish to remove (eg. [1 3 5])
function sigFeaturesRemoved = removeSubjects(sigFeatures,subRemove)
removeInd = [];
for r = 1:length(subRemove)
    removeInd = [removeInd, ((subRemove(r) - 1)*sigFeatures.nDataPerSubject(1) + 1):(subRemove(r)*sigFeatures.nDataPerSubject(1))];
end
subjects = setdiff(1:size(sigFeatures.transFeatures,1),removeInd);
sigFeaturesRemoved = sigFeatures;
sigFeaturesRemoved.nDataPerSubject = sigFeatures.nDataPerSubject(length(subRemove) + 1:end);
sigFeaturesRemoved.transFeatures = sigFeatures.transFeatures(subjects,:);
end