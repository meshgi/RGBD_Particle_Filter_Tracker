function B = box_positioning_noise (B, Wrange, Hrange, Xnoise, Ynoise)

N = size(B,1);

% random numbers between -1 to +1
R1 = 2* (rand(N,1) - 0.5);
R2 = 2* (rand(N,1) - 0.5);
R3 = 2* (rand(N,1) - 0.5);
R4 = 2* (rand(N,1) - 0.5);

% noised bounding boxes
X = B(:,1) + Xnoise * R1;
Y = B(:,2) + Ynoise * R2;
W = B(:,3) + ((Wrange(2)-Wrange(1))/10) * R3; %white noise
H = B(:,4) + ((Hrange(2)-Hrange(1))/10) * R4; %white noise

B = [X Y W H];
