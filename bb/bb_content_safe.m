function out = bb_content_safe (img, bb)
    bb = ceil(bb);
    
    if ( bb(1) < 1 || bb(2) < 1 || bb(1)+bb(3)>size(img,2) || bb(2)+bb(4)>size(img,1))
        
        x = 1;
        y = 1;
        
        if (bb(1) < 1)
            x = 1-bb(1);
        end
        if (bb(2) < 1)
            y = 1-bb(2);
        end
        
        img2 = repmat(uint8(255),[-y+size(img,1)+1,-x+size(img,2)+1,3]);
        img2(y:y+size(img,1)-1,x:x+size(img,2)-1,:) = img;
        
        img = img2;
        bb(1) = min(1,bb(1));
        bb(2) = min(1,bb(2));
        
    end
    
    out = bb_content(img,bb);
    
end