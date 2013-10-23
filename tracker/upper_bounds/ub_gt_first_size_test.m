function [bb,self] = ub_gt_first_size_test (grt,frame_number,init_bb,self)
%UB_GT_FIRST_SIZE_TEST Uses the GT location and first frame box size
%   This function outputs ground truth location in each frame, if the 
%   object is occluded it returns NaN... Also the size of bounding box is 
%   fixed to the first frame bounding box.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        self.bb(3:4) = bb(3:4);
        return
    end
    
    if (isnan(grt(1,frame_number)))
        bb = [NaN,NaN,NaN,NaN];
    else
        bb(3:4) = self.bb(3:4);
        bb(1:2) = grt (1:2,frame_number);
    end
    
end %======================================================================