function vis_particle_position_occlusion (rgb_raw, self, frame_no , particle_no)
    
    if ( self.history.z(frame_no,particle_no) == 1 )
        vis_particle_position_probability (rgb_raw, self, frame_no , particle_no);
    else
        if (~isempty(rgb_raw))
            imshow(rgb_raw);
        end
    end
            
    
end
    
    