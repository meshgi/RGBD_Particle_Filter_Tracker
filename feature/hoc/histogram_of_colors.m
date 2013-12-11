function freq = histogram_of_colors   (img, msk, ctrs )

img_reshaped = reshape( img, size(img,1)*size(img,2), size(img,3) );
img_valid = img_reshaped(find(msk==1),:);

num_pixels = size( img_valid, 1 );                                           % fg pixel count
num_bins = size(ctrs,1);                                                     % bin count
freq = zeros( num_bins, 1 );                                                 % bin counter initialization

d = zeros( num_bins, num_pixels);                                            % distance matrix
for c = 1:size(img,3)
    col_cnt = repmat(ctrs(:,c),1,num_pixels);
    col_img = repmat(img_valid(:,c)',num_bins,1);
    d = d + (double(col_cnt) - double(col_img)).^2;
end

[~, idx] = min(d);                                                           % label of each pixel (=coresponding bin)
freq = hist( idx, 1:num_bins );                                              % counting members of each bin
freq = freq / num_pixels;

% h = figure; subplot (2,2,1); imshow (img); subplot(2,2,2); imshow(msk); subplot(2,2,[3,4]); hist_vis (freq, ctrs); %DEBUG MODE
% close(h); % DEBUG MODE

if (isnan(freq(1)))
    disp ('Warning! Image has no foreground, thus num_pixels = 0');
end