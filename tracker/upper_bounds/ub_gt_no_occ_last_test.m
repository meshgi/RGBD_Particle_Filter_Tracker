function bb = ub_gt_no_occ_last_test (grt,frame_number,init_bb)
%UB_GT_NO_OCC_LAST_TEST Outputs ground truth as an upper bound, if it's not
%available inputs the last known bounding box for that
%   This function outputs ground truth in each frame, if the object is
%   occluded (GT = NaN) it shows the last known position of the object...
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        return
    end
    
    while (isnan(grt(1,frame_number)))
        frame_number = frame_number - 1;
    end

    bb = grt (1:4,frame_number);
end %======================================================================