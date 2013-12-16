function x = bb_feature_distance ( x ,y , g, features )

    for f = 1:size(features,2)

        % Matlab is stupid! Array1 and Array2 can be uint8, so
        % array1-array2 can't be negative!
        array1 = double(x.cell(1,1).feature(f).val);
        array2 = double(y.cell(1,1).feature(f).val);
                
        % calculating the distance of each feature
        switch (features{f}.sim)

            case 'L2'
                d = dist_l2 ( array1 , array2 );
                
            case 'Bhattacharyya'
                d = dist_bhattacharyya ( array1 , array2 );
                
            case 'Intersection'
            case 'KL-divergance'
            case 'GMM-dist'
            case 'Quadratic'
            case 'Cosine'
            case 'Chi-sqaure'
            case 'Diffusion'
            case 'Earth Mover'
            case 'Correlation'


            case 'L2,Grid2'
                % TO BE REVISED
                x.dist(f) = 0;
                g = 2;
                for i = 1:g
                    for j = 1:g
                        cell_bb = bb_grid (bb,g,i,j);
                        
                        array1 = x.cell(i,j).feature(f).val;
                        array2 = y.cell(i,j).feature(f).val;
                        d = sum((array1-array2).^2);
                        x.dist(f) = x.dist(f) + d;
                    end
                end
                
            case 'L2,Grid3'
            case 'L2,Grid2,Weighted'
        end
        
        if ( isnan(d) )
            % e.g. HoC is empty
            d = Inf;
        end
        x.dist(f) = d;
    end

    % disp ([x.dist(1) x.dist(2)]);

end


