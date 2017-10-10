%Image processing algorithm-calculate the area of the bubble
%pre-processing and find the edge detection of the bubble
%find the coefficient matrix after binary 
%calculate number of zero value
%% First, preprocessing and find the coefficient matrix
clc
clear all
close all
%% 
sc=6/30; % compression coefficient
firstimage=1;  % The first image
lastimage=1;   % The last image
deta=1; 
RGB_b=imread('ImgA000000.tif'); % background image
l1=rgb2gray(RGB_b);   % change background to grayscale (image new value=0.2989R+ 0.5870G + 0.1140B)
[m,n]=size(l1);  
csu=0;   % Initial the picture numbers
%% Find the width and length of the nozzle
%q1=double
%Define a main function
for k=firstimage:deta:lastimage
    csu=csu+1;
    filename=['ImgA00000',num2str(k),'.tif'];   % show that the image are ImgA0000+the number of picture+'.tif', here k is str not a number
    Q{k}=imread(filename,'tif');   %read the image 
    RGB_1=Q{k};    % original image
    l2=rgb2gray(RGB_1);   % change to grayscale
    J1=imcomplement(l1);  % background image 255-pixel
    J2=imcomplement(l2);  % original image 255-pixel 
    for i=1:m
        for j=1:n
            if J2(i,j)-J1(i,j)>1
            J(i,j)=J2(i,j)-J1(i,j); % jianying algorithm
            else
            J(i,j)=0;
            end
        end
    end      
%I=J;  % I here is the J matrix
RGB=imabsdiff(RGB_1,RGB_b);  % original image-background image
I=rgb2gray(RGB);   % change to grayscale
%% filling processing    here I is  RGB image
f0=0;g0=0;
f1=20;g1=100;
f2=100;g2=180;
f3=255;g3=255;
r1=(g1-g0)/(f1-f0);
b1=g0-r1*f0;
r2=(g2-g1)/(f2-f1);
b2=g1-r2*f1;
r3=(g3-g2)/(f3-f2);
b3=g2-r3*f2; 
%filling 
X2=double(I);   %change I from unit 8 to double
for i=1:m      %here the g matrix is used in this problem
    for j=1:n
        f=X2(i,j);
        g(i,j)=0;
        if(f>=0)&(f<=1)
            g(i,j)=r1*f+b1;
        elseif(f>=f1)&(f<=f2)
            g(i,j)=r2*f+b2;
            elseif(f>=f2)&(f<=f3) 
            g(i,j)=r3*f+b3;       
        end
     end
end
J=mat2gray(g);   %enhance the grayscale; I = mat2gray(A) sets the values of amin and amax to the minimum and maximum values in A.
SE=strel('disk',2);
J1=imopen(J,SE);    % cut some of the small regions
J1=imfill(J1,'holes'); % fill image regions and holes
%J1=imfill(J1,'holes');
level=graythresh(J1);  % find the suitable threshold for the problem
BW=im2bw(J1,0.57);   % binary process
BW1=imfill(BW,'holes');  % imfill the process
BW2=bwperim(BW1);    % The image that can be used
bub{k}=BW1;          % put the value of BW1 to bub{k}
%% BW2
[n_upper,u_lower]=nozzle_diameter();

for sss=n_upper:800 % cut the nozzle of BW2
    BW2(sss,:)=0;
end
for xxx=1:65 % cut the upper region of BW2
BW2(xxx,:)=0;
end

Len(k,:)=bwarea(BW2)*sc; %calculte the area of all the objects
l3=BW1;    % The processed image


for sss=n_upper:800  % cut the nozzel of BW1
    l3(sss,:)=0; 
end
for xxx=1:65
    l3(xxx,:)=0;
end


A(k,:)=bwarea(l3)*sc*sc; %????????mm2
d(k,:)=sqrt(4*A(k)/pi)-sc*2; %??????,??????????mm
[L,num]=bwlabel(BW1,8);
j=0;
for i=676:678      %?????676 ???678 ???????
j=j+1;
find(L(i,:))~=0   %To find the penetration depth by definition
if isempty(find(L(i,:)~=0))
M(csu,j)=0;
N(csu,j)=0;
else
[row,col]=find(L(i,:)~=0);
M(csu,j)=min(col); %On the left
N(csu,j)=max(col); %On the right
end
end
end
% 1.??
% 2.????????????
% regionprops
% image segamentation 



