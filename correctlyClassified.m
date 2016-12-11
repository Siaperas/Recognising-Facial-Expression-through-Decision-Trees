function [correct] = correctlyClassified(predictions, testTargets)
% This function finds the number of correctly classified examples 
% by comparing predictions to target values

correct = 0; 
N = size(predictions,1);

for i=1:N
    ind = find(predictions(i,:)); % prediction index
    if (ind == testTargets(i))
        correct = correct + 1; 
    end
end