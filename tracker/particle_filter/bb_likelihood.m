function x = bb_likelihood ( x , features )

likelihood = 1;
for f = 1:size(features,2)
    feature_likelihood = exp( - x.dist(f) / features{f}.var );
    likelihood = likelihood * feature_likelihood;
end

x.likelihood = likelihood;


