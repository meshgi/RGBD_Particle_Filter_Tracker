function particle_filter_output (gt, self , vid_param, cam_param, directory, num_frames, start)

% fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Particle Visualization');
figure
error_type = zeros (1,4);

for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);

    % =====================================================================
    bb = floor(self.history.target(fr,:));
    bb_gt = (gt(1:4,fr))';
    
    % =====================================================================
%     figure;
%     imshow(rgb_raw);
%     hold on;
%     rectangle('Position',bb,'EdgeColor','y');
%     hold on;
%     rectangle('Position',bb_gt,'EdgeColor','g');
%     
    % =====================================================================
%     figure;
%     imshow(dep_raw);
%     hold on;
%     rectangle('Position',bb,'EdgeColor','y');
%     hold on;
%     rectangle('Position',bb_gt,'EdgeColor','g');
    
    % =====================================================================
%     figure;
%     
%     depthInpaint = double(dep_raw)/1000;  % convert from mm to m
%     [x,y] = meshgrid(1:640, 1:480);   
%     
%     cx = cam_param(1,3); cy = cam_param(2,3);  
%     fx = cam_param(1,1); fy = cam_param(2,2);
%     
%     Xworld = (x-cx).*depthInpaint*1/fx;  
%     Yworld = (y-cy).*depthInpaint*1/fy;  
%     Zworld = depthInpaint;  
%     
%     validM = dep_raw~=0;  
%     XYZworldframe = [Xworld(:)'; Yworld(:)'; Zworld(:)'];  
%     valid = validM(:)';    
%      
%     % XYZworldframe 3xn and RGB 3xn  
%     RGB = [reshape(rgb_raw(:,:,1),1,[]);reshape(rgb_raw(:,:,2),1,[]);reshape(rgb_raw(:,:,3),1,[])];  
%     XYZpoints = XYZworldframe(:,valid);  
%     RGBpoints = RGB(:,valid);  
%      
%     % display in 3D: subsample to avoid too much to display.  
%     XYZpoints = XYZpoints(:,1:1:end);  
%     RGBpoints = RGBpoints(:,1:1:end);  
%     scatter3(XYZpoints(1,:),XYZpoints(2,:),XYZpoints(3,:),ones(1,size(XYZpoints,2)),double(RGBpoints)'/255,'filled');  
%     axis equal; view(0,-90); 
    
    % =====================================================================
    
%     bbz = isnan(bb(1));
%     s = calculate_S (bb_gt,bb);
%     to = 0.5;
%     
%     if (s == -1)
%         if (bbz == 1)
%             % error TYPE II: missed the target 
%             k = 2;
%         else
%             % error TYPE III: false positive, identity loss 
%             k = 3;
%         end
%     else
%         if (s < to )
%             % error TYPE I: overlap not significant
%             k = 1;
%         else
%             % tracker did a good job
%             k = 4;
%         end
%     end
%     error_type(k) = error_type(k) + 1;
%     
%     bar(error_type,'FaceColor','b');
%     hold on
%     overlay = zeros(1,4);  overlay(k) = error_type(k);
%     bar(overlay,'FaceColor','r');
%     ylim([0 num_frames])
%     set(gca,'XTickLabel',{'low overlap','miss','false positive','good detection'});
%     xlabel (['Success rate (t_o = ' num2str(to) ')']);
%     pause(0.1)
%     
    % =====================================================================
%    
%     imshow(rgb_raw);
%     for i = 1:fr
%         bbi = floor(self.history.target(i,:));
%         bbi_gt = (gt(1:4,i))';
%         
%         bb_traj_x(i) = bbi(1) + bbi(3)/2;
%         bb_traj_y(i) = bbi(2) + bbi(4)/2;
%         bbg_traj_x(i) = bbi_gt(1) + bbi_gt(3)/2;
%         bbg_traj_y(i) = bbi_gt(2) + bbi_gt(4)/2;
%     end
%     hold on;
%     plot(bb_traj_x,bb_traj_y,'-yo','LineWidth',2,'MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',8);
%     hold on;
%     plot(bbg_traj_x,bbg_traj_y,'-go','LineWidth',2,'MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
%     hold off;
%     pause(0.1)
%     
    % =====================================================================
    
%     for i = 1:num_frames
%         bbi = floor(self.history.target(i,:));
%         bbi_gt = (gt(1:4,i))';
%         
%         cpe(i) = calculate_CPE (bbi_gt,bbi);
%     end
%     
%     plot(1:fr,cpe(1:fr),'LineWidth',2);
%     hold on;
%     plot(fr,cpe(fr),'ro');
%     xlabel('Frames');
%     ylabel('CPE(pixel)');
% 
%     mc = max(cpe);
%     xlim([1 num_frames]);
%     ylim([0 mc]);
%     hold on
%     
%     % http://stackoverflow.com/questions/6245626/matlab-filling-in-the-area-between-two-sets-of-data-lines-in-one-figure
%     occ = isnan(cpe);
% %     line ([find(occ)' find(occ)'+1],repmat(mc,sum(occ),2),'LineWidth',2);
% %     line ([find(occ)' find(occ)'+1],repmat(0,sum(occ),2),'LineWidth',2);
% %     fill ([find(occ)' find(occ)'+1],repmat(mc,sum(occ),2)
%       
    % =====================================================================
% 
%     for i = 1:fr
%         bbi(i,:) = floor(self.history.target(i,:));
%         bbi_gt(i,:) = (gt(1:4,i))';
%     end
%     
%     hold on
%     plot(1:fr, bbi(:,3), 'b-','LineWidth',2);
%     plot(1:fr, bbi_gt(:,3), 'b--','LineWidth',2);
%     
%     plot(1:fr, bbi(:,4), 'r-','LineWidth',2);
%     plot(1:fr, bbi_gt(:,4), 'r--','LineWidth',2);
%     
%     sa = sqrt((bbi(:,3)-bbi_gt(:,3)).^2 + (bbi(:,4)-bbi_gt(:,4)).^2);
%     plot(1:fr, sa, 'k-','LineWidth',3);
%     
%     xlim([1 num_frames]);
%     ylim([0 sqrt(sum(size(rgb_raw).^2))]);
%     hold off;    
%     
%         
    % =====================================================================
    
%     col = bb_prob_color_indicator (self.history.probs(fr,:) , self.history.z(fr,:));
%     imshow(rgb_raw);
%     bbs = squeeze(floor(self.history.bbs(fr,:,:)));
%     
%     for i = 1:self.N
%         rectangle('Position',bbs(i,:),'EdgeColor',col(i,:));
%         pause(0.01);
%         drawnow;
%     end
%     

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
    
    if ( fr == 1 )
        continue;
    end
    
    probs = self.history.probs(fr,:);
    z = self.history.z(fr,:);
    
    bins = 0: 0.001 : 0.5;
    h1 = histc(probs,bins);
    bar (bins,h1);
    hold on;
    
    p2 = probs;
    p2(z==0) = 0;
    h2 = histc(p2,bins);
    h2(1) = 0;
    bar (bins,h2,'FaceColor','r');
    hold off;
    
    
    
    xlim([0,0.2]);
    
    % color occlusion case prob
    
    
    
end





