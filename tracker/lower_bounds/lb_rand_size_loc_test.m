function [bb, self] = lb_rand_size_loc_test (rgb, depth, init_bb , grt, self)
%LB_RAND_SIZE_LOC_TEST Outputs bounding boxes with random location and size
%based on dataset statistics
%   This function serves as a lower bound for tracker, providing complete
%   box position and size, but with prior knowledge about data set
%   statistics. It uses the mean and variance for the bounding box location
%   and size and sample new bounding box from a Normal distribution based
%   on them
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
        x = self.gt_bb_mean(1) + randn(1) * self.gt_bb_std(1);
        y = self.gt_bb_mean(2) + randn(1) * self.gt_bb_std(2);
        x = clip_range(x,[30, n-30]);
        y = clip_range(y,[30, m-30]);
        
        % size
        w = self.gt_bb_mean(3) + randn(1) * self.gt_bb_std(3);
        h = self.gt_bb_mean(4) + randn(1) * self.gt_bb_std(4);
        w = clip_range(w,[29,n-x]);
        h = clip_range(h,[29,m-y]);
        
        bb = floor([x,y,w,h]);
    end
end %======================================================================