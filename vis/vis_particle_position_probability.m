function vis_particle_position_probability (rgb_raw, self, frame_no , particle_no)
    
    col = bb_prob_color_indicator (self.history.probs(frame_no,:) , self.history.z(frame_no,:));
    bbs = squeeze(floor(self.history.bbs(frame_no,:,:)));
    
    if (~isempty(rgb_raw))
        imshow(rgb_raw);
        hold on
    end
    
    rectangle('Position',bbs(particle_no,:),'EdgeColor',col(particle_no,:));        
    drawnow;
    
end