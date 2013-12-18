function vis_final_tracker_trajectory (rgb_raw, gt , self,  fr )

    imshow(rgb_raw);
    for i = 1:fr
        bbi = floor(self.history.target(i,:));
        bbi_gt = (gt(1:4,i))';
        
        bb_traj_x(i) = bbi(1) + bbi(3)/2;
        bb_traj_y(i) = bbi(2) + bbi(4)/2;
        bbg_traj_x(i) = bbi_gt(1) + bbi_gt(3)/2;
        bbg_traj_y(i) = bbi_gt(2) + bbi_gt(4)/2;
    end
    hold on;
    plot(bb_traj_x,bb_traj_y,'-yo','LineWidth',2,'MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',8);
    hold on;
    plot(bbg_traj_x,bbg_traj_y,'-go','LineWidth',2,'MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
    hold off;
    drawnow;
end