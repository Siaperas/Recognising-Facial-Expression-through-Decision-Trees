function [rank] = priorCalculation(targets)
% Rank 6 emotions, based on the number of occurances in the data set

counter = zeros(6,1); 
rank = zeros(6,1);

for i=1:size(targets,1)
    counter(targets(i)) = counter(targets(i))+1;
end

for j=1:6
    maxval = max(counter);
    maxInd = find(counter(:)==maxval);
    rank(j) = maxInd(1);
    counter(maxInd) = 0;
end

