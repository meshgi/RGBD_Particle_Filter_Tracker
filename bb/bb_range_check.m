function B = box_range_check (B, Wrange, Hrange, Isize, g)

%decomposition of bounding box
X = B(:,1);
Y = B(:,2);
W = B(:,3);
H = B(:,4);
N = size(B,1);

% width of the box
W(W < Wrange(1)) = Wrange(1);
W(W > Wrange(2)) = Wrange(2);

% height of the box
H(H < Hrange(1)) = Hrange(1);
H(H > Hrange(2)) = Hrange(2);

% out of range: right
Z = X+W - repmat(Isize(2)-10,N,1);
Z (Z < 0 ) = 0;
X = X -Z;

% out of range: bottom
Z = Y+H - repmat(Isize(1)-10,N,1);
Z (Z < 0 ) = 0;
Y = Y -Z;

% out of range: left
X (X <= 0) = 10;

% out of range: top
Y ( Y <= 0) = 10;

% reconstructing bounding box and grid size adjustment
B = bb_grid_adjustment(ceil([X Y W H]),g);
