function [d_penetration]=bubble_penetration_depth(bw_first,k)

%Find the penetration depth
%The penetration depth defined for this problem is the longest distance for
%the first bubble

[r,c]=find(bw_first);
d_penetration=min(c);


