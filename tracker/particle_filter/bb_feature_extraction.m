function f = bb_feature_extraction ( bb , g, rgb_raw, dep_raw, rgb_msk, dep_msk, rgb_ctr, rgb_cnf )
f.bb = bb;

for i = 1:g
    for j = 1:g
        cell_bb = bb_grid (bb,g,i,j);
        
        f.cell(i,j).rgb_hist    = histogram_of_colors   (bb_content(rgb_raw,cell_bb), bb_content(rgb_msk,cell_bb), rgb_ctr );
        f.cell(i,j).fg_ratio    = box_confidence        (bb_content(rgb_msk,cell_bb));  
        f.cell(i,j).confidence  = 1; %pdf(prior_dist(i,j),f.cell(i,j).fg_ratio);
        f.cell(i,j).depth_med   = median_of_depth       (bb_content(dep_raw,cell_bb),bb_content(dep_msk,cell_bb));
    end
end
