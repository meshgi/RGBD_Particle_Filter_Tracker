function self = initialize_features (self, rgb_raw, video_name, init_bb)

for f = 1:size(self.fn,2)
    % create space for each feature
    self.feature{f}.name = self.fn{1,f};
    self.feature{f}.sim = self.sm{1,f};
    self.feature{f}.imp = self.imp(f);
    self.feature{f}.nrm = self.nrm(f);

    % global initilization of feature who needs it
    switch (self.fn{1,f})

        case 'HoC(RGB Clustering)'
            % color centers
            if ( self.rgb_bins_load )
                load (['bkg/' video_name '/rgb_ctr.mat']);
            else
                rgb_ctr = color_clustering (rgb_raw , self.rgb_clustering_samples, self.rgb_bins, init_bb);
                fld = ['bkg/' video_name];
                if (~exist(fld,'dir'))
                    mkdir(fld);
                end
                save([fld '/rgb_ctr.mat'],'rgb_ctr');
            end
            self.feature{f}.rgb_ctr = rgb_ctr;

        case 'HoC(Uniform)'
            m = self.rgb_bins;  % single color channel quantization
            q = linspace(1,255,m);
            rgb_ctr = setprod (q,q,q);
            self.feature{f}.rgb_ctr = rgb_ctr;

        case 'Grid Confidence (Beta)'

            % confidence measure
            rgb_cnf = 1; % to be loaded, or trained
            self.feature{f}.rgb_cnf = rgb_cnf;

    end
end