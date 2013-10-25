function [bb, self] = particle_filter_test (rgb, depth, init_bb , self)
%PARTICLE_FILTER_TEST Uses a particle filter to track the given objects
%using selected features
%   ---------------description
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        bb = init_bb;
        self.lest = init_bb;
        
        img = bb_content (rgb, bb);
        dep = bb_content (depth, bb);
%         1-1- Initialize First Bounding Box
%         1-2- Initialize Parameters
%         1-3- Initialize Particles
%         1-4- Initialize Target Model (Calculate Features Based on RGB + Depth + Init BB)
    else
        [m,n] = size(depth);
%         3-1- Calculate Features 
%         3-2- Measure Particle Features to Target
%         3-3- Calculate Particle Likelihood Based on Feature
%         3-4- Normalize Features Between All Particles
%         3-5- Calculate Particle Likelihood via Log-Sum-Exp
%         3-6- Normalize Particle Likelihood to Make Probability
%         3-7- Apply Occlusion Flag
%         3-8- Update Target Model
%         3-9- Resampling
        
        
        bb = NaN(1,4); %% Dummy
    end
end %======================================================================