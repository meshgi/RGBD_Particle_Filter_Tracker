function cpe = evaluate_center_position_error (test_videos , trackers , control , results , ground_truth)
%EVALUATE_CENTER_POSITION_ERROR Evaluate trackers accuracy in localization
%of target using one point
%   This function calculates the center point of the bounding box as the
%   representative of the object and then measure ythe distance between
%   real and estimated central points 
%
%   code by: Kourosh Meshgi, Nov 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    for vid = 1:size(test_videos,2)
        for tr = 1:length(trackers)
            cpe(vid,tr) = 0;
            k = [];  % marks non-occluded frames
            for fr = 1:size(results,4)
                gt = squeeze (ground_truth{1,vid}(1:4,fr));
                alg = squeeze (results(vid,tr,:,fr));
                mismatch(tr,fr) = calculate_CPE ( gt(:)' , alg(:)' );
                if ( ~isnan(mismatch(tr,fr)) )
                    cpe(vid,tr) = cpe(vid,tr) + mismatch(tr,fr);
                end
                
                k = [k ~isnan(gt(1))];
                                    
            end
            cpe(vid,tr) = cpe(vid,tr) / sum(k);  % there is no division by zero since all sequences has at least one non occluded frame (first one)
        end
        % darw cpe vs time plots
        cpe_plots(vid) = draw_cpe_plot (['Sequence: ' test_videos{1,vid}], mismatch, trackers, k);
    end 
    
end %======================================================================
    


function d = calculate_CPE (gt, alg)
    if (isnan(gt(1)))
        d = NaN;
        return;
    end
    
    cp_gt = gt(1:2) + gt(3:4)/2;
    cp_alg = alg(1:2) + alg(3:4)/2;
    
    diff2 = (cp_alg - cp_gt).^2;
    d = sqrt(diff2(1) + diff2(2));
end %======================================================================
