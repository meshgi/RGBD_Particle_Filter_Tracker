function x = clip_range (x, R)

x = min(max(x,R(1)),R(2));