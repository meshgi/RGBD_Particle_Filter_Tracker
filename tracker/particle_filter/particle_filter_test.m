function [bb, self] = particle_filter_test (rgb_raw, dep_raw, init_bb , self, video_name)
%PARTICLE_FILTER_TEST Uses a particle filter to track the given objects
%using selected features
%   ---------------description
%
%   code by: Kourosh Meshgi, Dec 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if ( ~isempty(init_bb))
        self.frame = 1;
        
        % 1-1- Initialize Parameters
        % 1-2- Initialize Particles
        % 1-3- Initialize Target Model
        % 1-4- Save Tracker parameters
        
        
        % background detection
        if ( self.bkg_det_load )
            load (['bkg/' video_name '/rgb_bkg.mat']);
            load (['bkg/' video_name '/dep_bkg.mat']);
        else
            [rgb_bkg,dep_bkg] = offline_bkg_detection ( self.bkg_det, video_name , self.bkg_det_samples );
            save(['bkg/' video_name '/rgb_bkg.mat'],'rgb_bkg');
            save(['bkg/' video_name '/dep_bkg.mat'],'dep_bkg');    
        end
        [rgb_msk, dep_msk] = bkg_subtraction ( self.bkg_sub , rgb_raw, dep_raw, rgb_bkg , dep_bkg);
        
        % color centers
        if ( self.rgb_bins_load )
            load (['bkg/' video_name '/rgb_ctr.mat']);
        else
            rgb_ctr = color_clustering (rgb_raw , self.rgb_clustering_samples, self.rgb_bins);
            save(['bkg/' video_name '/rgb_ctr.mat'],'rgb_ctr');
        end
        
        % confidence measure
        rgb_cnf = 1; % to be loaded, or trained
        
        % initialize bounding boxes around foreground points
        [boxes , z] = initialize_particles_bb (rgb_raw, self.N, ...
                                               self.box_w_range , self.box_h_range, ...
                                               self.g, ...
                                               self.max_velocity_x, self.max_velocity_x, ...
                                               rgb_msk);
        
        % first bounding box (bb = target)
        bb = init_bb;
        
        % saving tracker parameters
        self.target     = init_bb;    
        self.rgb_bkg    = rgb_bkg;
        self.dep_bkg    = dep_bkg;
        self.rgb_ctr    = rgb_ctr;
        self.rgb_cnf    = rgb_cnf;
        self.boxes      = boxes;
        self.z          = z;
        
    else
        self.frame = self.frame + 1;

%         3-1- Calculate Features for Bounding Boxes and Target
%         3-2- Measure Particle Features to Target
%         3-3- Calculate Particle Likelihood Based on Feature
%         3-4- Normalize Features Between All Particles
%         3-5- Calculate Particle Likelihood via Log-Sum-Exp
%         3-6- Normalize Particle Likelihood to Make Probability
%         3-7- Apply Occlusion Flag
%         3-8- Update Target, Target Model Model & Anti-Jitter policy
%         3-9- Resampling
        
        % global data
        [m,n] = size(dep_raw);
        [rgb_msk, dep_msk] = bkg_subtraction ( self.bkg_sub , rgb_raw, dep_raw, self.rgb_bkg , self.dep_bkg);
        
        % target statistics
        t = bb_feature_extraction ( self.target , self.g, ...
                                    rgb_raw, dep_raw, ...
                                    rgb_msk, dep_msk, ...
                                    self.rgb_ctr, self.rgb_cnf );
                                    
        % particles characteristics
        for i = 1:self.N
            
            % calculate features
            p = bb_feature_extraction ( self.boxes(i,:) , self.g, ...
                                        rgb_raw, dep_raw, ...
                                        rgb_msk, dep_msk, ...
                                        self.rgb_ctr, self.rgb_cnf );
  
            
            
            
            
            
        end
                
        
        bb = NaN(1,4); %% Dummy
    end
end %======================================================================