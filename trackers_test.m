function results  =  trackers_test ( test_videos , trackers , control )
%TRACKERS_TEST Test trackers wether they can track the given object
%   This function tests the trackers using given video. It provides them
%   the bounding box in first frame either given on file, via an
%   interactive tool, or using object detector as an input. 
%   If the tagging method is 'file', the method automatically read the file
%   'init.txt' in the dataset and extract bounding box from it. In the case
%   of multiple object tracking, the file contains multiple lines. 
%   If the tagging method is 'hand' an interactive image will be opened to
%   input bounding boxes of objects one-by-one. 
%   In the case of 'detector', the algorithm select the object candidates
%   from top of the list provided.
%   the tracking result then returned in a T-4-by-M array, where M is the
%   number of frames of each video and T is the number of trackers. In the 
%   case of multiple videos, the result will be N-by-T-by-4-by-M array,
%   where N is the number of videos.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    results = [];

    for vid = 1:size(test_videos,2)
        [vid_param, directory, num_frames, cam_param, grt, init_bb]   = video_info(test_videos{1,vid});

        % if initialization method is not 'file' then initialize it!!!!

        for fr = control.start_frame:num_frames
            [rgb, depth] =  read_frame(vid_param, directory, fr);

            for tr = 1:length(trackers)
                % give tracker input data, without ground truth and save the
                % results
                initial_target_bb = [];
                if (fr == 1)
                    initial_target_bb = init_bb;
                end

                trackers{1,tr}.status = 'test';
                switch trackers{1,tr}.type
                    case 'particle_filter'
                        [res,trackers{1,tr}] = particle_filter_test ( rgb, depth, initial_target_bb, trackers{1,tr}, test_videos{1,vid});
                    case 'rgbd_pf_grid_occ'
                        disp '4'
                        % e.g. the object to track in the multiple object cases
                    case 'loader'
                        res = loader_test (trackers{1,tr}, fr);
                    case 'ub_gt'
                        res = ub_gt_test (grt,fr,initial_target_bb);
                    case 'ub_gt_first_size'
                        [res,trackers{1,tr}] = ub_gt_first_size_test (grt,fr,initial_target_bb, trackers{1,tr});
                    case 'ub_gt_best_size'
                        disp '6'
                    case 'ub_gt_first_ratio'
                        [res,trackers{1,tr}] = ub_gt_first_ratio_test (depth,grt,fr,initial_target_bb, trackers{1,tr});
                    case 'ub_gt_best_ratio'
                        disp '8'
                    case 'ub_gt_no_occ_rand'
                        res = ub_gt_no_occ_rand_test (depth,grt,fr,initial_target_bb);
                    case 'ub_gt_no_occ_last'
                        res = ub_gt_no_occ_last_test (grt,fr,initial_target_bb);
                    case 'lb_first_bb'
                        [res,trackers{1,tr}] = lb_first_bb_test ( rgb, depth, initial_target_bb, grt, trackers{1,tr} );
                    case 'lb_center_bb'
                        [res,trackers{1,tr}] = lb_center_bb_test ( rgb, depth, initial_target_bb, grt, trackers{1,tr} );
                    case 'lb_rand_size'
                        [res,trackers{1,tr}] = lb_rand_size_test ( rgb, depth, initial_target_bb, grt, trackers{1,tr} );
                    case 'lb_rand_loc'
                        [res,trackers{1,tr}] = lb_rand_loc_test ( rgb, depth, initial_target_bb, grt, trackers{1,tr} );
                    case 'lb_rand_size_loc'
                        [res,trackers{1,tr}] = lb_rand_size_loc_test (rgb, depth, initial_target_bb, grt, trackers{1,tr});
                    case 'lb_crazy'   
                        res = lb_crazy_test (rgb, depth, initial_target_bb);
                    case 'lb_invisible'
                        res = lb_invisible_test (rgb, depth, initial_target_bb);
                end
                tracker_output(tr,1:4,fr) = res(:);
            end
            tracker_output(1:4,1:4,fr) %%%%%%%%%% PRINT OUT
            
            imshow(depth);
            if ~isnan(tracker_output(1,1:4,fr)), rectangle('Position',tracker_output(1,1:4,fr),'EdgeColor','r'); end
            if ~isnan(tracker_output(2,1:4,fr)), rectangle('Position',tracker_output(2,1:4,fr),'EdgeColor','g'); end;
            if ~isnan(tracker_output(3,1:4,fr)), rectangle('Position',tracker_output(3,1:4,fr),'EdgeColor','b'); end;
            if ~isnan(tracker_output(4,1:4,fr)), rectangle('Position',tracker_output(4,1:4,fr),'EdgeColor','y'); end;
            pause(0.1)
            drawnow;
        end
    video_tracking_footage(vid,:,:,:) = tracker_output;
    
    
    end
    
results = video_tracking_footage;
end %======================================================================


% * Testing
% *** For Each Video Do
% ****** Read Video General Info
% ****** Initialize Trackers for Testing Mode
% ****** For Each Frame of Video Do
% ********* For Each Tracker Do
% ************ Provide Tracker with Input Data
% ************ Save the Result of Tracking
% *** Returning The Result for Each Video