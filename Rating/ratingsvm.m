% Input: number of labels k
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (1 or 2 ... or k) of the i-th sample
% Output: vector theta of d rows, 1 column
% vector b of k-1 rows, 1 column
function [theta b] = ratingsvm(k,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    s = zeros(n, k-1);
    for t = 1:n
        for l= 1:k-1
            if y(t)<=l
                s(t, l) = -1;
            else
                s(t, l) = 1;
            end
        end
    end
    H = [eye(d, d) zeros(d, k-1); zeros(k-1, d) zeros(k-1, k-1)];
    f = zeros(d+k-1, 1);
    A = [];
    for t = 1:n
        A_t = [-1 * s(t, :)' * X(t, :) diag(s(t, :))];
        A = [A; A_t];
    end
    z = zeros(k-2, k-1);
    for i = 1: k-2
        z(i, i) = 1;
    end
    for i = 1:k-2
        z(i, i+1) = -1;
    end
    A = [A; zeros(k-2, d) z];
    
    c = [-1 * ones(n*(k-1), 1); zeros(k-2, 1)];
    z = quadprog(H, f, A, c);
    theta = z(1:d);
    b = z(d+1:end);