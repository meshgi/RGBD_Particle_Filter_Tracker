function [bb,self] = ub_gt_first_ratio_test (depth,grt,frame_number,init_bb,self)
%UB_GT_FIRST_RATIO_TEST Uses the GT location and first frame box ratio
%   This function outputs ground truth location in each frame, if the 
%   object is occluded it returns NaN... Also the size of bounding box has
%   the same aspect ratio of the first frame
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        self.ratio = double(bb(4)) / double(bb(3));
        return
    end
    
    if (isnan(grt(1,frame_number)))
        bb = NaN(1,4);
    else
        x = grt (1,frame_number);
        y = grt (2,frame_number);
        [H,W] = size(depth);
        
        w = randi([1,W-x]);
        h = floor(self.ratio * w);
        
        if (h > H )
            h = H;
            w = floor(h/self.ratio);
        end
        
        bb = [x,y,w,h];
        
    end
    
end %======================================================================