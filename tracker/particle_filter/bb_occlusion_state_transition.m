function Z = box_occlusion_state_transition (oldZ, T)

R = rand(size(oldZ,1),1);
Z = uint8(R > T(uint8(oldZ)+1,1));

