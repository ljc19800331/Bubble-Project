function [L_cutsmall,num_change]=bubble_cut_smallregion(L,num,k,plot_xonly_0)

for i=1:num
[r,c]=find(L==i);
csu=size(r);
row_1(i)=csu(1,1);      %row is the size of the region
end
[x_value,y_position]=min(row_1);
%find the barycenter and the region of the noise region

num_change=num;
%clear the small region
if x_value<100 && plot_xonly_0{k}(1,y_position)<600
    num_change=num-1;   %change the num to another one (cut the small region and the label will change)
[r,c]=find(L==y_position);
for i=1:length(r)
    L( r(i), c(i) )=0;
end
end
L_cutsmall=L;