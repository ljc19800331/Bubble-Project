function [nozzel_upper_row,nozzel_upper_column] = nozzle_diameter()
% Find the width and length of the nozzle


%clc
%clear all
%close all
RGB_b=imread('ImgA000000.tif'); % background image
%figure 
%imshow(RGB_b);
l1=rgb2gray(RGB_b);
%x2=double(l1); 
%figure 
%imshow(l1);
level=graythresh(l1);
bw=im2bw(l1,0.54);
%figure
%imshow(bw);
[l,w]=size(bw);
sym f;
i=1;
for a=2:799
    if bw(a,300)==1 && bw(a+1,300)==0    %since the above 
        f_row(i)=a;
        i=i+1;
    end
    if bw(a,300)==0 && bw(a+1,300)==1
        f_row(i)=a;
        i=i+1;
    end
end
f_row;
nozzel_upper_row=f_row(1);
nozzel_lower_row=f_row(4);
nozzel_upper_column=189;

%Find the upper and lower column

  
%sym row_max
%for i=nozzel_upper_row:1:nozzel_lower_row
    %find(bw(710,:),150,'last'); 
%    r=max(  find(bw(i,:),150,'last')  );
%    row_max(i)=r;
%end
%    max(row_max)
%    nozzel_upper_column=max(row_max)






