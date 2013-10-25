function x = particle_filter_init (params)

x.name  = params.name;
x.type = 'particle_filter';


x.N     = params.number_of_particles;
x.fn    = params.feature_name;
x.sm    = params.similarity_measure;
x.vt    = params.variance_from_target;
x.occ_th= params.occlusion_flag_th;
x.last  = NaN(1,4);