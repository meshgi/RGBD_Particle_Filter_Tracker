function model = model_update ( method , old_model , new_model , tracker )

    switch (method)
        case 'none'
            model = old_model;
        case 'moving_average'
            a = tracker.target_update_forgetting_rate;
%             model = (1/1+a)*(new_model + a * old_model); % TO BE REVISED,
%             IT'S JUST THE CONCEPT
            
            for f = 1:size(tracker.feature,2)
                switch (tracker.feature{f}.name)

                    case {'HoC(RGB Clustering)','HoC(Uniform)','medD'}
                        x.cell(1,1).feature(f).val = (1/(1+a))*(new_model.cell(1,1).feature(f).val + a*old_model.cell(1,1).feature(f).val);    

                    case 'HoC (RGB Clustering,Grid2)'
                        g = 2;
                        for i = 1:g
                            for j = 1:g
                                x.cell(i,j).feature(f).val = (1/(1+a))*(new_model.cell(i,j).feature(f).val + a*old_model.cell(i,j).feature(f).val);   
                            end
                        end

                    case 'Grid Confidence (Beta)'
                        for i = 1:g
                            for j = 1:g
                                x.cell(i,j).feature(f).val  = 1; %pdf(prior_dist(i,j),f.cell(i,j).fg_ratio);
                            end
                        end

                end
                
                
                
                
            end
            model = x;
                
        case 'last_5'
            % enqueue new model
            % dequeue 5th model
            % average all of them
        case 'learning'
        case 'kalman'
        case 'grid_based'
    end

end