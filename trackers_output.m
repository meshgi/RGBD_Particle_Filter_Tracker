function trackers_output ( test_videos , trackers , control , results ) 
%TRACKERS_OUTPUT Outputs the dynamics of each tracker and resulting track
%   This function 
%
%   code by: Kourosh Meshgi, Dec 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    ground_truth = {};
    
    for vid = 1:size(test_videos,2)
        [vid_param, directory, num_frames, cam_param, grt, init_bb]   = video_info(test_videos{vid});
        number_of_frames (vid) = num_frames;
        ground_truth{vid} = grt;
        ground_truth{vid}(1:4,1) = init_bb'; % crazy error in data set that ground_truth of frame one is different from initial boundinx box passed to the trackers, here we adjust it
     
    end
    
    particle_filter_output (ground_truth{1}, trackers{4} , vid_param, cam_param , directory, num_frames, control.start_frame);
    