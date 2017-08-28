% Find the width and length of the nozzle
clc
clear all
close all
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
sym f
i=1;
for a=2:799
    if bw(a,300)==1 && bw(a+1,300)==0    %since the above 
        f(i)=a;
        i=i+1;
    end
    if bw(a,300)==0 && bw(a+1,300)==1
        f(i)=a;
        i=i+1;
    end
end
f
nozzel_upper=f(1);
nozzel_lower=f(4);


%Classification of Vascular Anomalies using Continuous Doppler Ultrasound and Machine Learning


