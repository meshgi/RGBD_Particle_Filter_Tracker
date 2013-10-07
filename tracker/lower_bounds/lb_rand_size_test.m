function [bb, self] = lb_rand_size_test (rgb, depth, init_bb , grt, self)
%LB_RAND_SIZE_TEST OuOutputs bounding boxes with the first frame box location
%and a random size based on dataset statistics
%   This function serves as a lower bound for tracker. It uses the mean and
%   variance for the bounding box size and sample new bounding box from a 
%   Normal distribution based on them with the first location object was
%   found
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        [~,gt_valid] = find(~isnan(grt(1,:)));
        gt_trimmed = grt(1:4,gt_valid);
        
        self.gt_bb_mean = mean(gt_trimmed');
        self.gt_bb_std = std(gt_trimmed');
    else
        [m,n] = size(depth);

        % location
        x = grt(1,1);
        y = grt(2,1);
        
        % size
        w = self.gt_bb_mean(3) + randn(1) * self.gt_bb_std(3);
        h = self.gt_bb_mean(4) + randn(1) * self.gt_bb_std(4);
        w = clip_range(w,[30,min((n-x)*2,(x-1)*2)]);
        h = clip_range(h,[30,min((m-y)*2,(y-1)*2)]);
        
        bb = floor([x,y,w,h]);
    end
end %======================================================================