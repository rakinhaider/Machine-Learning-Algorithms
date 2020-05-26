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
function [S thetaS] = forwardfitting(F,X,y)
    sz = size(X);
    n = sz(1);
    d = sz(2);
    S = [];
    theta_capS = [];
    fixed = zeros(n, 1);
    for f = 1:F
        jins = ismember(1:d, S);
        J_suj = [];
        theta_all = [];
        for j = 1:d
            if jins(j) == 0
                theta_j = linreg(X(:, j), y - fixed);
                theta_all = [theta_all theta_j];
                J_suj = [J_suj  sum((y - fixed - theta_j * X(:, j)).^2) * 0.5];
            end
        end
        [J_min, j_cap] = min(J_suj);
        indices = find(~jins);
        theta_capS = [theta_capS; theta_all(j_cap)];
        S = [S; indices(j_cap)];
        fixed = X(:, S) * theta_capS;
    end
    thetaS = theta_capS;