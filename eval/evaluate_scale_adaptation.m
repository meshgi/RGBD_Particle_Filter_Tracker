function sa = evaluate_scale_adaptation (test_videos , trackers , control , results , ground_truth)
%EVALUATE_SCALE_ADAPTATION Evaluate trackers scale adaptation ability
%   This function compares the dimensions of ground truth bounding box with
%   the one suggested by tracking algorithm. The results is calculated
%   error for this dimensions mismatches.
%
%   code by: Kourosh Meshgi, Nov 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    for vid = 1:size(test_videos,2)
        for tr = 1:1:length(trackers)
            sa(vid,tr) = 0;
            k = 0;  % counts non-occluded frames
            for fr = 1:size(results,4)
                gt = squeeze (ground_truth{1,vid}(1:4,fr));
                alg = squeeze (results(vid,tr,:,fr));
                mismatch = calculate_SA ( gt(:)' , alg(:)' );
                if ( mismatch >= 0 )
                    sa(vid,tr) = sa(vid,tr) + mismatch;
                    k = k+1;
                end
            end
            sa(vid,tr) = sa(vid,tr) / k;  % there is no division by zero since all sequences has at least one non occluded frame (first one)
        end
    end 
    
end %======================================================================
    


function d = calculate_SA (gt, alg)
    if (isnan(gt(1)))
        d = -1;
        return;
    end
    
    diff2 = (alg-gt).^2;
    d = sqrt(diff2(3) + diff2(4));
end %======================================================================
