function vis_final_tracker_sae (rgb_raw, num_frames, self, gt, fr )
    
    for i = 1:fr
        bbi(i,:) = floor(self.history.target(i,:));
        bbi_gt(i,:) = (gt(1:4,i))';
    end
    
    hold on
    plot(1:fr, bbi(:,3), 'b-','LineWidth',2);
    plot(1:fr, bbi_gt(:,3), 'b--','LineWidth',2);
    
    plot(1:fr, bbi(:,4), 'r-','LineWidth',2);
    plot(1:fr, bbi_gt(:,4), 'r--','LineWidth',2);
    
    sa = sqrt((bbi(:,3)-bbi_gt(:,3)).^2 + (bbi(:,4)-bbi_gt(:,4)).^2);
    plot(1:fr, sa, 'k-','LineWidth',3);
    
    xlim([1 num_frames]);
    ylim([0 sqrt(sum(size(rgb_raw).^2))]);
    hold off;    
    
    
end