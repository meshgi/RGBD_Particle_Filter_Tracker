function particle_filter_demo (gt, self , vid_param, cam_param, directory, num_frames, start)

% frame rate = 20;
% 
% 0.5 title
% 1 loop 3d point cloud
% 0.5 sec pause
% 0.5 title 
% 1 loop tracking rgb
% 0.5 sec pause
% 1 loop stabilized image
% 0.5 sec pause
% 1 loop tracking dep
% 0.5 sec pause
% 1 loop stabilized depth image
% 0.5 sec pause
% 0.5 title
% 1 loop trackig bkg sutracted
% 0.5 sec pause
% 0.5 title
% 1 loop tracker rgb + tracker trajectory
% 0.5 sec pause
% 1 loop tracker rgb + tracker trajectory + cpe vs time
% 0.5 sec pause
% 1 loop cpe vs time
% 0.5 sec pause
% 0.5 title
% 1 loop tracking rgb + tracker error
% 0.5 sec pause
% 1 loop tracking rgb + tracker error + cpe vs time
% 0.5 sec pause
% 0.5 title
% 1 loop tracking rgb + size vs time
% 0.5 sec pause
% 
% finally: visualize success plot



fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Occlusion Aware Particle Framework');
error_type = zeros (1,4);

writerObj = VideoWriter('output/v1.avi');
writerObj.FrameRate = 20;
open(writerObj);



for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    % =====================================================================
    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    % =====================================================================
    
%     title('Final Tracking Results: Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
%     vis_final_tracker_track (rgb_raw, bb, bb_gt );
        
    
    % =====================================================================
% 	  title('Final Tracking Results (Depth Map): Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
%     vis_final_tracker_track (dep_raw, bb, bb_gt );
    
    % =====================================================================

% 	title('Video Sequence 3D View (2.5 D)','Color','w');
% 	vis_point_cloud (rgb_raw, dep_raw, cam_param, [0,-90] );
    
    % =====================================================================
%   	title('Tracker Error Types','Color','w');
%     set(gca, 'XColor', 'w', 'YColor', 'w');
% 	vis_error_types (bb, bb_gt, 0.5 );
%     
    % =====================================================================

%     title('Final Tracking Trajectory: Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
% 	vis_final_tracker_trajectory (rgb_raw, gt , self,  fr );
%      
%     
    % =====================================================================
    
%     title('Final Tracking Central Point Error','Color','w');
%     set(gca, 'YColor', 'w');
% 	vis_final_tracker_cpe (num_frames, self, gt, fr );
    
    % =====================================================================
%     title('Final Tracking Size Adaptation: Width(blue), Height(red), Ground Truth(dashed), Szie Adaptation Error(black)','Color','w');
%     set(gca, 'YColor', 'w');
% 	vis_final_tracker_sae (rgb_raw, num_frames, self, gt, fr );
        
    % =====================================================================
%     title('Particle Dynamics - Box Position and Probability Indicator: Red(occlusion chance), Brighter (more probable). Darker(less probable)','Color','w');
% 	
%     vis_particle_position_probability (rgb_raw, self, fr , 1);
%     for i = 2:self.N
%         vis_particle_position_probability ([], self, fr , i);
%         pause(0.01); hold on;
%     end
%     

    % =====================================================================

%     title('Particle Dynamics - Occluded Particles','Color','w');
%     
%     vis_particle_position_occlusion (rgb_raw, self, fr , 1);
%     for i = 2:self.N
%         vis_particle_position_occlusion ([], self, fr , i);
%         pause(0.01); hold on;
%     end
    
    % =====================================================================
    
%     title('Particle Dynamics - HOC Distances: Particle Distances (red), Average Distances (blue), Weighted Distances (black)','Color','w');
%     vis_particle_hoc_distances ( self, num_frames, fr);
%     
    % =====================================================================
    
%     title('Particle Dynamics - Median of Depth Distances: Particle Distances (red), Average Distances (blue), Weighted Distances (black)','Color','w');
%     vis_particle_medd_distances ( self, num_frames, fr);

    % =====================================================================

%     title('Particle Dynamics - Particle Probabilities (occluded ones  are in red)','Color','w');   
%     vis_particle_probability ( self, fr );
         
    % =====================================================================
    
%     title('Particle Dynamics - Particle Probabilities Compared (occluded ones are exploded)','Color','w');   
%     vis_particle_probability_comparison (self , fr , 1);
%     hold on;
%     
% 	for i = 1:self.N
%         vis_particle_probability_comparison (self , fr , i);
%     end
%     hold off;
% 
% %     if ( fr == 1 )
% %         continue;
% %     end
% %     
% %     probs = self.history.probs(fr,:);
% %     explode = self.history.z(fr,:);
% %     for i = 1:self.N
% %         pie(probs(1:i),explode(1:i));
% %         drawnow; pause (0.1);
% %     end
% % 

    % =====================================================================
%     
%     title('Stabilized Image','Color','w');   
%     subplot (1,2,1);  imshow (bb_content(rgb_raw,bb));
%     % % fix it later
% %     cpx = bb(1) + bb(3)/2;
% %     cpy = bb(2) + bb(4)/2;
% %     subplot (1,2,2);  imshow (bb_content_safe(rgb_raw,[cpx-150,cpy-150,300,300]));
    
	% =====================================================================

%     title('Particle Dynamics - Particle HOC vs. Template HOC and the Difference','Color','w');   
%     vis_particle_template_hoc_comparison (rgb_raw, self , fr , 1);
%     hold on;
%     for i = 1:self.N
%         vis_particle_template_hoc_comparison (rgb_raw, self , fr , 1);
%         pause(0.1); drawnow;
%     end
%     hold off;
%         
% %     
% %     ctrs = self.feature{1}.rgb_ctr;
% %     bbs = squeeze(floor(self.history.bbs(fr,:,:)));
% % 
% %     hoc1 = self.history.model_rgb_hist(fr,:);
% %     subplot (3,1,1); hoc_vis (hoc1,ctrs);
% %     
% %     for i = 1:self.N
% %         hoc2 = histogram_of_colors(bb_content(rgb_raw,bbs(i,:)),[],ctrs);
% %         subplot (3,1,2); hoc_vis (hoc2,ctrs);
% %         subplot (3,1,3); bar (abs(hoc1-hoc2)); xlim([0 length(hoc1)]); ylim([0 0.2]); drawnow;
% %         drawnow;
% %         pause (0.1);
% %     end

    % =====================================================================

%     title('Particle Dynamics - Particle MedD vs. Template MedD','Color','w');   
%     set(gca, 'XColor', 'w');
%     vis_particle_template_medd_comparison ( self, dep_raw , fr , bb);
%     
 % =====================================================================
 % CONFIDENCE MAP
 % TEMPLATE EVOLUTION (OLD TEMPLATE, NEW ENTRY, NEW TEMPLATE)

end


%     frame = getframe; % VID
%     writeVideo(writerObj,frame); % VID


% close(writerObj); % VID



function insert_title (str)
annotation('textbox',...
    [0 0 1 1],'String',str,'LineWidth',2,'BackgroundColor',[0 0 0],...
    'FontSize',100,'FontName','Arial','Color',[1 1 1]);

