function [rgb_msk, dep_msk] = bkg_subtraction ( method , rgb_raw, dep_raw, rgb_bkg , dep_bkg)

switch (method)
    case 'none'
        rgb_msk = ones(size(rgb_msk));
        dep_msk = ones(size(dep_msk));
    case 'thresholding'
        [rgb_msk, dep_msk] = bkg_subtraction_thresholding ( rgb_raw, dep_raw, rgb_bkg , dep_bkg);
end