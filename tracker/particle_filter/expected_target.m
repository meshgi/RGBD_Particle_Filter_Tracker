function [bb_hat, z_hat] = expected_target ( bbs, z, prob )

bb_hat = prob * bbs;
z_hat  = prob * double(z);