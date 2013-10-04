function [vid_param, directory, num_frames, cam_param, ground_truth, init_bb] = video_info (dataset_name)
%VIDEO_INFO Grabs essential information about video dataset
%   This function reads the folder corrensponds to the dataset, and extract
%   essential informations from it such as camera parameters, The path to
%   dataset, the length of the video and returns it.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    directory = [ './data/' dataset_name '/'];
    load([directory 'frames']);
    
    vid_param = frames;
    cam_param = frames.K;
    num_frames = frames.length;
    
    if exist([directory dataset_name '.txt'],'file') == 2
        fid = fopen([directory dataset_name '.txt']);
        ground_truth = fscanf(fid, '%g,%g,%g,%g,%g', [5,inf]);
        fclose(fid);
    else
        ground_truth = [];
    end
       
    if exist([directory 'init.txt'],'file') == 2
        fid = fopen([directory 'init.txt']);
        init_bb = fscanf(fid, '%g,%g,%g,%g', [4,inf]);
        fclose(fid);
    else
        init_bb = [];
    end
    
end %======================================================================