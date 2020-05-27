% Input: scalar q
% vector mu_pos of d rows, 1 column
% vector mu_neg of d rows, 1 column
% scalar sigma2_pos
% scalar sigma2_neg
% vector x of d rows, 1 column
% Output: label (+1 or -1)
function label = probcpredict(q,mu_pos,mu_neg,sigma2_pos,sigma2_neg,x)
    sz = size(x);
    d = sz(1);
    t = log(q/(1-q));
    t = t - (d/2) * log(sigma2_pos/sigma2_neg);
    t = t - (1/(2*sigma2_pos)) * sum((x-mu_pos).^2);
    t = t + (1/(2*sigma2_neg)) * sum((x-mu_neg).^2);
    
    if t > 0
        label = 1;
    else
        label = -1;
    end