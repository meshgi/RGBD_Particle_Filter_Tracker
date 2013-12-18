function vis_error_types (bb, bb_gt, to )

    bbz = isnan(bb(1));
    s = calculate_S (bb_gt,bb);

    if (s == -1)
        if (bbz == 1)
            % error TYPE II: missed the target 
            k = 2;
        else
            % error TYPE III: false positive, identity loss 
            k = 3;
        end
    else
        if (s < to )
            % error TYPE I: overlap not significant
            k = 1;
        else
            % tracker did a good job
            k = 4;
        end
    end
    error_type(k) = error_type(k) + 1;

    bar(error_type,'FaceColor','b');
    hold on
    overlay = zeros(1,4);  overlay(k) = error_type(k);
    bar(overlay,'FaceColor','r');
    ylim([0 num_frames])
    set(gca,'XTickLabel',{'low overlap','miss','false positive','good detection'});
    xlabel (['Success rate (t_o = ' num2str(to) ')']);
    drwanow;

end