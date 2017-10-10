clc;clear all;close all
%% Preprocessing
PreProcess_background;
%% Main function
for k=firstimage:deltaImg:lastimage      
    
%% PreProcess each image in the document
PreProcess;

%% use the original image to cut the background image -- To make the shape clear
RGB = imabsdiff(RGB_original,img_background);
I = rgb2gray(RGB);

%% Filling and edge detection
% Output: BW1 -- original image, BW2 -- edge detection image
FillandEdge;

%% Cut the noisy regions for the image and remain only the bubble shapes
RemoveNoiseRegion;

%% Label the bubble image
% Output -- L: the labeled matrix image
LabelMatrix;

%% Calculate the barycenter and area of the labeled matrix
[x_bary,y_bary,plot_area]=barycenter_recregion_area(L,num,m,n);     
plot_x{k}=x_bary;
plot_y{k}=y_bary;
area{k}=plot_area;

%% Calculate the region of the labeled matrix
[min_row,max_row,min_column,max_column]=rectangle_region(L,num,m,n);         
mini_row{k}=min_row;
maxi_row{k}=max_row;
mini_column{k}=min_column;
maxi_column{k}=max_column;

%% Separate the bubbles
[bw_separate]=bubble_separate(L,num,m,n);
BW_separate{k}=bw_separate;

% we want the first bubble
bubble_first = input('Which bubble do you want? ');
bw_first=cell2mat(BW_separate{k}(1,bubble_first));
figure
imshow(bw_first);
% plot the barycenter of the first bubble, we can define as the function
hold on
plot(plot_y{k}(1,bubble_first) ,plot_x{k}(1,bubble_first),'*');

%Find the penetration depth, the first bubble
[d_penetration] = bubble_penetration_depth(bw_first,k);
d_penetratoin{k} = nozzel_upper_column-d_penetration;

%Find the velocity of the bubbles
t_image_frequency=0.01;    %0.01 second, self-defined
image_bubble=1;            %I want to find the velocity of the first bubble
[d_relative, b_velocity]=bubble_velocity(plot_x,plot_y,image_bubble,k,t_image_frequency,bubble_first,firstimage);    %%%
D_relative_firstbubble{k}=d_relative;     % The k image, the distance of the first bubble
B_velocity_firstbubble{k}=b_velocity;     % The k image, the velocity of the first bubble

% Save the BW1 images to the cell array
BW1_allimages{k}=BW1;

% plot the regions
plot_region_barycenter(k,num,plot_x,plot_y,mini_row,maxi_row,mini_column,maxi_column,nozzel_upper_row,nozzel_upper_column);
end

%% plot the trajectory of the first bubble
% plot_trajectory_firstbubble(plot_x,plot_y,k,m,n,bubble_first,firstimage);

%% Write all the images as the video
% fps=24;
% bubble_video(firstimage,lastimage,fps);
