function [predictions, testTargets, testN] = crossValidation(examples, targets, attributes, indices, k)
% function that runs on each fold of 10-fold cross validation and creating 
% 6 trees for each fold and testing them on test data, returing predicted
% classification for each test example

    %indices for fold k
    valInd = find(indices~=k);
    testInd = find(indices==k);

    %splits examples to validation and test
    valExamples = examples(valInd,:);
    testExamples = examples(testInd,:);
    valTargets = targets(valInd,:);
    
    testTargets = targets(testInd,:); 

    valN = size(valExamples,1);
    testN = size(testExamples,1); 

    %generate 6 trees
    for i=1:6 
        for j=1:valN
            if valTargets(j, 1) == i
                valBinTargets(j, i) = 1;
            else
                valBinTargets(j, i) = 0; 
            end             
        end

        [Tree(i)] = GenerateDT(valExamples, attributes, valBinTargets(:,i));
        %DrawDecisionTree(Tree(i), '');
    end

    %obtain predictions for test data using the generated trees
    % a=1, ambiguity cases solved my random classification
    % a=2, ambiguity cases solved using prior example distribution 
    a = 1; 
    switch a 
        case 1
            predictions = testTrees(Tree, testExamples); 
        case 2
            predictions = testTreesWithPrior(Tree, testExamples, testTargets); 
    end
    