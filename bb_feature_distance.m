function x = bb_feature_distance ( x ,y , g, features )

    for f = 1:size(features,2)

        % calculating the distance of each feature
        switch (features{f}.sim)

            case 'Euclidean'
                array1 = x.cell(1,1).rgb_hist;
                array2 = y.cell(1,1).rgb_hist;
                d = sum((array1-array2).^2);
                x.dist(f) = d;

            case 'Bhattacharyya'


            case 'Euclidean(Grid2)'
                g = 2;
                for i = 1:g
                    for j = 1:g
                        cell_bb = bb_grid (bb,g,i,j);
                        x.cell(i,j).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,cell_bb), bb_content(rgb_msk,cell_bb), features{f}.rgb_ctr );
                    end
                end
        end
    end
end


% Euclidean
% Bhattacharyya
% Intersection
% ...
% Euclidean(Grid2)
% Euclidean(Grid3)
% ...
% Euclidean(Grid2,Weighted)
