function [ rgb, depth, XYZpoints, RGBpoints ] = read_frame( frames, directory, frame_no, cam_param)
%READ_FRAME reads a frame of dataset given video info and frame number
%   readframe( frames, directory, frame_no, cam_param) reads data from
%   the corresponding frame in the dataset, and returns the color image, the
%   depth map, and the constructed 3D world in the point cloud format, two
%   arrays of RGB and XYZ value with the column number works as their
%   index. 
%   readframe( frames, directory, frame_no) works similarly, but does
%   not construct the 3D world saving the computation power and returns
%   empty matrices for XYZ- and RGBpoints.
%   Modified from the code of Shuran Song, code was obtained Sept 2013 from 
%   http://vision.princeton.edu/projects/2013/tracking/dataset.html
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    
%     imageNames = cell(1,numOfFrames*2);
%     XYZcam = zeros(480,640,4,numOfFrames);

    %% Input Check
    if nargin < 3, frame_no = 1; end
    
    %% Read Frame Information
    imageName = fullfile(directory,sprintf('rgb/r-%d-%d.png', frames.imageTimestamp(frame_no), frames.imageFrameID(frame_no)));
    rgb = imread(imageName);
    depthName = fullfile(directory,sprintf('depth/d-%d-%d.png', frames.depthTimestamp(frame_no), frames.depthFrameID(frame_no)));
    depth = imread(depthName);
    depth = bitor(bitshift(depth,-3), bitshift(depth,3-16));
    depth = double(depth);

%% Create 3D World

    if nargin > 3
        
        % Camera Intrinsic parameters K is [fx 0 cx; 0 fy cy; 0 0 1];
        K = cam_param;
        cx = K(1,3);cy = K(2,3);
        fx = K(1,1);fy = K(2,2);
        
        % 3D point for the frame
        depthInpaint = depth/1000;
        [x,y] = meshgrid(1:640, 1:480); 
        Xworld = (x-cx).*depthInpaint*1/fx;
        Yworld = (y-cy).*depthInpaint*1/fy;
        Zworld = depthInpaint;
        validM = depth~=0;
        XYZworldframe = [Xworld(:)'; Yworld(:)'; Zworld(:)'];
        valid = validM(:)';   

        % XYZworldframe 3xn and RGB 3xn
        RGB = [reshape(rgb(:,:,1),1,[]);reshape(rgb(:,:,2),1,[]);reshape(rgb(:,:,3),1,[])];
        XYZpoints = XYZworldframe(:,valid);
        RGBpoints = RGB(:,valid);
        
    else
        
        XYZpoints = [];
        RGBpoints = [];
        
    end
    
    %% Rescale depth
    depth(depth==0) = 10000;
    depth = (depth-500)/8500; %only use the data from 0.5-8m
    depth(depth<0) = 0;
    depth(depth>1) = 1;
    depth = uint8(floor(255*(1-depth)));


end %======================================================================