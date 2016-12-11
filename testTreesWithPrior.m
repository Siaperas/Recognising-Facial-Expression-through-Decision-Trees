function [predictions] = testTreesWithPrior(Tree, examples, targets)
% function that classifies each example to a class
% Classification of examples assigned to more than 1 class is done randomly

t = 6; 
N = size(examples, 1); 

predictions = zeros(N, t);  

for i=1:t 
    for j=1:N
        predictions(j, i) = testExample(Tree(i), examples(j,:));
    end
end

classesRank = priorCalculation(targets);

for i=1:N
        
    if sum(predictions(i,:))>1  %if classified to more than 1 class
        indMulti = find(predictions(i,:));

        % classification based on prior distribution
        if(find(indMulti(:)==classesRank(1)))
            chosenClass = classesRank(1);
        elseif(find(indMulti(:)==classesRank(2)))
            chosenClass = classesRank(2);
        elseif(find(indMulti(:)==classesRank(3)))
            chosenClass = classesRank(3);
        elseif(find(indMulti(:)==classesRank(4)))
            chosenClass = classesRank(4);
        elseif(find(indMulti(:)==classesRank(5)))
            chosenClass = classesRank(5);
        elseif(find(indMulti(:)==classesRank(6)))
            chosenClass = classesRank(6);
        end

        for l=1:size(indMulti, 2)
            if l~=chosenClass 
              predictions(i, indMulti(1,l)) = 0; 
            end
        end
    end

    if sum(predictions(i,:))==0 %if not classified
        predictions(i, int8(5*rand + 1)) = 1; % random classification
    end
end

end

function [result] = testExample(Tree, example) 
% Function that traverses the tree untill a leaf node is found.
% The example is either classified or not classified by a tree, based on
% the class value of the leaf node (1 or 0)

    p = 1; 
    while p==1
        s = Tree.class; 
        if s>=0 & s<=1
            result = s;
            p = 2; 
        elseif example(:,Tree.op)==1
            Tree = Tree.kids{1}; 
        else
            Tree = Tree.kids{2}; 
        end
    end
    
end