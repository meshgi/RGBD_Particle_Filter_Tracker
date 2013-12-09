function bb = lb_invisible_test (rgb, depth, init_bb)
%LB_INVISIBLE_TEST Outputs bounding box to be occluded all the time
%   This function serves as a lower bound for tracker, outputing occlusion
%   at all frames of the sequence but gives the correct answer at the first
%   frame (since the target in the first frame is always visible)
%
%   code by: Kourosh Meshgi, Nov 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
    else
        bb = NaN(1,4);
    end
end %======================================================================