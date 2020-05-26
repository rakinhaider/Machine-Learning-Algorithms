% Input: vector alpha of weights, with L rows, 1 column
% vector theta of feature indices, with L rows, 1 column
% vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = adapred(alpha,theta,x)
    sz = size(x);
    % n = sz(1);
    d = sz(2);
    sgn = ones(1, d);
    sgn(x<=0) = -1;
    if sum(alpha .* sgn(theta)') > 0
        label = 1;
    else
        label = -1;
    end
    