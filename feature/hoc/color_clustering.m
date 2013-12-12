function rgb_ctr = color_clustering (img , sample_count , rgb_bins )

if isempty(img)
    rgb_ctr = [];
    return
end

% get all points of image, sample them choosing points in equivalent
% distance
all_pixels = reshape (img(:,:,1:3) , size(img,1) * size(img,2) , size(img,3));
sample_idx = floor (linspace(1,size(all_pixels,1),sample_count));
samples =    double (all_pixels(sample_idx,:));

% feed these sample points (RGB) to K-means
opts=statset('Display','final');
[~,rgb_ctr]=kmeans( samples ,rgb_bins,'Options',opts);

