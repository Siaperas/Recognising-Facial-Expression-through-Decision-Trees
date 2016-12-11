function y = entropy(p, n)

y = -(p/(p+n))*log2(p/(p+n)) - (n/(p+n))*log2(n/(p+n));