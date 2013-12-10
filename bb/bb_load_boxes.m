function bb_list = bb_load_boxes (filename)

fid = fopen(filename);
bb_list = fscanf(fid, '%g,%g,%g,%g', [4,inf]);
fclose(fid);