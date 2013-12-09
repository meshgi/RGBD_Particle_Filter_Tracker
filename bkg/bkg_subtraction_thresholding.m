function [rgb_msk, dep_msk] = bkg_subtraction_thresholding ( rgb_raw, dep_raw, rgb_bkg , dep_bkg)

% MATLAB is stupid! unit8 is not enough for calculations, it should be converted into double

diff = double(rgb_raw) - double(rgb_bkg);
s = sum(abs(diff),3);

thr = 100;
% 
% sc = histc(s(:),max(s(:)));
% lnp = lognfit(sc); %log_normal_dist_params
% energy = logncdf(thr,lnp(1),lnp(2))


mask = s>thr;

rgb_msk = mask; dep_msk = mask;

% % visualization
% figure;
% subplot (6,2,[1,3]);        imshow(rgb_raw);
% subplot (6,2,[5,7]);        imshow(rgb_bkg);
% subplot (6,2,[9,11]);       imshow(mask);
% subplot (6,2,[2,4,6]);      image(s); colormap ('hot');
% subplot (6,2,[8,10,12]);    hist(s(:),max(s(:)));


