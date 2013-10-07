function [bb, self] = lb_rand_loc_test (rgb, depth, init_bb , grt, self)
%LB_RAND_LOC_TEST Outputs bounding boxes with the first frame box size and
%a random location based on dataset statistics
%   This function serves as a lower bound for tracker. It uses the mean and
%   variance for the bounding box location and sample new bounding box from
%   a Normal distribution based on them, the size is the same as the ground
%   truth
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

        % size
        w = grt(3,1);
        h = grt(4,1);
        
        % location
        x = self.gt_bb_mean(1) + randn(1) * self.gt_bb_std(1);
        y = self.gt_bb_mean(2) + randn(1) * self.gt_bb_std(2);
        x = clip_range(x,[w/2+1, n-w/2-1]);
        y = clip_range(y,[h/2+1, m-h/2-1]);
        
        bb = floor([x,y,w,h]);
    end
end %======================================================================