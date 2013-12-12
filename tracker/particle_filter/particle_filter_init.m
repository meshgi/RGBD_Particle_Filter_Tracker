function x = particle_filter_init (params)

x.name  = params.name;
x.type = 'particle_filter';

%% Manual Parameter Handling
x.N         = params.number_of_particles;
x.fn        = params.feature_name;
x.sm        = params.similarity_measure;
x.imp       = params.feature_importance;
x.nrm       = params.feature_normalizer;
x.occ_pr    = params.occlusion_probability;
x.target    = NaN(1,4);
x.bkg_det   = params.bkg_detection;
x.bkg_sub   = params.bkg_subtraction;
x.update    = params.model_update;

if ( isfield(params,'grid_size') ) x.g = params.grid_size; else x.g = 1; end

%% Default Parameters
% background subtraction
x.bkg_det_samples               = 30;                                       % frames sampled for background subtraction 
x.bkg_det_load                  = true;

% HoC RGB Clustering
x.rgb_clustering_samples        = 3000;
x.rgb_bins = 40;                                                            % number of bins in RGB
x.rgb_bins_load = 1;

% particle dynamics
x.box_w_range                   = [50, 150];
x.box_h_range                   = [200, 400];

x.max_velocity_x                = 40;
x.max_velocity_y                = 40;

% occlusion flag
if (params.enable_occ_flag)
    x.state_transition_matrix   = [0.95 0.05; 0.25 0.75];                   % nocc->nocc = 0.99, nocc->occ = 0.01, occ->nocc = 0.25, occ->occ = 0.75
else
    x.state_transition_matrix   = [1 0; 1 0];                               % disables occlusion flag by letting no particle to go to occlusion state
end

% model update
x.target_update_forgetting_rate = 0.1;                                      % 1: completely explore (forget old ones), 0: completely exploit
