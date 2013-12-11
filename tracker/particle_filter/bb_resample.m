function [B, Z] = bb_resample ( B, Z, P, expT, expZ, I, Wrange, Hrange, Xnoise, Ynoise, g, T )

N = size(B,1);

% resample N-1 particles from N particles proportional to their prob
[B, Z] =    bb_resample_roulette_wheel (B, Z, P, N-1);

% add noise to position of resampled boxes
B =         bb_positioning_noise (B, Wrange, Hrange, Xnoise, Ynoise);

% check whether the boxes are valid ones
B =         bb_range_check (B, Wrange, Hrange, size(I), g);

% state transition of boxes based on STM
Z =         bb_occlusion_state_transition (Z, T);

% archive the expected target, to avoid un-neccessary jiters in box
B = [B; bb_grid_adjustment(ceil(expT),g)];                                     % the expected box adjusted to grid
Z = [Z; uint8(expZ>0.5)];                                                   % if the occlusion prob is higher than 0.5 it is probably occluded
