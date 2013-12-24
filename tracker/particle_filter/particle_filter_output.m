function particle_filter_output (gt, self , vid_param, cam_param, directory, num_frames, start)

fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Occlusion Aware Particle Framework');
colormap('jet');
% writerObj = VideoWriter('output/v1.avi'); % VID
% writerObj.FrameRate = 10; % VID
% open(writerObj); % VID
pause;

title('Final Tracking Results: Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';

    vis_final_tracker_track (rgb_raw, bb, bb_gt );
    drawnow;
    
end

pause; clf;
    % =====================================================================
title('Final Tracking Results (Depth Map): Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    vis_final_tracker_track (dep_raw, bb, bb_gt );
    drawnow;
end
pause; clf;
    % =====================================================================

% 	title('Video Sequence 3D View (2.5 D)','Color','w');
% 	vis_point_cloud (rgb_raw, dep_raw, cam_param, [0,-90] );
    
    % =====================================================================
title('Tracker Error Types','Color','w');
set(gca, 'XColor', 'w', 'YColor', 'w');
error_type = zeros (1,4);
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
	error_type = vis_error_types (bb, bb_gt, 0.5 , error_type , num_frames);
    set(gca, 'XColor', 'w', 'YColor', 'w');
end
pause; clf;
    % =====================================================================
title('Final Tracking Trajectory: Ground Truth (green) vs Tracker Output (Yellow)','Color','w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
	vis_final_tracker_trajectory (rgb_raw, gt , self,  fr );
    drawnow;
end
pause; clf;
    % =====================================================================
title('Final Tracking Central Point Error','Color','w');
set(gca, 'YColor', 'w');

for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
	vis_final_tracker_cpe (num_frames, self, gt, fr );
    drawnow;
end
pause; clf;
    % =====================================================================
title('Final Tracking Size Adaptation: Width(blue), Height(red), Ground Truth(dashed), Szie Adaptation Error(black)','Color','w');
set(gca, 'YColor', 'w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
	vis_final_tracker_sae (rgb_raw, num_frames, self, gt, fr );
    drawnow;
end
pause; clf;
    % =====================================================================
% for fr = start:num_frames
%     [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
% 
%     bb = floor(self.history.target(fr,:));
%     bb_gt = (gt(1:4,fr))';
%     
%     title('Particle Dynamics - Box Position and Probability Indicator: Red(occlusion chance), Brighter (more probable). Darker(less probable)','Color','w');
% 	
%     vis_particle_position_probability (rgb_raw, self, fr , 1);
%     for i = 2:self.N
%         vis_particle_position_probability ([], self, fr , i);
%         hold on;
%         drawnow;
%     end
% end
% pause; clf;
%     % =====================================================================
% for fr = start:num_frames
%     [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
% 
%     bb = floor(self.history.target(fr,:));
%     bb_gt = (gt(1:4,fr))';
%     
%     title('Particle Dynamics - Occluded Particles','Color','w');
%     
%     vis_particle_position_occlusion (rgb_raw, self, fr , 1);
%     for i = 2:self.N
%         vis_particle_position_occlusion ([], self, fr , i);
%         hold on;
%     end
% end
% pause; clf;
    % =====================================================================
title('Particle Dynamics - HOC Distances: Particle Distances (red), Average Distances (blue), Weighted Distances (black)','Color','w');
set(gca, 'YColor', 'w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    vis_particle_hoc_distances ( self, num_frames, fr);
    drawnow;
end
pause; clf;
    % =====================================================================
title('Particle Dynamics - Median of Depth Distances: Particle Distances (red), Average Distances (blue), Weighted Distances (black)','Color','w');
set(gca, 'YColor', 'w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    vis_particle_medd_distances ( self, num_frames, fr);
    drawnow;
end
pause; clf;
    % =====================================================================
title('Particle Dynamics - Particle Probabilities (occluded ones  are in red)','Color','w');
set(gca, 'XColor', 'w','YColor', 'w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    vis_particle_probability ( self, fr );
    xlabel(['frame: ' num2str(fr)],'Color','w');
    drawnow;
end
pause; clf;
    % =====================================================================
% title('Particle Dynamics - Particle Probabilities Compared (occluded ones are exploded)','Color','w');
% set(gca, 'YColor', 'w');
% for fr = start:num_frames
%     [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
% 
%     bb = floor(self.history.target(fr,:));
%     bb_gt = (gt(1:4,fr))';    
%     
%     vis_particle_probability_comparison (self , fr , 1);
%     hold on;
%     
% 	for i = 1:self.N
%         vis_particle_probability_comparison (self , fr , i);
%         drawnow;
%     end
%     hold off;
% end
% pause; clf;
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
title('Stabilized Image','Color','w');   
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    subplot (1,2,1);  imshow (bb_content(rgb_raw,bb));
    xlabel(['frame: ' num2str(fr)],'Color','w');
    drawnow;
    
    if (~isnan(bb_gt(1)))
        subplot (1,2,2);  imshow (bb_content(rgb_raw,bb_gt-[0 0 3 3]));
        xlabel('ground truth','Color','w');
    else
        subplot (1,2,2);  cla;
        xlabel('OCCLUSION!','Color','w');
    end
    drawnow;
end
pause; clf;
    % % fix it later
%     cpx = bb(1) + bb(3)/2;
%     cpy = bb(2) + bb(4)/2;
%     subplot (1,2,2);  imshow (bb_content_safe(rgb_raw,[cpx-150,cpy-150,300,300]));
    
	% =====================================================================
% title('Particle Dynamics - Particle HOC vs. Template HOC and the Difference','Color','w');   
% for fr = start:num_frames
%     [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
% 
%     bb = floor(self.history.target(fr,:));
%     bb_gt = (gt(1:4,fr))';
%     
%     vis_particle_template_hoc_comparison (rgb_raw, self , fr , 1);
%     set(gca, 'YColor', 'w');
%     hold on;
%     for i = 1:self.N
%         vis_particle_template_hoc_comparison (rgb_raw, self , fr , i);
%         set(gca, 'YColor', 'w');
%         xlabel(['particle: ' num2str(i)],'Color','w');
%         drawnow;
%     end
%     hold off;
% end
% pause; clf;
%     
%     ctrs = self.feature{1}.rgb_ctr;
%     bbs = squeeze(floor(self.history.bbs(fr,:,:)));
% 
%     hoc1 = self.history.model_rgb_hist(fr,:);
%     subplot (3,1,1); hoc_vis (hoc1,ctrs);
%     
%     for i = 1:self.N
%         hoc2 = histogram_of_colors(bb_content(rgb_raw,bbs(i,:)),[],ctrs);
%         subplot (3,1,2); hoc_vis (hoc2,ctrs);
%         subplot (3,1,3); bar (abs(hoc1-hoc2)); xlim([0 length(hoc1)]); ylim([0 0.2]); drawnow;
%         drawnow;
%         pause (0.1);
%     end

    % =====================================================================
title('Particle Dynamics - Particle MedD vs. Template MedD','Color','w');   
set(gca, 'XColor', 'w');
for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    vis_particle_template_medd_comparison ( self, dep_raw , fr , bb);
    clf;
end
pause; clf;
    
    
 % =====================================================================
 % CONFIDENCE MAP
 % TEMPLATE EVOLUTION (OLD TEMPLATE, NEW ENTRY, NEW TEMPLATE)



%     frame = getframe; % VID
%     writeVideo(writerObj,frame); % VID


% close(writerObj); % VID





