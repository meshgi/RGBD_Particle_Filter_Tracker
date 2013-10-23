function [bb, self] = lb_first_bb_test (rgb, depth, init_bb , grt, self)
%LB_FIRST_BB_TEST Always outputs the first frame bounding box for all
%frames
%   This function serves as a lower bound for tracker. 
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        self.bb = bb;
    else
        bb = self.bb;
    end
end %======================================================================