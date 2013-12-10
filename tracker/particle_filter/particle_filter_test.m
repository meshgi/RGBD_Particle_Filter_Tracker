function [bb, self] = particle_filter_test (rgb_raw, dep_raw, init_bb , self, video_name)
%PARTICLE_FILTER_TEST Uses a particle filter to track the given objects
%using selected features
%   ---------------description
%
%
%
%   SELF = tracker
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
        
        % create feature space
        self = initialize_features (self, video_name);
        
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
        self.bbs        = boxes;
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
                                    self.feature );
                                    
        % particles characteristics
        for i = 1:self.N
            particle.z = self.z(i);
            
            if ( particle.z == 0 ) % not occluded
                % calculate features
                particle = bb_feature_extraction ( self.bbs(i,:) , self.g, ...
                                            rgb_raw, dep_raw, ...
                                            rgb_msk, dep_msk, ...
                                            self.feature );

                particle = bb_feature_distance ( particle , t, self.g, self.feature );

                particle = bb_minus_log_likelihood ( particle , self.feature );
            else             % occluded
                particle.minus_log_likelihood = self.occ_pr;
            end
            
            likelihood(i) = particle.minus_log_likelihood;
        end
        
        bb_prob = bb_normalize_minus_log_likelihood (likelihood);
            
        
        bb = NaN(1,4); %% Dummy
    end
end %======================================================================