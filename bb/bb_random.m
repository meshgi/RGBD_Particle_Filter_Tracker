function bb = bb_random( img_size )
%BB_RANDOM Creates a random bounding box which fits completely in the image
% dimensions given
%   This function serves as a utility function to create a random bounding
%   box on image, where tyhe size and position does not matter. By default
%   the size of box is larger than 30x30 pixels

    H = img_size(1);
    W = img_size(2);

    x = randi([1 W-30],1);  %x in the image
    y = randi([1 H-30],1);  %y in the image

    w = randi([30, W-x],1);
    h = randi([30, H-y],1);

    bb = [x,y,w,h];
end

