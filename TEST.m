addpath(genpath('.'));
clc
clear
close all

% bear_front
% child_no1
% face_occ5
% new_ex_occ4
% zcup_move_1


[vid_param, directory, num_frames, cam_param, gt, init_bb]   = video_info('zcup_move_1');


for i = 1:num_frames
    [rgb, depth] =  read_frame(vid_param, directory, i);
    
    %show the 2D image
    subplot(1,2,1); imshow(rgb);
    rectangle('Position',gt(1:4,i),'EdgeColor','y');
    subplot(1,2,2); imshow(depth);
    rectangle('Position',gt(1:4,i),'EdgeColor','r');
    
    drawnow
end
    
% 
% % display in 3D: subsample to avoid too much to display.
% XYZpoints = XYZpoints(:,1:20:end);
% RGBpoints = RGBpoints(:,1:20:end);
% subplot(1,3,3); scatter3(XYZpoints(1,:),XYZpoints(2,:),XYZpoints(3,:),ones(1,size(XYZpoints,2)),double(RGBpoints)'/255,'filled');
% axis equal; view(0,-90);
% imtool(depth)