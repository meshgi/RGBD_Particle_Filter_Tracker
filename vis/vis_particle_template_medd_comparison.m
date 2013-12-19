function vis_particle_template_medd_comparison ( self, dep_raw , fr , bb)

    bbs = squeeze(floor(self.history.bbs(fr,:,:)));
    
    medd_template = 255* self.history.model_med_depth;
    subplot(2,1,1);   imhist(dep_raw);
    hold on;
    plot (medd_template,5,'r^','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',15);
    hold off
    
    subplot(2,1,2);   imhist(bb_content(dep_raw,bb));
    hold on;
    line ([medd_template medd_template], ylim() , 'Color', 'r', 'LineStyle','--', 'LineWidth',6);
    
    last = -1; %FLASH EFFECT
    for i = 1:self.N
        medd = 255 * median_of_depth (bb_content(dep_raw,bbs(i,:)),[]);
        
        if (last ~= -1) %FLASH EFFECT
            plot (last,5,'b^','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10);
        end
        last = medd; %FLASH EFFECT
        
        plot (medd,5,'y^','MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',10);
        drawnow;
        pause (0.1);
    end
    
    plot (last,5,'b^','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10); %FLASH EFFECT
    
    hold off;
    
end