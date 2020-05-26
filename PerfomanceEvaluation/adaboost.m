% Input: number of iterations L
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: vector alpha of weights, with L rows, 1 column
% vector theta of feature indices, with L rows, 1 column
function [alpha theta] = adaboost(L,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    alpha = zeros(L, 1);
    theta = ones(L, 1);
    W_t = ones(n, 1);
    W_t = W_t / n;
    
    for r = 1:L
        sgn = ones(n, d);
        sgn(X<=0) = -1;
        [epsilon, theta_r] = min(-1*sum(W_t .* y .* sgn));
        theta(r) = theta_r;
        if epsilon >= 0
            break
        end
        epsilon = max(epsilon, -0.99);
        alpha(r) = 0.5 * log((1-epsilon)/(1+epsilon));
        exp(alpha(r) * y .* sgn(:, theta(r)));
        W_t = W_t .* exp(-alpha(r) * y .* sgn(:, theta(r)));
        Z = sum(W_t);
        W_t = W_t / Z;
    end