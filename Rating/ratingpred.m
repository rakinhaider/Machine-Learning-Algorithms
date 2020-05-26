% Input: number of labels k
% vector theta of d rows, 1 column
% vector b of k-1 rows, 1 column
% vector x of d rows, 1 column
% Output: label (1 or 2 ... or k)
function label = ratingpred(k,theta,b,x)
    for l = 1:k-1
        if dot(theta, x) <= b(l)
            label = l;
            return
        end
    end
    label = k;
    return
    