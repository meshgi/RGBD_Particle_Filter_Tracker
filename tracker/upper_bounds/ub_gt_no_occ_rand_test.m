function bb = ub_gt_no_occ_rand_test (depth,grt,frame_number,init_bb)
%UB_GT_NO_OCC_RAND_TEST Outputs the GT box, if exists, and a random box 
%otherwise
%   This function outputs ground truth in each frame, if the object is
%   occluded (GT = NaN) it shows a random bounding box...
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        return
    end
    
    if (isnan(grt(1,frame_number)))
        bb = bb_random (size(depth));
    else
        bb = grt (1:4,frame_number);
    end
end %======================================================================