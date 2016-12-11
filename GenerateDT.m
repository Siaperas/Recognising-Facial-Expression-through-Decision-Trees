function [Tree] = GenerateDT(examples,attributes,binary_targets)
%Function that takes a matrix of training examples, with corresponding
%attributes and target data and returns a tree for classifying the data
%according to the target label supplied

%First split the target data in +ve and -ve examples. Each element 
%corresponds to an example with same row index - 0 = -ve & 1 = +ve
m = size(attributes,2);
n = size(examples,1);

majority = mode(binary_targets);
s = sum(binary_targets);
Tree = struct();

if (s == n) | (s == 0)
    %All examples agree so this node is a leaf with the value of binary_target
    Tree.op = [];
    Tree.kids = [];
    if s == 0
        Tree.class = 0;
    else
        Tree.class = 1;
    end
elseif m==0
    %No attributes so return mode of binary targets
    Tree.op = [];
    Tree.kids = [];
    Tree.class = majority;
else
    Tree.op = ChooseBestAttribute(examples,attributes,binary_targets);
    Tree.kids = cell(1,2);
    Tree.class = [];
    
    %Remove the best attribute from the list of attributes
    attributes(find(attributes==Tree.op)) = [];
    
    %Separate examples and targets according to best attribute value
    lft = find(examples(:,Tree.op));
    if size(lft,1) == 0
        %No examples to return leaf node for left tree
        SubTree = struct();
        SubTree.op = [];
        SubTree.kids = [];
        SubTree.class = majority;
        Tree.kids{1} = SubTree;
    else
        lft_ex = examples(lft,:);
        lft_tar = binary_targets(lft);
        Tree.kids{1} = GenerateDT(lft_ex,attributes,lft_tar);
    end
    
    rgt = find(examples(:,Tree.op) == 0);
    if size(rgt,1) == 0
        %No examples to return leaf node for right tree
        SubTree = struct();
        SubTree.op = [];
        SubTree.kids = [];
        SubTree.class = majority;
        Tree.kids{2} = SubTree;
    else
        rgt_ex = examples(rgt,:);
        rgt_tar = binary_targets(rgt);
        Tree.kids{2} = GenerateDT(rgt_ex,attributes,rgt_tar);
    end
end

end
