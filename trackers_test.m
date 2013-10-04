function results  =  trackers_test ( test_videos , trackers , control )
%TRACKER_TEST Test trackers wether they can track the given object
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
    [vid_param, directory, num_frames, cam_param, gt, init_bb]   = video_info(test_videos{1,vid});
    
    % if initialization method is not 'file' then initialize it!!!!
    
    for fr = 1:num_frames
        [rgb, depth] =  read_frame(vid_param, directory, fr);
        
        for tr = 1:length(trackers)
            % give tracker input data, without ground truth and save the
            % results
            
        
        end
    end
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