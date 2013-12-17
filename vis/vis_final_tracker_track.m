function vis_final_tracker_track (img_raw, bb, bb_gt )

    imshow(img_raw);
    hold on;
    if (~isnan(bb))
        rectangle('Position',bb,'EdgeColor','y');
    end
    hold on;
    if (~isnan(bb_gt))
        rectangle('Position',bb_gt,'EdgeColor','g');
    end
    
end