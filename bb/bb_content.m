function out = bb_content (img, bb)
    bb = ceil(bb);
    out = img (bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3),:);
    
end