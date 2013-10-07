function [trackers] =  trackers_initialize ( tracker_list, tracker_parameters , control )
%TRACKER_INITIALIZE Initialize Trackers of given types with given
%parameters
%   This function initialize multiple trackers to work on the same training
%   and test set. Types of trackers are included in tracker_list which could
%   contain multiple instances of the same tracker. The parameters of each
%   tracker are passed via dedicated parameters. Control argument contains
%   general information about tracking environment.
%   types of use:
%   1- a tracker with its lower bound and upper bound heuristics
%   2- multiple instances of the same tracker with different parameter
%   setting
%   3- multiple instances of the same base tracker with features added to
%   different versions of them (e.g. comparison of SIFT with HOG feature,
%   wether to have Occlusion Flag or not, etc)
%   4- different tracking algorithms for the sake of comparison
%   5- multiple trackers track different objects in the same video
%   use your imagination!
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    trackers = {};
    for tr = 1:size(tracker_list,2)
        x = [];
        x.status = 'init';
        switch tracker_list{1,tr}
            case 'rgb_pf'
                disp '1'
            case 'rgbd_pf'
                disp '2'
            case 'rgbd_pf_grid'
                disp '3'
            case 'rgbd_pf_grid_occ'
                disp '4'
                % e.g. the object to track in the multiple object cases
            case 'ub_gt'
                x = ub_gt_init (tracker_parameters(tr));
            case 'ub_gt_first_size'
                disp '5'
            case 'ub_gt_best_size'
                disp '6'
            case 'ub_gt_first_ratio'
                disp '7'
            case 'ub_gt_best_ratio'
                disp '8'
            case 'ub_gt_no_occ'
                disp '9'
            case 'lb_first_bb'
                disp '10'
            case 'lb_center_bb'
                x = lb_center_bb_init (tracker_parameters(tr));
            case 'lb_rand_size'
                x = lb_rand_size_init (tracker_parameters(tr));
            case 'lb_rand_loc'
                x = lb_rand_loc_init (tracker_parameters(tr));
            case 'lb_rand_size_loc'
                x = lb_rand_size_loc_init (tracker_parameters(tr));
            case 'lb_crazy'
                x = lb_crazy_init (tracker_parameters(tr));
        end
        trackers{tr} = x;
        disp (x.name);
    end

end %======================================================================

