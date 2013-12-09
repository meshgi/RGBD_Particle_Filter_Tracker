function c = box_confidence (mask)

c = sum(sum(mask == 1));                                                    % number of fg pixels

if (c == 0)                                                                 % handles zero fg pixel case
    c = 1;
end

c = c / (numel(mask)+eps);                                                   % divided by number of all pixels in roi