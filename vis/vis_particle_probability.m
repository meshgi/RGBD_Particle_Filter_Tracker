function vis_particle_probability ( self, fr )
    
    if ( fr == 1 )
        return;
    end
    
    maxp = max(max(self.history.probs));
    probs = self.history.probs(fr,:);
    z = self.history.z(fr,:);
    
    bins = 0: 0.001 : maxp+0.001;
    h1 = histc(probs,bins);
    bar (bins,h1,'FaceColor','c');
    hold on;
    
    p2 = probs;
    p2(z==0) = 0;
    h2 = histc(p2,bins);
    h2(1) = 0;
    bar (bins,h2,'FaceColor','r');
    hold off;
    
    xlim([0,maxp+0.001]);
    ylim([0,10]);
    drawnow;
    
end