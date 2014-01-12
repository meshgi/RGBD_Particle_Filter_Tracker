addpath(genpath('.'));
clear
close all


%% General Settings of Environment
control.enable_learning = true;

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

control.train_videos = {'new_ex_occ4'};%{ 'bear_front', 'face_occ5', 'zcup_move_1', 'child_no1'};
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

control.tracker_list = {'lb_rand_size', 'ub_gt_first_size', 'lb_rand_loc', 'particle_filter'};
params1.name = 'lb_rand_size';
% params1.name = 'loader';
% params1.filename = 'tracker/loader/loader_test.txt';

params2.name = 'ub_gt_first_size';
params3.name = 'lb_rand_loc';

params4.name                    = 'particle filter';
params4.number_of_particles     = 100;


params4.feature_name            = {'HoC(RGB Clustering,Gridding with Confidence)', 'medD'}; %HoC (RGB Clustering,Grid2) , HoC (RGB Clustering,Grid3), HoC (HSV),...
params4.similarity_measure      = {'Bhattacharyya(Gridding with Confidence)'     , 'L1' };
params4.feature_importance      = [ 1                                            , 1];
params4.feature_normalizer      = [ 1                                            , 1];


params4.occlusion_probability   = 0.5;
params4.occlusion_flag_threshold = 0.3;
params4.state_transition_matrix = [0.1 0.9; 0.4 0.6]; % nocc->nocc = 0.99, nocc->occ = 0.01, occ->nocc = 0.25, occ->occ = 0.75
params4.bkg_detection           = 'temporal median';
params4.bkg_subtraction         = 'thresholding';
params4.model_update            = 'moving_average';
params4.enable_occ_flag         = true;
params4.grid_size               = 2;

tracker_parameters = {params1, params2, params3, params4};

%% Tracking Scenario
% console_messages ('newline' , 'Tracking Scenario ... 1');
trackers                =  trackers_initialize ( control.tracker_list, tracker_parameters , control );
trackers                =  trackers_train ( control.train_videos , trackers , control );
[results,trackers]      =  trackers_test ( control.test_videos , trackers , control );
evaluation              =  trackers_evaluate ( control.test_videos , trackers , control , results );
                           trackers_output ( control.test_videos , trackers , control , results );


