function [ auc, success_plots ] = evaluate_success_plot_OPE (test_videos , trackers , control , results , ground_truth)
%EVALUATE_SUCCESS_PLOT_OPE Evaluate trackers using Sucess plots with
%One-Pass Evaluation
%   This function draw a success plot for all video seqeunces and the
%   average performance of trackers in separate plots. In each plot several
%   trackers are evaluated by their success to estimate the ground truth by
%   a certain degree. This degree, called overlapping threshold can be
%   between 0 to 100%. If the threshold is zero, it means that the
%   evaluation metric only cares about whether the tracker could
%   distinguish occlusions or not. In the case of 100% it should not only
%   detect occlusions correctly, but also outputs the exact bounding box of
%   ground thruth. The success plot, draws the success of each tracker
%   having different thresholds and calculates the area under curve (AUC)
%   of this plot as a measure for tracker computattion.
%   The conventional way to evaluate trackers is to run them throughout a 
%   test sequence with initialization from the ground truth position in the
%   first frame and report the average precision or success rate. We refer 
%   this as one-pass evaluation (OPE).
%
%   code by: Kourosh Meshgi, Nov 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    for vid = 1:size(test_videos,2)
        for tr = 1:1:length(trackers)
            for th = 0:control.success_plot_thresold_steps
                k = 0;  % success counter
                for fr = 1:size(results,4)
                    gt = squeeze (ground_truth{1,vid}(1:4,fr));
                    alg = squeeze (results(vid,tr,:,fr));
                    S = calculate_S ( gt(:)' , alg(:)' );
                    if S >= (double(th)/control.success_plot_thresold_steps)
                        k = k + 1; 
                    end;
                end
                r = k / size(results,4);  % success ratio
                success(tr,th+1) = r;     % success of each tracker for each overlap threshold
            end
            auc(vid,tr) = sum(success(tr,:)); % area under curve for each tracker
        end
        success_plots(vid) = draw_success_plot (['Sequence: ' test_videos{1,vid}], control.success_plot_thresold_steps, success, trackers, auc);
    end
    % draw_success_plot ('Average Performance Over All Videos', control.success_plot_thresold_steps, AVERAGE(success_OVER_VIDEOS), trackers, AVERAGE_OVER_VIDEOS(auc));

    
end %======================================================================
    
