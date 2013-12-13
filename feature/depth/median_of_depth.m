function [nominal, variance, avg] = median_of_depth ( dmap, mask)

pts = dmap(:);
% pts = pts(find(mask(:) == 1));  % enables background sutraction

if isempty(pts)
    nominal = 1;
    variance = -1;
    avg = -1;
    return;
end

nominal = double(median(pts))/255;
variance = var(double(pts')/255);
avg = mean(pts)/255;

% h = figure; subplot(2,2,1); imshow(dmap); subplot(2,2,2); imshow(mask); % DEBUG MODE
% subplot(2,2,3); imhist(dmap(:)); subplot(2,2,4); imhist(pts); disp(nominal); % DEBUG MODE
% close(h); % DEBUG MODE