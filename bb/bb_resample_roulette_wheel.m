function [X,ZZ] = bb_resample_roulette_wheel(X, Z, P, N)

% calculating cumulative distribution
R = cumsum(P, 2);

% random numbers
T = rand(1, N);

% resampling
[~, I] = histc(T, R);
X = X(I+1,:);

% occlusion flag of new particles
ZZ = Z(I+1);

% h = figure;  subplot(1,2,1);   plot(R); ylim([0,1]);   subplot(1,2,2);   hist(I,size(P,2)); % DEBUG MODE
% close (h); % DEBUG MODE
