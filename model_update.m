function model = model_update ( method , old_model , new_model , tracker )

    switch (method)
        case 'none'
            model = old_model;
        case 'moving_average'
            a = tracker.target_update_forgetting_rate;
%             model = a * new_model + (1-a) * old_model; % TO BE REVISED,
%             IT'S JUST THE CONCEPT
        case 'last_5'
            % enqueue new model
            % dequeue 5th model
            % average all of them
        case 'learning'
        case 'kalman'
        case 'grid_based'
    end

end