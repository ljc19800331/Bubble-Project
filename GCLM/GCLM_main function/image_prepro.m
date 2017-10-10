% Texture analysis for image processing methods

clc
clear all
close all

firstimage=1;
lastimage=1;
delta=1;                                
RGB_background=imread('ImgA000000.tif');
back2gray=rgb2gray(RGB_background);     
[m,n]=size(back2gray);
csu=0;  

k=10;
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

origin2gray=rgb2gray(RGB_original);    
J1=imcomplement(back2gray);
J2=imcomplement(origin2gray);


[J]=Jianying_algorithm(J1,J2,m,n);

RGB=imabsdiff(RGB_original,RGB_background);
I=rgb2gray(RGB);
RGB_imfill=imfill(I);
J=mat2gray(RGB_imfill);

SE=strel('disk',2);  
J1=imopen(J,SE);   
J1=imfill(J1,'holes'); 

level=graythresh(J1);
BW=im2bw(J1,level);
BW1=imfill(BW,'holes');
bub{k}=BW1;

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

L=BW1;
imshow(L);
%% 