function vis_particle_hoc_distances ( self, num_frames, fr)

    if ( fr == 1 )
        return;
    end
    
    hoc_dist = self.history.dist_hoc(2:fr,:);
    probs = self.history.probs(2:fr,:);
    avg_hoc_dist = nanmean(hoc_dist');
    
    hold on;
    for i = 2:fr
        semilogy (i*ones(1,self.N),hoc_dist(i-1,:),'ro');
        hoc_dist(isnan(hoc_dist)) = 0; % to ignore NaN
        w_avg_hoc_dist(i-1) = hoc_dist(i-1,:)*probs(i-1,:)';
    end
    semilogy (2:fr,avg_hoc_dist,'b--','LineWidth',2);
    semilogy (2:fr,w_avg_hoc_dist,'k-','LineWidth',4);
    
    xlim([1 num_frames+1]);
    ylim([0 1]);
    drawnow;
    
end