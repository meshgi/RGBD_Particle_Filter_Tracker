function boy = bb_grid_adjustment (box,g)

boy = box;
boy(3) = box(3) - mod(box(3),g);
boy(4) = box(4) - mod(box(4),g);

end

