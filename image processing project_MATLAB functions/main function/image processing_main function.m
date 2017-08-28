%Notice, the first part is the set the document path to the image files
%Main function
clc
clear all
close all
%% Image preprocessing algorithm
%% Pre-processing
%firstimage=input('firstimage=');
%lastimage=input('lastimage=');

%Set the path for the result images
%path_in='D:\image_result_3\';
%saveas(gca,[path_in,num2str(1)],'jpg');

%begin the main function
firstimage=10;
lastimage=99;
delta=1;                                %The interval between each image, generally it is 1.
RGB_background=imread('ImgA000000.tif');
back2gray=rgb2gray(RGB_background);     %change background to grayscale (image new value=0.2989R+ 0.5870G + 0.1140B)
[m,n]=size(back2gray);
csu=0;  %Initial picture number
%% Process each image in the document

for k=firstimage:delta:lastimage
%k=1;
%csu=csu+1;
%define the picture regions  
if k>0 && k<10
        picture='ImgA00000';
end
if k>=10 && k<100
        picture='ImgA0000';
end    
if k>=100 && k<1000
        picture='ImgA000';
end    
filename=[picture,num2str(k),'.tif'];
Q{k}=imread(filename,'tif');  
RGB_original=Q{k};
%figure
%imshow(RGB_original);
origin2gray=rgb2gray(RGB_original);    
J1=imcomplement(back2gray);
J2=imcomplement(origin2gray);

%jianying algorithm(homogeneous background processing)
[J]=Jianying_algorithm(J1,J2,m,n);

%use the original image to cut the background image
RGB=imabsdiff(RGB_original,RGB_background);
I=rgb2gray(RGB);
%[g]=filling_algorithm(I,m,n);
RGB_imfill=imfill(I);
J=mat2gray(RGB_imfill);

SE=strel('disk',2);  
J1=imopen(J,SE);   
J1=imfill(J1,'holes'); 

level=graythresh(J1);
BW=im2bw(J1,level);
BW1=imfill(BW,'holes');
bub{k}=BW1;

%Edge detection
%BW2=bwperim(BW1);
BW2=edge(BW1,'canny');

%Cut the regions
[nozzel_upper_row,nozzel_upper_column]=nozzle_diameter();
%Cut for bw2
[BW2]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW2);
upper_region=65;   %define the upper region freshold is 65
[BW2]=cut_upper_region(upper_region,BW2);
%Cut for bw1
[BW1]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW1);
[BW1]=cut_upper_region(upper_region,BW1);

%Calculate the parameter of the bubble

%label the matrix
[L,num]=bwlabel(BW1,8);


%design a function first to cut the noise region
%[L_cutsmall,num_change]=bubble_cut_smallregion(L,num);
%num=num_change;
%L=L_cutsmall;




%% 

%label the matrix with order(based on the barycenter and cut the small
%noise region)

%label the matrix with order (based on the bottom and top line)
%[L_order,Cell_1,Cell_2,m2]=bubble_bwlabel_order(L,num,m,n);
%L=L_order;


%Another function to make the label matrix in order
%Calculate the barycenter and area of the labeled matrix
[bary_xonly]=barycenter_for_xonly(L,num,m,n);

plot_xonly_0{k}=bary_xonly;


%cut the noise small region
[L_cutsmall,num_change]=bubble_cut_smallregion(L,num,k,plot_xonly_0);   
L=L_cutsmall;
num=num_change;

%again
[L,num]=bwlabel(L,8);
[bary_xonly]=barycenter_for_xonly(L,num,m,n);
plot_xonly{k}=bary_xonly;


%
[L_order_1,Cell_3]=bubble_order_barycenter_cutnoiseregion(L,plot_xonly,k,num,m,n);  %%the problem is here
L=L_order_1;


%Calculate the barycenter and area of the labeled matrix
[x_bary,y_bary,plot_area]=barycenter_recregion_area(L,num,m,n);     

plot_x{k}=x_bary;

plot_y{k}=y_bary;

area{k}=plot_area;



%define a function that can only calculate the barycenter of plot_x(maybe
%not necessary)

%num=num_change;
%figure
%imshow(L_order_1);



%Calculate the region of the labeled matrix
[min_row,max_row,min_column,max_column]=rectangle_region(L,num,m,n);             %%%

mini_row{k}=min_row;

maxi_row{k}=max_row;

mini_column{k}=min_column;

maxi_column{k}=max_column;

%Separate the bubbles
%[bw_separate]=bubble_separate(L,num,m,n);
%BW_separate{k}
[bw_separate]=bubble_separate(L,num,m,n);
BW_separate{k}=bw_separate;
%we want the first bubble
bubble_first=2;

bw_first=cell2mat(BW_separate{k}(1,bubble_first));
figure
imshow(bw_first);
%plot the barycenter of the first bubble, we can define as the function
hold on
plot(plot_y{k}(1,bubble_first) ,plot_x{k}(1,bubble_first),'*');

%Find the penetration depth, the first bubble
[d_penetration]=bubble_penetration_depth(bw_first,k);
d_penetratoin{k}=nozzel_upper_column-d_penetration;

%Find the departure frequency   method: contruct a region of the nozzel
%which can identify the difference between bubble and nozzel
%pending  one of the method is to find the connected region of the image

%Find the velocity of the bubbles
t_image_frequency=0.01;    %0.01 second, self defined
image_bubble=1;      %I want to find the velocity of the first bubble
[d_relative, b_velocity]=bubble_velocity(plot_x,plot_y,image_bubble,k,t_image_frequency,bubble_first,firstimage);    %%%
D_relative_firstbubble{k}=d_relative;     % The k image, the distance of the first bubble
B_velocity_firstbubble{k}=b_velocity;     % The k image, the velocity of the first bubble

%the rec region plot function
%figure
%imshow(L);

%Save the BW1 images to the cell array
BW1_allimages{k}=BW1;

plot_region_barycenter(k,num,plot_x,plot_y,mini_row,maxi_row,mini_column,maxi_column,nozzel_upper_row,nozzel_upper_column);

%figure
%imshow(bw_first);
%saveas(gca,[path_in,num2str(k)],'jpg');     %important save file, gca
%means the current figure
end
%% 

%Find(Plot) the trajectory of the bubbles 
%i=k;
%for k=1:i
plot_trajectory_firstbubble(plot_x,plot_y,k,m,n,bubble_first,firstimage);
%end

%Write all the images as the video
fps=24;
bubble_video(firstimage,lastimage,fps);




