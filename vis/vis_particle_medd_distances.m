function vis_particle_medd_distances ( self, num_frames, fr)
    
	if ( fr == 1 )
        return;
    end
    
    medd_dist = self.history.dist_medd(2:fr,:);
    probs = self.history.probs(2:fr,:);
    avg_medd_dist = nanmean(medd_dist');
    
    hold on;
    for i = 2:fr
        plot (i*ones(1,self.N),medd_dist(i-1,:),'ro');
        medd_dist(isnan(medd_dist)) = 0; % to ignore NaN
        w_avg_medd_dist(i-1) = medd_dist(i-1,:)*probs(i-1,:)';
    end
    plot (2:fr,avg_medd_dist,'b--','LineWidth',2);
    plot (2:fr,w_avg_medd_dist,'k-','LineWidth',4);
    
    xlim([1 num_frames+1]);
    ylim([0 1]);
    drawnow
    
end