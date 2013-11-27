function [ auc, success_plots ] = evaluate_success_plot_OPE (test_videos , trackers , control , results , ground_truth)
%EVALUATE_SUCCESS_PLOT_OPE Evaluate trackers using Sucess plots with
%One-Pass Evaluation
%   This function 
%
%
%   The conventional way to evaluate trackers is to run them throughout a 
%   test sequence with initialization from the ground truth position in the
%   first frame and report the average precision or success rate. We refer 
%   this as one-pass evaluation (OPE).
%
%   code by: Kourosh Meshgi, Oct 2013
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
            auc(tr) = sum(success(tr,:)); % area under curve for each tracker
        end
        success_plots(vid) = draw_success_plot (['Sequence: ' test_videos{1,vid}], control.success_plot_thresold_steps, success, trackers, auc);
    end
    % draw_success_plot ('Average Performance Over All Videos', control.success_plot_thresold_steps, AVERAGE(success_OVER_VIDEOS), trackers, AVERAGE_OVER_VIDEOS(auc));

    
end %======================================================================
    


function S = calculate_S ( gt, alg )

    % Ground Truth says Occlusion
    if isnan(gt(1))
        if isnan(alg(1))
            S = 1;
            return;
        else
            S = -1;
            return;
        end
    end

    % Ground Truth says No Occlusion but Algorithm says Occlusion
    if isnan(alg(1))
        S = -1;
        return;
    end

    % Compute the overlapping ratio
    box_intersect   = rectint(gt,alg);
    box_union       = gt(3)*gt(4) + alg(3)*alg(4) - box_intersect;
    S = double(box_intersect)/double(box_union);
    
end %======================================================================