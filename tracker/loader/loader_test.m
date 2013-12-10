function bb = loader_test (x, fr)
%LOADER_TEST O...
%   This function outputs ...
%
%   code by: Kourosh Meshgi, Dec 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker
    
    bb = x.bb_list (1:4,fr);
end %======================================================================