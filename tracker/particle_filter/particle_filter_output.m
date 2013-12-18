function particle_filter_output (gt, self , vid_param, cam_param, directory, num_frames, start)

fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Occlusion Aware Particle Framework');
error_type = zeros (1,4);

% writerObj = VideoWriter('output/v1.avi'); % VID
% writerObj.FrameRate = 10; % VID
% open(writerObj); % VID

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
    title('Particle Dynamics - Box Position and Probability Indicator: Red(occlusion chance), Brighter (more probable). Darker(less probable)','Color','w');
	
    vis_particle_position_probability (rgb_raw, self, fr , 1);
    for i = 2:self.N
        vis_particle_position_probability ([], self, fr , i);
        pause(0.01);
    end
    

    % =====================================================================

%     col = bb_prob_color_indicator (self.history.probs(fr,:) , self.history.z(fr,:));
%     imshow(rgb_raw);
%     bbs = squeeze(floor(self.history.bbs(fr,:,:)));
%     
%     for i = 1:self.N
%         if ( self.history.z(fr,i) == 0 )
%             continue;
%         end
%         rectangle('Position',bbs(i,:),'EdgeColor',col(i,:));
%         pause(0.01);
%         drawnow;
%     end
    
    % =====================================================================
    
%     if ( fr == 1 )
%         continue;
%     end
%     
%     hoc_dist = self.history.dist_hoc(2:fr,:);
%     probs = self.history.probs(2:fr,:);
%     avg_hoc_dist = nanmean(hoc_dist');
%     
%     hold on;
%     for i = 2:fr
%         semilogy (i*ones(1,self.N),hoc_dist(i-1,:),'ro');
%         hoc_dist(isnan(hoc_dist)) = 0; % to ignore NaN
%         w_avg_hoc_dist(i-1) = hoc_dist(i-1,:)*probs(i-1,:)';
%     end
%     semilogy (2:fr,avg_hoc_dist,'b--','LineWidth',2);
%     semilogy (2:fr,w_avg_hoc_dist,'k-','LineWidth',4);
%     
%     xlim([1 num_frames+1]);
%     ylim([0 1]);
        
    % =====================================================================
    
% 	if ( fr == 1 )
%         continue;
%     end
%     
%     medd_dist = self.history.dist_medd(2:fr,:);
%     probs = self.history.probs(2:fr,:);
%     avg_medd_dist = nanmean(medd_dist');
%     
%     hold on;
%     for i = 2:fr
%         plot (i*ones(1,self.N),medd_dist(i-1,:),'ro');
%         medd_dist(isnan(medd_dist)) = 0; % to ignore NaN
%         w_avg_medd_dist(i-1) = medd_dist(i-1,:)*probs(i-1,:)';
%     end
%     plot (2:fr,avg_medd_dist,'b--','LineWidth',2);
%     plot (2:fr,w_avg_medd_dist,'k-','LineWidth',4);
%     
%     xlim([1 num_frames+1]);
%     ylim([0 1]);
    % =====================================================================
%     
%     if ( fr == 1 )
%         continue;
%     end
%     
%     maxp = max(max(self.history.probs));
%     probs = self.history.probs(fr,:);
%     z = self.history.z(fr,:);
%     
%     bins = 0: 0.001 : maxp+0.001;
%     h1 = histc(probs,bins);
%     bar (bins,h1);
%     hold on;
%     
%     p2 = probs;
%     p2(z==0) = 0;
%     h2 = histc(p2,bins);
%     h2(1) = 0;
%     bar (bins,h2,'FaceColor','r');
%     hold off;
%     
%     xlim([0,maxp+0.001]);
%     ylim([0,10]);
%     
    % =====================================================================
    
%     if ( fr == 1 )
%         continue;
%     end
%     
%     probs = self.history.probs(fr,:);
%     explode = self.history.z(fr,:);
%     for i = 1:self.N
%         pie(probs(1:i),explode(1:i));
%         drawnow; pause (0.1);
%     end
%

    % =====================================================================
%     subplot (1,2,1);  imshow (bb_content(rgb_raw,bb));
%     % % fix it later
% %     cpx = bb(1) + bb(3)/2;
% %     cpy = bb(2) + bb(4)/2;
% %     subplot (1,2,2);  imshow (bb_content_safe(rgb_raw,[cpx-150,cpy-150,300,300]));
%     
	% =====================================================================
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
%     bbs = squeeze(floor(self.history.bbs(fr,:,:)));
%     
%     medd_template = 255* self.history.model_med_depth;
%     subplot(2,1,1);   imhist(dep_raw);
%     hold on;
%     plot (medd_template,5,'r^','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',15);
%     hold off
%     
%     subplot(2,1,2);   imhist(bb_content(dep_raw,bb));
%     hold on;
%     line ([medd_template medd_template], ylim() , 'Color', 'r', 'LineStyle','--', 'LineWidth',6);
%     
%     last = -1; %FLASH EFFECT
%     for i = 1:self.N
%         medd = 255 * median_of_depth (bb_content(dep_raw,bbs(i,:)),[]);
%         
%         if (last ~= -1) %FLASH EFFECT
%             plot (last,5,'b^','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10);
%         end
%         last = medd; %FLASH EFFECT
%         
%         plot (medd,5,'y^','MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',10);
%         drawnow;
%         pause (0.1);
%     end
%     
%     plot (last,5,'b^','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10); %FLASH EFFECT
%     
%     hold off;
    


end


%     frame = getframe; % VID
%     writeVideo(writerObj,frame); % VID


% close(writerObj); % VID





