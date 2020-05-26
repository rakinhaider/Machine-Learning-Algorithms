% Input: number of bootstraps B
% matrix X of features, with n rows (samples), d columns (features)
% vector y of scalar values, with n rows (samples), 1 column
% Output: vector z of B rows, 1 column
function z = bootstrapping(B,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    z = zeros(B, 1);
    rng(0)
    for i = 1:B
        u = zeros(n, 1);
        S = [];
        for j = 1:n
            k = randi([1, n], 1, 1);
            u(j) = k;
            S = union(S, [k]);
        end
        T = setdiff([1:n], S);
        t_dim = size(T);
        theta = linreg(X(u, :), y(u));
        z(i) = sum((y(T) - X(T, :) * theta) .^ 2)/t_dim(2); 
        % break
    end