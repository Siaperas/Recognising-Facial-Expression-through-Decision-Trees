clear all;

%% Training and testing on clean and noisy data using cross validation

A = importdata('cleandata_students.mat');
B = importdata('noisydata_students.mat');
examplesClean = A.x; 
targetsClean = A.y; 
examplesNoisy = B.x; 
targetsNoisy = B.y;
attr_No = size(examplesClean, 2); 

for i=1:attr_No
    attributes(i) = i; 
end

%clean data
[confMatrixClean, classfRateClean, recallClean, precisionClean, F1Clean, indicesClean] =...
dataEvaluation(examplesClean, targetsClean, attributes); 

save clean_indices.mat indicesClean

%noisy data
[confMatrixNoisy, classfRateNoisy, recallNoisy, precisionNoisy, F1Noisy, indicesNoisy] =... 
dataEvaluation(examplesNoisy, targetsNoisy, attributes);

save noisy_indices.mat indicesNoisy


%% Training trees using entire clean data set

C = importdata('cleandata_students.mat');
examples = C.x; 
targets = C.y;

for i=1:6 
    for j=1:size(targets,1)
        if targets(j, 1) == i
            binTargets(j, i) = 1;
        else
            binTargets(j, i) = 0; 
        end             
    end

    [Tree(i)] = GenerateDT(examples, attributes, binTargets(:,i));
    DrawDecisionTree(Tree(i), '');
end

save clean_trees.mat Tree;


%% Pruning Example

figure(11)
pruning_example(examplesClean, targetsClean);
figure(12)
pruning_example(examplesNoisy, targetsNoisy);

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




