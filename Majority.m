function [s,majority] = Majority(binary_targets)

    n = size(binary_targets);
    s = sum(binary_targets);

    %Calculate mode of binary targets
    majority = 0;
    if s > (n/2)
        majority = 1;
    end
end