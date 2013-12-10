function x = bb_minus_log_likelihood ( x , features )

% minus log probability
likelihood = 0;
for f = 1:size(features,2)
    feature_likelihood = x.dist(f) / features{f}.var;
    likelihood = likelihood + feature_likelihood;
end

if (isnan(likelihood))
    [x.dist(1), x.dist(2)]
end
x.minus_log_likelihood = likelihood;