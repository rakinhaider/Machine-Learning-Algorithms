% Input: number of features F
% matrix X of features, with n rows (samples), d columns (features)
% X(i,j) is the j-th feature of the i-th sample
% vector y of scalar values, with n rows (samples), 1 column
% y(i) is the scalar value of the i-th sample
% Output: vector of selected features S, with F rows, 1 column
% vector thetaS, with F rows, 1 column
% thetaS(1) corresponds to the weight of feature S(1)
% thetaS(2) corresponds to the weight of feature S(2)
% and so on and so forth
function [S thetaS] = myopicfitting(F,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    S = [];
    theta_capS = [];
    fixed = zeros(n, 1);
    for f = 1:F
        jins = ismember(1:d, S);
        DJ = [];
        for j = 1:d
            if jins(j) == 0
                DJ = [DJ; -1*sum((y - fixed) .* X(:, j))];
            end
        end
        [DJ_max, j_cap] = max(abs(DJ));
        indices = find(~jins);
        j_cap = indices(j_cap);
        theta_cap_j_cap = linreg(X(:, j_cap), y - fixed);
        theta_capS = [theta_capS; theta_cap_j_cap];
        S = [S; j_cap];
        fixed = X(:, S) * theta_capS;
    end
    thetaS = theta_capS;