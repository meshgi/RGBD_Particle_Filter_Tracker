function boy = bb_grid(box, g, i , j)

boy = uint16([0 0 0 0]);
boy(1) = box(1) + (j-1)*box(3)/g;
boy(2) = box(2) + (i-1)*box(4)/g;
boy(3) = box(3)/g;
boy(4) = box(4)/g;