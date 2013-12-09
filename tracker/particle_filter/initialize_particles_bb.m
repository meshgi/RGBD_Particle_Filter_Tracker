function [box, z] = initialize_particles_bb (img, N, w_rng, h_rng, grid, w_noise, h_noise, mask, nocc_init)
% Create bounding boxes as particles in particle filter

    %N: number of boxes
    box=zeros(N,4);

    if (nargin < 5)
        grid = 1;
    end

    if (nargin < 6)
        mask = [];
        w_noise = 0;
        h_noise = 0;
    end
    
    if (nargin < 9)
        nocc_init = 1; % no occlusion handled
    end

    for i = 1:N
        box(i,:)=create_box(img, w_rng, h_rng, uint16(grid), w_noise, h_noise, mask);
    end
    
    z = rand(N,1) > nocc_init;
end


function box=create_box(im, w_range, h_range, g, w_noise, h_noise, mask)
% Create bouding box in 3 different cases: 
% 1- normal bb,
% 2- grid bb, and
% 3- grid bb centered on foreground

% meaningful range of box width and heigh
% w_range=[50 200];
% h_rang=[200 400]
% h=2.5*w
% [x,y,w,h]
% g is grid size
    if (isempty(mask))
        % uniformely distributed particles
        box(3)= w_range(1)+rand*(w_range(2)-w_range(1));                             %w[50 200]
        box(4)= h_range(1)+rand*(h_range(2)-h_range(1));                             %h [200 400]

        box(1)=1+rand*(size(im,2)-box(3)-10);                                       %set restriction [1 640-w-2]
        box(2)=1+rand*(size(im,1)-box(4)-10);                                       %set restriction [1 480-h-2]

        box=ceil(box);

    else
        % the partcle centers are foreground points 
        [fg_y,fg_x] = find(mask ==1);

        r = randi(size(fg_x,1));
        box = can_make_box ( fg_x(r) + randi(w_noise), ...
                             fg_y(r) + randi(h_noise), ...
                             h_range(1), h_range(2), ...
                             w_range(1), w_range(2), ...
                             size(im,1), size(im,2));
        while ( isempty(box) )
            r = randi(size(fg_x,1));
            box = can_make_box ( fg_x(r) + randi(w_noise), ...
                                 fg_y(r) + randi(h_noise), ...
                                 h_range(1), h_range(2), ...
                                 w_range(1), w_range(2), ...
                                 size(im,1), size(im,2));
        end

    end

    % grid size adjustment
    box = bb_grid_adjustment(uint16(box),g);
   
end



function box = can_make_box(x,y,min_h,max_h,min_w,max_w,img_h,img_w)
% Checks whether it is possible to make bb with valid sizes, if it is
% possible make a valid random one centered on given coordinates

    % center range check
    if (x < 1 || x > img_w || y < 1 || y > img_h)
        box = [];
        return
    end

    % calcuate distance of center to edges of screen
    lft_margin = x - 1;
    rgt_margin = img_w - x - 1;
    top_margin = y - 1;
    dwn_margin = img_h - y - 1;

    % check if the margins are enough to make at least smallest box
    if lft_margin < min_w/2 || rgt_margin < min_w/2 || top_margin < min_h/2 || dwn_margin < min_h/2
        box = [];
        return
    end

    % set the biggest possible box dimensions
    max_w = min3(max_w, 2*lft_margin, 2*rgt_margin);
    max_h = min3(max_h, 2*top_margin, 2*dwn_margin);

    % make a random box in valid size
    w = min_w + randi(max_w-min_w + 1) - 1;
    h = min_h + randi(max_h-min_h + 1) - 1;

    box = ceil([x-w/2,y-h/2,w,h]);
end

function m = min3(a,b,c)
    m = min(a,min(b,c));
end

