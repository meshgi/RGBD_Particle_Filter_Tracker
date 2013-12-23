function vis_particle_position_occlusion (rgb_raw, self, frame_no , particle_no)
    
    if ( self.history.z(frame_no,particle_no) == 1 )
        bbs = squeeze(floor(self.history.bbs(frame_no,:,:)));
        rectangle('Position',bbs(particle_no,:),'EdgeColor','r');
    else
        if (~isempty(rgb_raw))
            imshow(rgb_raw);
        end
    end
            
    
end
    
    