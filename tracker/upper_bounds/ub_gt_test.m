function bb = ub_gt_test (grt,frame_number,init_bb)
%UB_GT_TEST Outputs ground truth as an upper bound
%   This function outputs ground truth in each frame, if the object is
%   occluded (GT = NaN) it outputs NaN
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        return
    end
    
    bb = grt (1:4,frame_number);
end %======================================================================