function pr = bb_normalize_minus_log_likelihood (li)

normal_li = bsxfun(@minus, li, min(li));
pr = (1.0 / sum (exp(-normal_li))) * exp(-normal_li);

% hist(pr);

if any(isnan(pr))
    disp ('jiiiiiiigho havaar');
end

