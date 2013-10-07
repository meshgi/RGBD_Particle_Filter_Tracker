function bb = lb_crazy_test (rgb, depth, init_bb)
%LB_CRAZY_TEST Outputs bounding boxes with random location and size without
%any prior knowledge of dataset
%   This function serves as a lower bound for tracker, providing complete
%   random box position and size. Only at the first frame, it returns the
%   given bounding box.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
    else
        [m,n] = size(depth);

        x = randi(n-30,1);
        y = randi(m-30,1);
        w = randi([x,n],1) - x + 29;
        h = randi([y,m],1) - y + 29;

        bb = [x,y,w,h];
    end
end %======================================================================