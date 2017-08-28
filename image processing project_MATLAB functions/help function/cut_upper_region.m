function [bw]=cut_upper_region(upper_region,bw)
% cut the upper region of bw
for xxx=1:65 
    bw(xxx,:)=0;
end