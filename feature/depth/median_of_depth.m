function [nominal, variance, avg] = median_of_depth ( dmap, mask)

pts = dmap(:);
pts = pts(find(mask(:) == 1));

if isempty(pts)
    nominal = 255;
    variance = -1;
    avg = -1;
    return;
end

nominal = median(pts);
variance = var(double(pts'));
avg = mean(pts);