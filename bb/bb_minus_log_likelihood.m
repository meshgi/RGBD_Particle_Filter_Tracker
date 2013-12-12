function x = bb_minus_log_likelihood ( x , features )

% minus log probability
l = 0;
importance_sum = 0;
for f = 1:size(features,2)
    if ( features{f}.imp == 0 ) % feature is set to be ignored
        continue;
    else
        importance_sum = importance_sum + 1.0 / features{f}.imp;
        feature_mlog_likelihood = x.dist(f) / features{f}.nrm / features{f}.imp;
        l = l + feature_mlog_likelihood;
    end
end

% disp (exp(-l))
% bringing the range from [0,1/imp1 + 1/ imp2 +...] to [0,1] 
x.minus_log_likelihood = l / importance_sum;
