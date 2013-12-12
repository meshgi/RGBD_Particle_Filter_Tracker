function pr = bb_normalize_minus_log_likelihood (li)

% K: a constant that transform range of sum of distances from [0,1] to [0,K]
% using this constant the probability would be [exp(-K),1]
% exp(-36) = 0
K = 36;

minli = min(li);
maxli = max(li);

% bring it to range [0,K]
normal_li = (K / (maxli-minli)) * (-minli + li);

% making probability
pr = (1.0 / sum (exp(-normal_li))) * exp(-normal_li);


% hist(pr,100);
if any(isnan(pr))
    disp ('HOLY CRAB!!!');
end

