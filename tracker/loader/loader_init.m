function x = loader_init (params)

x.name = params.name;
x.type = 'loader';

x.bb_list = bb_load_boxes (params.filename);
