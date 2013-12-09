function [bkg_rgb,bkg_dep] = offline_bkg_detection( method, dataset_name , sample_count )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[vid_param, directory, num_frames, ~, ~, ~]   = video_info(dataset_name);


%% method: temporal median
tmp = randperm(num_frames);
rand_frames = tmp(1:sample_count); % get m frames  
    
for fr = 1:sample_count
	[rgb, dep] =  read_frame(vid_param, directory, rand_frames(fr));
	bkg_sample_rgb(fr,:,:,:) = rgb;
    bkg_sample_dep(fr,:,:,:) = dep; 
%     subplot(1,2,1);  imshow(rgb);
%     subplot(1,2,2);  imshow(dep);
%     drawnow;
end

bkg_rgb = bkg_median ( bkg_sample_rgb );
% subplot(1,2,1);  imshow(bkg_rgb);
% drawnow;
bkg_dep = bkg_median ( bkg_sample_dep );
% subplot(1,2,2);  imshow(bkg_dep);


end

function im = bkg_median ( samples )

% need to be vectorized
    for i = 1:size(samples,2)
        for j = 1:size(samples,3)
            for k = 1:size(samples,4)
                a = samples(:,i,j,k);
                m = median(a);
                im(i,j,k) = m;
            end
        end
    end
end