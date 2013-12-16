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