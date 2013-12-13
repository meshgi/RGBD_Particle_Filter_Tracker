function fh = vis_particle (no,  rgb_raw, dep_raw, rgb_msk, bb , rgb_hist , medD , rgb_dist, dep_dist , likelihood, rgb_centers , target_hist,target_bb)

g = 1;

% big bad black figuure -> full screen: 'units','normalized','outerposition',[0 0 1 1]
if isempty(get(0,'Children')) || strcmp(get(gcf,'name'),'Particle Visualization') == false
    fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Particle Visualization');
    axis tight
end
fh = gcf;

% particle histogram
s1 = subplot(4,4,[1,2,5,6]);
hoc_vis (rgb_hist, rgb_centers);

% target histogram
s2 = subplot(4,4,[9,10,13,14]);
hoc_vis (target_hist, rgb_centers);

% tracking image
s3 = subplot(4,4,7);
imshow(rgb_msk);
hold on;
rectangle('Position',bb,'EdgeColor','y');

% rgb image
s4 = subplot(4,4,3);
imshow(rgb_raw);
hold on;
rectangle('Position',bb,'EdgeColor','y');
rectangle('Position',target_bb,'EdgeColor','g','LineWidth',2);

% depth image
s5 = subplot(4,4,4);
imshow(dep_raw);
hold on;
rectangle('Position',bb,'EdgeColor','y');
rectangle('Position',target_bb,'EdgeColor','g','LineWidth',2);

% depth distribution
s6 = subplot(4,4,[11,12,15,16]);

imhist(bb_content(dep_raw,bb));
% hold on;
% line([medD, medD],[0 max(max*histc(dep_raw,256))]);

% confidence map
s7 = subplot(4,4,8);
% conf_map = visualization_confidence_map (dmap, box, g, box_f, conf_dists );
% visualization_particle_box(target.box,'g',conf_map, g);
% hold on
% visualization_particle_box(box,'y',[],g);
% hold off

%information
str0 = sprintf('Particle # %i: (Press any key to load next particle)',no);
str1 = sprintf('RGB Hist Distance:  %10f',rgb_dist);
str2 = sprintf('D Median Distance:  %10f',dep_dist);
str3 = sprintf('D Median:           %10f',medD);
str4 = sprintf('Sum Log-Likelihood: %10f',likelihood);


annotation('textbox',...
    [0.13 0.01 0.775 0.095],...
    'String',{str0, str1,str2,str3,str4},...
    'LineWidth',2,...
    'BackgroundColor',[1 1 1],...
    'Color',[0.84 0.16 0]);
%     'FontSize',14,...
%     'FontName','Arial',...
%     'LineStyle','--',...
%     'EdgeColor',[1 1 0],...

% terminating
pause
annotation('textbox',...
    [0.13 0.01 0.775 0.095],...
    'String','Loading Next Particle Statistics, Please Wait A few Seconds...',...
    'LineWidth',2,...
    'BackgroundColor',[1 1 1],...
    'Color',[0 0 0]);
drawnow