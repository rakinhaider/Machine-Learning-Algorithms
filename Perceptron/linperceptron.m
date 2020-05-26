% Input: number of iterations L
%       matrix X of features, with n rows (samples), d columns (features)
%       X(i,j) is the j-th feature of the i-th sample
%       vector y of labels, with n rows (samples), 1 column
%       y(i) is the label (+1 or -1) of the i-th sample
% Output: vector theta of d rows, 1 column
function theta = linperceptron(L,X,y)
    sz = size(X);
    theta = zeros(1, sz(2));
    for iter = 1:L
        for t = 1:sz(1)
            if y(t) * dot(theta, X(t, :)) <= 0
                theta = theta + y(t) * X(t, :);
            end
        end
    end
	theta = theta';