function vis_particle_template_hoc_comparison (rgb_raw, self , fr , particle_no)
    
    ctrs = self.feature{1}.rgb_ctr;
    bbs = squeeze(floor(self.history.bbs(fr,:,:)));

    hoc1 = self.history.model_rgb_hist(fr,:);
    subplot (3,1,1); hoc_vis (hoc1,ctrs);
    
    hoc2 = histogram_of_colors(bb_content(rgb_raw,bbs(particle_no,:)),[],ctrs);
    subplot (3,1,2); hoc_vis (hoc2,ctrs);
    subplot (3,1,3); bar (abs(hoc1-hoc2)); xlim([0 length(hoc1)]); ylim([0 0.2]); drawnow;
    drawnow;
    
end