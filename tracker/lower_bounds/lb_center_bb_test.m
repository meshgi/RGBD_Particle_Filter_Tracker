function [bb, self] = lb_center_bb_test (rgb, depth, init_bb , grt, self)
%LB_CENTER_BB_TEST Always outputs the box locate at center of image, with first
% frame box size
%   This function serves as a lower bound for tracker. 
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        
        [m,n] = size(depth);
        w = init_bb(3);
        h = init_bb(4);
        
        self.bb = [(n-w)/2,(m-h)/2,w,h];
    else
        bb = self.bb;
    end
end %======================================================================