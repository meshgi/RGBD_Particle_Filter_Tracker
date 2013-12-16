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