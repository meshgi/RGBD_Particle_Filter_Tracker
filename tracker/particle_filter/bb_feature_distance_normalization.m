function p = bb_feature_distance_normalization ( p )

    N = length(p);
    for i = 1:N
        if (p{i}.z == 0)
            d(i,:) = p{i}.dist;
        else
            d(i,:) = NaN(1,2);
        end
    end

    mind = min(d);
    maxd = max(d);

    d = (d - repmat(mind,N,1)) ./ repmat(maxd-mind,N,1); % bring it to range [0,1]

    for i = 1:N
        p{i}.dist = d(i,:);
    end
end