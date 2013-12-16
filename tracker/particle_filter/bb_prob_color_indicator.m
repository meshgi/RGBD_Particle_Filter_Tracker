function col = bb_prob_color_indicator (L , Z)
N = length(L);
col = zeros(N,3);

if (any(L))
    mxl = log(max(L));
    mnl = log(min(L(find(L>0))));
    
    col(find(L>0),1) = ceil(254 / (mxl-mnl) * bsxfun(@minus,log(L(find(L>0))),mnl));

    col(find(col>255)) = 255;
    col(find(col<0)) = 0;
    col(isnan(col)) = 0;

    col(:,2) = col(:,1); 
    col(:,3) = col(:,1);
end

% make occluded boxes red
col(find(Z == 1),:) = repmat([255,0,0],sum(Z==1),1);

col = double(col) / 255;
