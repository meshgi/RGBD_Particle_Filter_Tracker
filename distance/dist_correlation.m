function d = dist_correlation ( h1 , h2 )

h1_m = mean (h1);
h2_m = mean (h2);

d_enu = (h1-h1_m)*(h2-h2_m)';
d_den = sqrt(((h1-h1_m)*(h1-h1_m)')*((h2-h2_m)*(h2-h2_m)'));

if (d_den ~=0)
    d = d_enu / d_den;
else
    d = inf;
    disp ('Singularity problem: one of the histograms is zero or uniform');
end