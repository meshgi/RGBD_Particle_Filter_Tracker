function cpe_plot = draw_cpe_plot (plot_title, mismatch, trackers, no_occlusion_marks)

    cpe_plot = figure;
    hold on;

    colors = {'r','g','b','c','m','y','k','r--','g--','b--','c--','m--','y--','k--'};
    
    X = 1:length(no_occlusion_marks);
    maxY = 0;
    
    for tr = 1:size(trackers,2)
        Y = mismatch(tr,:);
        
        plot(X,Y, colors{1,tr}, 'LineWidth',2);
        
        maxY = max(maxY,max(Y(:)));
    end
    
    title(plot_title,'FontSize', 12);
    xlabel('Frames');
    ylabel('CPE(pixel)');
    
    % occlusion coloring    
    for fr = 1:length(no_occlusion_marks)
        if no_occlusion_marks(fr) == 0
            line ([fr-1;fr-1],[0;maxY],'Color','k','LineStyle','-.');
            line ([fr  ;fr  ],[0;maxY],'Color','k','LineStyle','-.');
            line ([fr+1;fr+1],[0;maxY],'Color','k','LineStyle','-.');
        end
    end
    
    ylim([0 maxY+5]);
    xlim([0 length(X)]);

end %======================================================================
