%% label the matrix
[L,num]=bwlabel(BW1,8);
%% Barycenter
% L is the image matrix with the labeled number
% Calculate the barycenter and area of the labeled matrix
[bary_xonly] = barycenter_for_xonly(L,num,m,n);
plot_xonly_0{k}=bary_xonly;
%% cut the noise small region
[L_cutsmall,num_change] = bubble_cut_smallregion(L,num,k,plot_xonly_0);   
L = L_cutsmall;
num = num_change;
%% Go again for the previous process and relabel the matrix
[L,num]=bwlabel(L,8);
[bary_xonly]=barycenter_for_xonly(L,num,m,n);
plot_xonly{k}=bary_xonly;

%
[L_order_1,Cell_3]=bubble_order_barycenter_cutnoiseregion(L,plot_xonly,k,num,m,n);  %%the problem is here
L=L_order_1;