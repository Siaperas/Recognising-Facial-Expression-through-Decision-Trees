function [best] = ChooseBestAttribute(examples,attributes,binary_targets)
%Selects the best attribute to classify the set of examples by selecting
%the attribute with the greatest information gain

p = sum(binary_targets);
m = size(binary_targets,1);
n = m - p;
atts = size(attributes,2);
IGs = zeros(atts,1);

%First calculate entropy of the set
Is = Entropy(p,n);
for i=1:atts
    %Calculate the information gain for this attribute
    [p0,p1,n0,n1] = deal(0);
    for j=1:m
        if  binary_targets(j) == 1
            if examples(j,attributes(i)) == 1
                p1 = p1+1;
            else
                p0 = p0+1; 
            end
        else
            if examples(j,attributes(i)) == 1
                n1 = n1+1;
            else
                n0 = n0+1; 
            end
            
        end
    end
    
    Remainder = (((p0+n0)/(p+n)) * Entropy(p0,n0)) + (((p1+n1)/(p+n)) * Entropy(p1,n1));
    IGs(i) = Is - Remainder;   
end

%Select the largest information gain
[Y,I] = max(IGs);
best = attributes(I);
end

function [I] = Entropy(p,n)
    sum = p+n;
    if (p==0)
        Ip = 0;
    else
        Ip = -((p/sum)*log2(p/sum));
    end
    
    if (n==0)
        In = 0;
    else
        In = -((n/sum)*log2(n/sum));
    end
    
    I = Ip+In;
end