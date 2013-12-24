function d = dist_bhattacharyya ( h1 , h2 )

% http://docs.opencv.org/doc/tutorials/imgproc/histograms/histogram_compari
% son/histogram_comparison.html
% note that OpenCV formulation includes histogram normalization, which is
% done before in this implementation

d1 = sum(sqrt(h1.*h2));
d  = sqrt (1 - d1);
