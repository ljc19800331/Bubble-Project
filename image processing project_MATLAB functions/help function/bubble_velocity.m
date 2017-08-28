function [d_relative, b_velocity]=bubble_velocity(plot_x,plot_y,image_bubble,k,t_image_frequency,bubble_first,firstimage)

%I want to find the velocity of the first bubble, here is the function of
%image_bubble variable
d_relative=0;
if k~=firstimage
d_relative=sqrt(   ( plot_x{k}(1,bubble_first)-plot_x{k-1}(1,bubble_first)  ).^2+    ( plot_y{k}(1,bubble_first)-plot_y{k-1}(1,bubble_first)  ).^2       );
%d_relative=1;
end
%D_relative{k}=d_relative;
b_velocity=d_relative/t_image_frequency;
%B_velocity{k}=b_velocity;