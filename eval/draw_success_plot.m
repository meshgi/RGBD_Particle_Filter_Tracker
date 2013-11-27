function [ figure_handle ] = draw_success_plot( plot_title, threshold_steps, alg_success, alg_names, alg_auc )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    figure_handle = figure;
    hold on;

    leg = cell(size(alg_names,2),1);
    for tr = 1:size(alg_names,2)
        leg{tr} = [alg_names{1,tr}.name, sprintf(' (%0.3f)', alg_auc(tr))];
    end

    X = 0:1.0/threshold_steps:1;
    Y1 = alg_success(1,:);
    
    if size(alg_names,2) == 4    
        Y2 = alg_success(2,:);
        Y3 = alg_success(3,:);
        Y4 = alg_success(4,:);
        
        pl = plot(X,Y1,X,Y2,X,Y3,X,Y4);
        legend(leg{1},leg{2},leg{3},leg{4},'Location','NorthEast');
    else
        % unknown case, show only the first one
        pl = plot(X,Y1);
        legend(leg{1},'Location','NorthEast');
    end
    
    set(pl, 'LineWidth', 3);
    xlim([0 1]);
    ylim([0 1.05]);
    title(plot_title,'FontSize', 12);
    xlabel('Overlap Threshold');
    ylabel('Success Rate');

end

