function eval  =  trackers_evaluate ( test_videos , trackers , control , results ) 
%TRACKERS_EVALUATE Evaluate tracker to extract metrics to compare with
%other algorithms
%   This function 
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    ground_truth = {};
    initial_bb = {};
    
    for vid = 1:size(test_videos,2)
        [~, ~, num_frames, ~, gt, init_bb]   = video_info(test_videos{1,vid});
        number_of_frames (vid) = num_frames;
        ground_truth{1,vid} = gt;
        initial_bb{1,vid} = init_bb;
        ground_truth{1,vid}(1:4,1) = init_bb'; % crazy error in data set that ground_truth of frame one is different from initial boundinx box passed to the trackers, here we adjust it
    end



    % the tracking result then returned in a T-4-by-M array, where M is the
    %   number of frames of each video and T is the number of trackers. In the 
    %   case of multiple videos, the result will be N-by-T-by-4-by-M array,
    %   where N is the number of videos.
    
    cpe = evaluate_center_position_error (test_videos , trackers , control , results , ground_truth);
    
    [ auc_list, success_plots ] = evaluate_success_plot_OPE (test_videos , trackers , control , results , ground_truth);
    
    sa = evaluate_scale_adaptation (test_videos , trackers , control , results , ground_truth);
    
%     cpe = [0,0,0,0]; % DEBUG
%     sa = [0,0,0,0]; % DEBUG
    eval = [cpe; sa; auc_list];
    
%     disp(auc_list);
%     disp(sa);
    
end
