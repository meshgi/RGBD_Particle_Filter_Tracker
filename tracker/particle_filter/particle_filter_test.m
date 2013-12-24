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
            fld = ['bkg/' video_name];
            if (~exist(fld,'dir'))
                mkdir(fld);
            end
            save([fld '/rgb_bkg.mat'],'rgb_bkg');
            save([fld '/dep_bkg.mat'],'dep_bkg');    
        end
        [rgb_msk, dep_msk] = bkg_subtraction ( self.bkg_sub , rgb_raw, dep_raw, rgb_bkg , dep_bkg);
        
        % create feature space
        self = initialize_features (self, rgb_raw, video_name , init_bb);
        
        % initialize bounding boxes around foreground points
        [boxes , z] = initialize_particles_bb (rgb_raw, self.N, ...
                                               self.box_w_range , self.box_h_range, ...
                                               self.g, ...
                                               self.max_velocity_x, self.max_velocity_x, ...
                                               rgb_msk, init_bb);
        
        % initial model
        model = bb_feature_extraction ( init_bb , self.g, ...
                                        rgb_raw, dep_raw, ...
                                        rgb_msk, dep_msk, ...
                                        self.feature );
                                           
        % first bounding box (bb = target)
        bb = init_bb;
        
        % saving tracker parameters
        self.target     = init_bb;
        self.target_z   = 0;
        self.rgb_bkg    = rgb_bkg;
        self.dep_bkg    = dep_bkg;
        self.bbs        = boxes;
        self.z          = z;
        self.model      = model;
        
    else
        self.frame = self.frame + 1;
        console_messages ('newline',['frame: ' num2str(self.frame)]);

%         3-1- Calculate Features for Bounding Boxes and Target
%         3-2- Measure Particle Features to Target
%         3-3- Calculate Particle Likelihood Based on Feature
%         3-4- Normalize Features Between All Particles
%         3-5- Calculate Particle Likelihood via Log-Sum-Exp
%         3-6- Apply Occlusion Flag
%         3-7- Normalize Particle Likelihood to Make Probability
%         3-8- Update Target
%         3-9- Resampling & Anti-Jitter policy
%         3-10- Update Target Model 
        
        % global data
        [rgb_msk, dep_msk] = bkg_subtraction ( self.bkg_sub , rgb_raw, dep_raw, self.rgb_bkg , self.dep_bkg);
                                    
        % particles characteristics
        for i = 1:self.N
            
            % extract features for no occlusion case
            if (self.z(i) == 0 ) 
                % calculate features
                particle{i} = bb_feature_extraction ( self.bbs(i,:) , self.g, ...
                                                   rgb_raw, dep_raw, ...
                                                   rgb_msk, dep_msk, ...
                                                   self.feature );

                % features distance to template
                particle{i} = bb_feature_distance ( particle{i} , self.model ,self.g ,self.feature );
                
%                 h =figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1]); 
%                 subplot(2,1,1);  hist_vis (particle{i}.cell(1,1).feature(1).val, self.feature{1}.rgb_ctr);
%                 subplot(2,1,2);  hist_vis (self.model.cell(1,1).feature(1).val, self.feature{1}.rgb_ctr);
%                 close (h);
            end

            particle{i}.z = self.z(i);
            particle{i}.bb = self.bbs(i,:);

            % particles likelihood calculation considering occlusion vs. no occlusion case
            if (particle{i}.z == 0 ) % not occluded
                particle{i} = bb_minus_log_likelihood ( particle{i} , self.feature );
            else                     % occluded
                particle{i}.minus_log_likelihood = self.occ_pr;
            end
            likelihood(i) = particle{i}.minus_log_likelihood;
            
            
%             h = vis_particle (i,rgb_raw,dep_raw,rgb_msk,particle{i}.bb,particle{i}.cell(1,1).feature(1).val,particle{i}.cell(1,1).feature(2).val,particle{i}.dist(1),particle{i}.dist(2),likelihood(i),self.feature{1}.rgb_ctr,self.model.cell(1,1).feature(1).val,self.target);
%             close (h);
        end

        % ATTENTION! particles feature channels normalization was a mistake, added
        % normalization factor as a input...
        
        % particle probability calculation
        bb_prob = bb_normalize_minus_log_likelihood (likelihood);
        
        % expected target and its state of visibility
        [proposed_bb, proposed_z] = expected_target ( self.bbs, self.z, bb_prob );
        
        % particle resampling proportional to probability
        [resampled_bbs, resampled_z] = bb_resample ( self.bbs, self.z, bb_prob, ...
                                                     proposed_bb, proposed_z, ...
                                                     rgb_raw, ...
                                                     self.box_w_range , self.box_h_range, ...
                                                     self.max_velocity_x, self.max_velocity_y, ...
                                                     self.g, self.state_transition_matrix );
                                                 
                 
                                                 
        % MESSY CODE, FIX IT!!!!!!!!!!!!!!!!!!!
        
        
        
%         % target model update, only when no occlusion is expected
%         if ( proposed_z < self.occ_thr )
%             proposed_t = bb_feature_extraction ( self.target , self.g, ...
%                                         rgb_raw, dep_raw, ...
%                                         rgb_msk, dep_msk, ...
%                                         self.feature );
%             model = model_update ( self.update , self.model , proposed_t , self);
%         else
%             model = self.model;
%         end

        
        % target model update, only when no occlusion is expected
            
        proposed_t = bb_feature_extraction ( self.target , self.g, ...
                                    rgb_raw, dep_raw, ...
                                    rgb_msk, dep_msk, ...
                                    self.feature );
        model_nocc = model_update ( self.update , self.model , proposed_t , self);
        model_occ = self.model;

        model = self.model;
        model.cell(1,1).feature(2).val = proposed_z*model_occ.cell(1,1).feature(2).val + (1-proposed_z)*model_nocc.cell(1,1).feature(2).val;
        

        
        % MESSY CODE, FIX IT!!!!!!!!!!!!!!!!!!!
        
        
        
        
        
        
        
        
        
        
        
        
        
%         col = bb_prob_color_indicator (bb_prob , self.z); % DEBUG MODE
%         h = figure;        imshow(rgb_raw);        pause(0.05); % DEBUG MODE
%         for i = 1:size(self.bbs,1)
%             rectangle('Position',self.bbs(i,:),'EdgeColor',col(i,:));            pause(0.01);            drawnow; % DEBUG MODE
%         end % DEBUG MODE
%         close (h); % DEBUG MODE
        
        % save data to tracker
        self.target     = proposed_bb;
        self.target_z   = proposed_z;
        self.bbs        = floor(resampled_bbs);
        self.z          = resampled_z;
        self.model      = model;
        
        if (self.z > self.occ_thr )
            bb = NaN(1,4);
        else
            bb = floor(proposed_bb); %% iteration output
        end
    
    end
    
%     % history saving
    if self.frame > 1
        self.history = tracker_history ( self, particle, bb_prob );
    else
        self.history = tracker_history ( self, [], [] );
    end
    
end %======================================================================



% TO DO:
% model update
% motion model adding (constant velocity x(t) = 2 x(t-1) - x(t-2) + noise)
% add griding
% add confidence
% importance factor for depth
% forgetting rate 