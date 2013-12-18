function vis_final_tracker_cpe (num_frames, self, gt, fr )
    
    for i = 1:num_frames
        bbi = floor(self.history.target(i,:));
        bbi_gt = (gt(1:4,i))';
        
        cpe(i) = calculate_CPE (bbi_gt,bbi);
    end
    
    plot(1:fr,cpe(1:fr),'LineWidth',2);
    hold on;
    plot(fr,cpe(fr),'ro');
    xlabel('Frames');
    ylabel('CPE(pixel)');

    mc = max(cpe);
    xlim([1 num_frames]);
    ylim([0 mc]);
    hold on
    
    % http://stackoverflow.com/questions/6245626/matlab-filling-in-the-area-between-two-sets-of-data-lines-in-one-figure
    occ = isnan(cpe);
%     line ([find(occ)' find(occ)'+1],repmat(mc,sum(occ),2),'LineWidth',2);
%     line ([find(occ)' find(occ)'+1],repmat(0,sum(occ),2),'LineWidth',2);
%     fill ([find(occ)' find(occ)'+1],repmat(mc,sum(occ),2)
%       