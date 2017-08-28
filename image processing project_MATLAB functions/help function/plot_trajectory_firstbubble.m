function []=plot_trajectory_firstbubble(plot_x,plot_y,k,m,n,bubble_first,firstimage)

%Plot the trajectory of the bubble

bw_trajectory=logical(zeros(m,n));
figure
imshow(bw_trajectory);
i=k;

for k=firstimage:i

hold on
plot(plot_y{k}(1,bubble_first) ,plot_x{k}(1,bubble_first),'*');
hold on

if k~=firstimage
%The current position    
x_cord_k=plot_x{k}(1,bubble_first); 
y_cord_k=plot_y{k}(1,bubble_first);
%The previous position
x_cord_kminus1=plot_x{k-1}(1,bubble_first); 
y_cord_kminus1=plot_y{k-1}(1,bubble_first);

hold on
line([y_cord_k,y_cord_kminus1],[x_cord_k,x_cord_kminus1]);
hold on
end


end











