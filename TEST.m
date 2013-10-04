addpath(genpath('.'));
clc
clear
close all


%% General Settings of Environment
control.enable_learning = false;

control.visualize_tracker_result = true;
control.visualize_tracking_history = false;
control.visualize_tracker_dynamics = false;

control.video_tracker_result = false;
control.video_tracking_history = false;
control.video_tracker_dynamics = false;

control.save_tracker_result = false;
control.verbose = true;

control.number_of_objects = 1;
control.initialize_input_method = 'file';  %file,hand,detector

control.train_videos = {'bear_front' , 'child_no1', 'face_occ5', 'zcup_move_1'};
control.test_videos = {'new_ex_occ4'};

%% Tracker Initialization parameters
control.tracker_list = {'lb_crazy', 'lb_crazy', 'lb_crazy', 'lb_crazy'};
params1.name = 'crazy1';
params2.name = 'crazy2';
params3.name = 'crazy3';
params4.name = 'crazy4';
tracker_parameters = [params1, params2, params3, params4];

%% Tracking Scenario
trackers =  trackers_initialize ( control.tracker_list, tracker_parameters , control );
trackers =  trackers_train ( control.train_videos , trackers , control );
results  =  trackers_test ( control.test_videos , trackers , control );
%             trackers_evaluate ( control.test_videos , trackers , control , results );
%             trackers_output ( control.test_videos , trackers , control , results );



% 
% 
% 
% 
% [vid_param, directory, num_frames, cam_param, gt, init_bb]   = video_info(control.video_name);
% 
% for i = 1:num_frames
%     [rgb, depth] =  read_frame(vid_param, directory, i);
%     
%     %show the 2D image
%     subplot(1,2,1); imshow(rgb);
%     rectangle('Position',gt(1:4,i),'EdgeColor','y');
%     subplot(1,2,2); imshow(depth);
%     rectangle('Position',gt(1:4,i),'EdgeColor','r');
%     
%     drawnow
% end
%     
% % 
% % % display in 3D: subsample to avoid too much to display.
% % XYZpoints = XYZpoints(:,1:20:end);
% % RGBpoints = RGBpoints(:,1:20:end);
% % subplot(1,3,3); scatter3(XYZpoints(1,:),XYZpoints(2,:),XYZpoints(3,:),ones(1,size(XYZpoints,2)),double(RGBpoints)'/255,'filled');
% % axis equal; view(0,-90);
% % imtool(depth)
% 
