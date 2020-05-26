% Input: number of folds k
% matrix X of features, with n rows (samples), d columns (features)
% vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of k rows, 1 column
function z = kfoldcv(k,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    z = zeros(k, 1);
    for i = 1:k
        T = [floor(n*(i-1)/k) + 1 : floor(n*i/k)];
        S = setdiff([1:n], T);
        s_dim= size(S);
        t_dim = size(T);
        theta = linreg(X(S, :), y(S));
        z(i) = sum((y(T) - X(T, :) * theta) .^ 2)/t_dim(2);
    end