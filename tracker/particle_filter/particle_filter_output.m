function particle_filter_output (gt, self , vid_param, directory, num_frames, start)

fh = figure('toolbar','none','menubar','none','color','k','units','normalized','outerposition',[0 0 1 1],'name','Particle Visualization');

for fr = start:num_frames
    [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
    
end



% 
% fr = self.frame;
% if (fr > 1)
%     x = self.history;
%     
%     for i = 1:self.N
%         if (particle{i}.z == 0 )
%             dist_hoc(1,i) = particle{i}.dist(1) / self.nrm(1);
%             dist_medd(1,i) = particle{i}.dist(2) / self.nrm(2);
%         else
%             % if the particle is occluded no feature is calculated
%             dist_hoc(1,i) = NaN;
%             dist_medd(1,i) = NaN;
%         end
%         likelihood(1,i) = particle{i}.minus_log_likelihood;
%     end
%     x.dist_hoc(fr,:) = dist_hoc;
%     x.dist_medd(fr,:) = dist_medd;
%     x.likelihoods(fr,:) = likelihood;
%     x.probs(fr,:) = bb_prob;
% else
%     % first frame we have the bounding box, and everything is initialized,
%     % so there is no calculated features for the particles
%     x.dist_hoc(1,:) = Inf(1,self.N);
%     x.dist_medd(fr,:) = Inf(1,self.N);
%     x.likelihoods(fr,:) = zeros(1,self.N);
%     x.probs(fr,:) = zeros(1,self.N);
%     
% end
% 
% x.target(fr,:) = self.target;
% x.target_z(fr,:) = self.target_z;
% x.model_rgb_hist(fr,:) = self.model.cell.feature(1).val;
% x.model_med_depth(fr,:) = self.model.cell.feature(2).val;
% x.bbs(fr,:,:) = self.bbs;
% x.z(fr,:) = self.z;







% % for each frame
% color channel
% depth channel
% point cloud
% type of errors developing by time
% source of errors developing by time
% center point vs. time developing by time on the image
% precision plot (CPE developing by time)
% video event (event vs. time)  fill manual: http://stackoverflow.com/questions/6245626/matlab-filling-in-the-area-between-two-sets-of-data-lines-in-one-figure
% expected box color histogram
% expected box median of depth
% expected box feature distance to template by time
% all particles color coded
% occlusion candidates suspects
% stabilized frame
% stabilized feature
% all particles
