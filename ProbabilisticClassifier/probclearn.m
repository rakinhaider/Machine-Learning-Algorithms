% Input: matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of labels, with n rows (samples), 1 column
% y(i) is the label (+1 or -1) of the i-th sample
% Output: scalar q
% vector mu_pos of d rows, 1 column
% vector mu_neg of d rows, 1 column
% scalar sigma2_pos
% scalar sigma2_neg
function [q, mu_pos, mu_neg, sigma2_pos, sigma2_neg] = probclearn(X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    
    k_pos = 0;
    k_neg = 0;
    mu_pos = zeros(d, 1);
    mu_neg = zeros(d, 1);
    
    for t= 1:n
        if y(t) == 1
            k_pos = k_pos + 1;
            mu_pos = mu_pos + X(t, :)';
        else
            k_neg = k_neg + 1;
            mu_neg = mu_neg + X(t, :)';
        end
    end
    q = k_pos / n;
    mu_pos = (1/k_pos) * mu_pos;
    mu_neg = (1/k_neg) * mu_neg;
    sigma2_pos = 0;
    sigma2_neg = 0;
    
    for t = 1:n
        if y(t) == 1
            sigma2_pos = sigma2_pos + sum((X(t,:)' - mu_pos).^2);
        else
            sigma2_neg = sigma2_neg + sum((X(t,:)' - mu_neg).^2);
        end
    end
    
    sigma2_pos = (1 / (d * k_pos)) * sigma2_pos;
    sigma2_neg = (1 / (d * k_neg)) * sigma2_neg;