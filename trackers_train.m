function trackers =  trackers_train ( train_videos , trackers , control )
%TRACKER_TRAIN Train tracker parameters with annotated dataset
%   This function let all of the trackers to tune up their parameters with
%   the given videos and annotated tracking box.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if (~ control.enable_learning)
        return;


end %======================================================================