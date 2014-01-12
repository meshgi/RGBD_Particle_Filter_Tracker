function trackers =  trackers_train ( train_videos , trackers , control )
%TRACKER_TRAIN Train tracker parameters with annotated dataset
%   This function let all of the trackers to tune up their parameters with
%   the given videos and annotated tracking box.
%
%   code by: Kourosh Meshgi, Oct 2013
%   https://github.com/meshgi/RGBD_Particle_Filter_Tracker

    if (~ control.enable_learning)
        return;
    end
     
    self = trackers{4};
    k = 0;
    for vid = 1:size(train_videos,2)
        [vid_param, directory, num_frames, cam_param, grt, init_bb]   = video_info(train_videos{vid});

        % background detection
        if ( self.bkg_det_load )
            load (['bkg/' train_videos{vid} '/rgb_bkg.mat']);
            load (['bkg/' train_videos{vid} '/dep_bkg.mat']);
        else
            [rgb_bkg,dep_bkg] = offline_bkg_detection ( self.bkg_det, train_videos{vid} , self.bkg_det_samples );
            fld = ['bkg/' train_videos{vid}];
            if (~exist(fld,'dir'))
                mkdir(fld);
            end
            save([fld '/rgb_bkg.mat'],'rgb_bkg');
            save([fld '/dep_bkg.mat'],'dep_bkg');    
        end
        
        % if initialization method is not 'file' then initialize it!!!!
        for fr = control.start_frame:num_frames
            [rgb_raw, dep_raw] =  read_frame(vid_param, directory, fr);
            [rgb_msk, dep_msk] = bkg_subtraction ( self.bkg_sub , rgb_raw, dep_raw, rgb_bkg , dep_bkg);
            bb = grt(1:4,fr);
            
            if (isnan(bb(1)))
                continue;
            end

            bb(3) = min(bb(3)+bb(1),size(rgb_raw,2))-bb(1);
            bb(4) = min(bb(4)+bb(2),size(rgb_raw,1))-bb(2);

            [k , bb(4)+bb(2), bb(3)+bb(1)]
            
            k = k + 1;
            batch_data{k}.bb_rgb = bb_content(rgb_raw,bb);
            batch_data{k}.bb_dep = bb_content(dep_raw,bb);
            batch_data{k}.bb_msk = bb_content(rgb_msk,bb);
            
        end
    end
    
    

    for tr = 1:length(trackers)
        % give tracker input data, without ground truth and save the
        % results


        trackers{tr}.status = 'train';
        switch trackers{tr}.type
            case 'particle_filter'
                trackers{tr} = particle_filter_train ( trackers{tr}, batch_data );
        end
    end

    
end %======================================================================