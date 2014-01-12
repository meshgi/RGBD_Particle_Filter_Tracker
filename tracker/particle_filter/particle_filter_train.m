function self = particle_filter_train ( self , bd )

% background detection
if ( ~ self.cell_conf_load  )
    
    for k = 1:length(bd) 
        for i = 1:self.g
            for j = 1:self.g
                bb = bb_grid ([1,1,size(bd.bb_msk{k},1),size(bd.bb_msk{k},2)],self.g,i,j);
                fg      = sum(sum(bb_content(bd.bb_msk{k} , bb)));
                ratio(k,i,j) = fg / numel(bb_content(bd.bb_msk{k} , bb));
            end
        end
    end
                
    
    for i = 1:self.g
        for j = 1:self.g
            x = ratio(:,i,j);
            pd((i-1)*self.g+j) = fitdist(x,'Beta');
        end
    end
    pd = reshape(pd',self.g,self.g);
    
    filename = ['tracker/particle_filter/beta_dist_cells_' num2str(self.g) 'x' num2str(self.g) '1.mat'];

    save(filename,'pd');
end

