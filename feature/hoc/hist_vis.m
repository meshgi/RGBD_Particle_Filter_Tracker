function hist_vis (h, ctrs)

if (nargin == 0)
    % demo mode
    m = 4;  % single color channel quantization
    q = linspace(1,255,m);
    ctrs = setprod (q,q,q);
    h = 0.05:0.05/(m^3):0.1; h = h(1:end-1);
end

ctrs = floor(ctrs);

for i = 1:size(h,2)
    x = zeros(size(h));
    x(i) = h(i);
    bar(x,'FaceColor',ctrs(i,:)/255,'EdgeColor','none');
%     bar(x,'FaceColor',ctrs(i,:)/255); % show separating line
    hold on;
end

xlim([0 size(h,2)+1]);
ylim([0 0.1]);

hold off;