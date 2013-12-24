function d = dist_chisquare ( h1 , h2 )

d_item = ( h1 - h2 ).^2 ./ h1;
d_item(isnan(d_item) | isinf(d_item)) = 0;
d = sum(d_item);