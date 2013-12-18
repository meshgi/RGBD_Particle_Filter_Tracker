function vis_particle_position_probability (rgb_raw, self, frame_no , partivle_no)
    
    col = bb_prob_color_indicator (self.history.probs(frame_no,:) , self.history.z(frame_no,:));
    bbs = squeeze(floor(self.history.bbs(frame_no,:,:)));
    
    if (~isempty(rgb_raw))
        imshow(rgb_raw);
        hold on
    end
    
    rectangle('Position',bbs(partivle_no,:),'EdgeColor',col(partivle_no,:));        
    drawnow;
    
end