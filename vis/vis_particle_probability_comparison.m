function vis_particle_probability_comparison (self , frame_no , particle_no )
    
    if ( frame_no == 1 )
        return;
    end
    
    probs = self.history.probs(frame_no,:);
    explode = self.history.z(frame_no,:);
    
	pie(probs(1:particle_no),explode(1:particle_no));
	drawnow;

end