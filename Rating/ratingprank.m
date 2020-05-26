% Input: number of iterations L
% number of labels k
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (1 or 2 ... or k) of the i-th sample
% Output: vector theta of d rows, 1 column
% vector b of k-1 rows, 1 column
function [theta b] = ratingprank(L,k,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    b = zeros(k-1, 1);
    theta = zeros(d, 1);
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
    for l=1:k-1
        b(l) = l;
    end
    
    for iter = 1:L
        for t = 1:n
            E = find((s(t, :)' .* (dot(theta, X(t, :)) - b)) <= 0);
            if ~isempty(E)
                % s(t, E)
                theta = theta + sum(s(t, E)) * X(t, :)';
                b(E) = b(E) - s(t, E)';
            end
        end
    end