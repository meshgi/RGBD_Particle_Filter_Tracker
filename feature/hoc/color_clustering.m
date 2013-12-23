function rgb_ctr = color_clustering (img , sample_count , rgb_bins , init_bb)

if isempty(img)
    rgb_ctr = [];
    return
end

% get all points of image, sample them choosing points in equivalent
% distance
all_pixels = reshape (img(:,:,1:3) , size(img,1) * size(img,2) , size(img,3));
sample_idx = floor (linspace(1,size(all_pixels,1),sample_count-100));

% adding subject appearance
obj = bb_content(img,init_bb);
obj_pixels = reshape (obj(:,:,1:3) , size(obj,1) * size(obj,2) , size(obj,3));
obj_sample_idx = floor (linspace(1,size(obj_pixels,1),100));


% feed these sample points (RGB) to K-means
samples =    double (all_pixels(sample_idx,:)); 
sample_obj = double (obj_pixels(obj_sample_idx,:));
samples = [samples ; sample_obj];

opts=statset('Display','final');
[~,rgb_ctr]=kmeans( samples ,rgb_bins,'Options',opts);

