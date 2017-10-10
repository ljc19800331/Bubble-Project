%labelling the bubble in order (from bottom to top) 
clc
clear all
close all

%% 
%Read the background image
RGB_background=imread('ImgA000000.tif');
back2gray=rgb2gray(RGB_background);     
[m,n]=size(back2gray);
k=1;

%% 
%image pre-processing
filename=['ImgA00000',num2str(k),'.tif'];     %%you can change the path here
Q{k}=imread(filename,'tif');  
RGB_original=Q{k};
origin2gray=rgb2gray(RGB_original);    
J1=imcomplement(back2gray);
J2=imcomplement(origin2gray);

%jianying algorithm(homogeneous background processing)
[J]=Jianying_algorithm(J1,J2,m,n);

%use the original image to cut the background image
RGB=imabsdiff(RGB_original,RGB_background);
I=rgb2gray(RGB);
RGB_imfill=imfill(I);
J=mat2gray(RGB_imfill);

%imfill the image
SE=strel('disk',2);  
J1=imopen(J,SE);   
J1=imfill(J1,'holes'); 

level=graythresh(J1);
BW=im2bw(J1,level);
BW1=imfill(BW,'holes');
bub{k}=BW1;

%Edge detection(with canny algorithm)
BW2=edge(BW1,'canny');

%Cut the regions(including the nozzel, and the upper noise region, you can
%see the difference by imshowing the images)
[nozzel_upper_row,nozzel_upper_column]=nozzle_diameter();
%Cut for bw2
[BW2]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW2);
upper_region=65;   %define the upper region freshold is 65
[BW2]=cut_upper_region(upper_region,BW2);
%Cut for bw1
[BW1]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW1);
[BW1]=cut_upper_region(upper_region,BW1);

%% 
%Calculate the parameter of the bubble
%label the matrix (with bwlabel function)
[L,num]=bwlabel(BW1,8);

%label the matrix with order
[L_order,Cell_1,Cell_2]=bubble_bwlabel_order(L,num,m,n);
L=L_order; %here, L is the label matrix (in order)











%% This part is for visualizing the matrix in order, it is helpful for understanding my algorithm

%Calculate the barycenter and area of the labeled matrix
[x_bary,y_bary,plot_area]=barycenter_recregion_area(L,num,m,n);

plot_x{k}=x_bary;

plot_y{k}=y_bary;

area{k}=plot_area;

%Calculate the region of the labeled matrix
[min_row,max_row,min_column,max_column]=rectangle_region(L,num,m,n);     

mini_row{k}=min_row;

maxi_row{k}=max_row;

mini_column{k}=min_column;

maxi_column{k}=max_column;

%Separate the bubbles
[bw_separate]=bubble_separate(L,num,m,n);
BW_separate{k}=bw_separate;
bubble_first=1;    %we want the first bubble
bw_first=cell2mat(BW_separate{k}(1,bubble_first));

%plot the barycenter of the first bubble, we can define as the function
hold on
plot(plot_y{k}(1,bubble_first) ,plot_x{k}(1,bubble_first),'*');

%the rec region plot function
figure
imshow(BW1);

plot_region_barycenter(k,num,plot_x,plot_y,mini_row,maxi_row,mini_column,maxi_column,nozzel_upper_row,nozzel_upper_column);

%% 











