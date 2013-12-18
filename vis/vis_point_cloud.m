function vis_point_cloud (rgb_raw, dep_raw, cam_param, view_dir )

    if ( nargin < 4 || isempty(view_dir))
        view_dir = [0,-90];
    end

    depthInpaint = double(dep_raw)/1000;  % convert from mm to m
    [x,y] = meshgrid(1:640, 1:480);   
    
    cx = cam_param(1,3); cy = cam_param(2,3);  
    fx = cam_param(1,1); fy = cam_param(2,2);
    
    Xworld = (x-cx).*depthInpaint*1/fx;  
    Yworld = (y-cy).*depthInpaint*1/fy;  
    Zworld = depthInpaint;  
    
    validM = dep_raw~=0;  
    XYZworldframe = [Xworld(:)'; Yworld(:)'; Zworld(:)'];  
    valid = validM(:)';    
     
    % XYZworldframe 3xn and RGB 3xn  
    RGB = [reshape(rgb_raw(:,:,1),1,[]);reshape(rgb_raw(:,:,2),1,[]);reshape(rgb_raw(:,:,3),1,[])];  
    XYZpoints = XYZworldframe(:,valid);  
    RGBpoints = RGB(:,valid);  
     
    % display in 3D: subsample to avoid too much to display.  
    XYZpoints = XYZpoints(:,1:1:end);  
    RGBpoints = RGBpoints(:,1:1:end);  
    scatter3(XYZpoints(1,:),XYZpoints(2,:),XYZpoints(3,:),5*ones(1,size(XYZpoints,2)),double(RGBpoints)'/255,'filled');  
    axis equal; 
    
    view(view_dir); 
end
    
    