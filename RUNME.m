addpath(genpath('.'));
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
control.start_frame = 1;
control.success_plot_thresold_steps = 20;

control.train_videos = {'bear_front' , 'child_no1', 'face_occ5', 'zcup_move_1'};
control.test_videos = {'new_ex_occ4'};

%% Tracker Initialization parameters
% 'particle_filter'
% 'ub_gt'
% 'ub_gt_first_size'
% 'ub_gt_first_ratio'
% 'ub_gt_no_occ_rand'
% 'ub_gt_no_occ_last'
% 'lb_first_bb'
% 'lb_center_bb'
% 'lb_rand_size'
% 'lb_rand_loc'
% 'lb_rand_size_loc'
% 'lb_crazy'   
% 'lb_invisible'

console_messages ('clear');
console_messages ('add' , 'Initializing Trackers');

control.tracker_list = {'loader', 'ub_gt_first_size', 'lb_rand_loc', 'particle_filter'};
params1.name = 'loader';
params1.filename = 'tracker/loader/loader_test.txt';

params2.name = 'alg 2';
params3.name = 'alg 3';

params4.name                    = 'particle filter';
params4.number_of_particles     = 100;
params4.feature_name            = {'medD'}; %HoC (RGB Clustering,Grid2) , HoC (RGB Clustering,Grid3), HoC (HSV),...
params4.similarity_measure      = {'Euclidean'};
params4.variance_from_target    = [ 5];
params4.occlusion_probability   = 0.3;
params4.bkg_detection           = 'temporal median';
params4.bkg_subtraction         = 'thresholding';

tracker_parameters = {params1, params2, params3, params4};

%% Tracking Scenario
console_messages ('newline' , 'Tracking Scenario ... 1');
trackers    =  trackers_initialize ( control.tracker_list, tracker_parameters , control );
console_messages ('add' , '... 2');
trackers    =  trackers_train ( control.train_videos , trackers , control );
results     =  trackers_test ( control.test_videos , trackers , control );
evaluation  =  trackers_evaluate ( control.test_videos , trackers , control , results );
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
