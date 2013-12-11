function [x,y] = rect_span (box)
x = box(2):box(2)+box(4);
y = box(1):box(1)+box(3);