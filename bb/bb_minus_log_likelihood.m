function x = bb_minus_log_likelihood ( x , features )

% minus log probability
l = 0;
for f = 1:size(features,2)
    feature_mlog_likelihood = x.dist(f) / features{f}.var;
    l = l + feature_mlog_likelihood;
end

% disp (exp(-l))
x.minus_log_likelihood = l;
