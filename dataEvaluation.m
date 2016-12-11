function[confusionMatrix, classfRate, recall, precision, F1, indices] = dataEvaluation(examples, targets, attributes)
% function that calculates the indices for cross validatin and evaluates 
%predicted data by calculating different measures for evaluation for each 
%fold of cross validation and then taking the average of the evaluation measures

N = size(targets,1);

indices = crossvalind('Kfold', N, 10);  %generate indices

confSum = zeros(6,6); 
recall = zeros(6,1);
precision = zeros(6,1); 
F1 = zeros(6,1);
error = zeros(10,1); 

for k=1:10
    %get predictions for each fold 
    [predictions, testTargets, testN] = crossValidation(examples, targets, attributes, indices, k);
    
    [corr] = correctlyClassified(predictions, testTargets); 
    
    confSum =confSum + confusionMatrixGeneration(predictions, testTargets); %confusion matrix for each fold
    error(k) = (testN - corr)/testN; %wrongly classified
end


confusionMatrix = confSum./10   %average confusion matrix
classfRate = 1 - sum(error)/10  %classification rate calculation


a = 1; %equal weight for recall and precision in F1

%calculate recall/precision/F1 for each emotion using confusion matrix
for i=1:6
    recall(i) = 100*confusionMatrix(i,i)/sum(confusionMatrix(i, :));
    precision(i) = 100*confusionMatrix(i,i)/sum(confusionMatrix(:,i));
    F1(i) = (1+a)*(recall(i)*precision(i))/(a*precision(i)+recall(i)); 
end