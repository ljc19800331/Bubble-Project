% Try function
% Try different algorithms
%Function to find the area of all the objects in a picture
%Binary process for the image
clc
clear all
close all
BW=imread('ImgA000001.tif');
BW1=rgb2gray(BW);
figure
imshow(BW1);
[m,n]=size(BW1);
for i=1:m
    for j=1:n
        if(BW1(i,j,1)>=100)
            BW1(i,j,1)=0;
        else
            BW1(i,j,1)=1;
        end
    end
end
figure
imshow(BW1);
total=bwarea(BW1);
[L,num]=bwlabel(BW1,8);
STATS=regionprops(BW1, 'Area');
STATS1=regionprops(L, 'Area');
STATS2=regionprops(L, 'Extrema');

%Draw a circle with the  or the specific point
clc
clear all
close all
i=imshow('ImgA000001.tif');
hold on 
x1=160;
y1=160;
plot(x1,y1,'o','Markersize',5);
title('click on a point! here!');
p =ginput(1);
hold all;
plot(p(1),p(2),'.','markersize',20);

%Find the center point with our algorithms
clear;
clc;
close all;  
I=imread('ImgA000001.tif');%?????  
figure(1);imshow(I);%?????  
  
I_gray=rgb2gray(I);%?????????  
level=graythresh(I_gray);%????I_gray??????level????????????[0 1]  
[height,width]=size(I_gray);%?????????  
I_bw=im2bw(I_gray,level);%im2bw????level?????????????  
figure(2);imshow(I_bw);%?????????????

for i=1:height %%???????  
    for j=1:width     
        if I_bw(i,j)==1        
            I_bw(i,j)=0;    
        else I_bw(i,j)=1;   
        end  
    end  
end  
figure(3);imshow(I_bw);%?????????????????

[L,num]=bwlabel(I_bw,8);%bwlabel??????I_bw???????????????I_bw????????num????????  
plot_x=zeros(1,num);%%zeros(m,n)??m×n??0???????????????  
plot_y=zeros(1,num);%zeros(m,n)??m×n??0??????????????? 
plot_area=zeros(1,num); %zeros(m,n)??mxn??0???????????????

for k=1:num  %%num???????????      
    sum_x=0;    sum_y=0;    area=0; %???  
    for i=1:height     
        for j=1:width   
            if L(i,j)==k       
                sum_x=sum_x+i;  %????????????  
                sum_y=sum_y+j;  %????????????   
                area=area+1;    %????????????????  
            end  
        end  
    end  
    plot_x(k)=fix(sum_x/area);  %????????????  
    plot_y(k)=fix(sum_y/area);%????????????  
    plot_area(k)=area;
end
figure(4);imshow(I_bw);%?????????????????,???????????  
for i=1:num  
    hold  on  
    plot(plot_y(i) ,plot_x(i), '*');  
    j=num2str(i);
    text(plot_y(i),plot_x(i),j);
end 


for j=1:num
max(  mod   (    find(L==j),  size(L,1)     )        )     %mod yushu

BW = logical ([1     1     1     0     0     0     0     0
               1     1     1     0     1     1     0     0
               1     1     1     0     1     1     0     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     0     1     0
               1     1     1     0     0     1     1     0
               1     1     1     0     0     0     0     0]);

L = bwlabel(BW,4)


clc
clear all
L =([
     1     1     1     0     0     0     0     
     1     1     1     0     2     2     0     
     1     1     1     0     2     2     0     
     1     1     1     0     0     0     3     
     1     1     1     0     0     0     3     
     1     1     1     0     0     0     3     
     1     1     1     0     0     3     3     
     1     1     1     0     0     0     0     ]);
 
row=  mod(  find(L==7),  size(L,1)         );
%column= mod( find(L==7),size(L,2)    );
%max row
max_row=max(  mod(  find(L==7),  size(L,1)         )     );
if max_row==size(L,1)-1;
    max_row=max_row+1;
end
max_row
%min row
min_row=min(       mod(  find(L==7),size(L,1))       )
if min_row==0
    min_row=1;
end
%max column
max_column= max( ceil( find(L==7)/size(L,1)     )              )
%min column
min_column= min( ceil( find(L==7)/size(L,1)    ) )


%Draw the retangle window
figure(5);imshow(I_bw);
hold on
x1=[min_row,min_row,max_row,max_row];
y1=[min_column,max_column,max_column,min_column];
%plot(x1,y1,'o')
line([min_row,min_row],[min_column,max_column])   %1-2
line([min_row,max_row],[max_column,max_column])   %2-3
line([max_row,max_row],[max_column,min_column])   %3-4
line([max_row,min_row],[min_column,min_column])   %3-4

x=[1 2 3 4];
y=[5 6 7 8];
line([1,3],[5,7])

a1 = [min_row,min_column];    %// ?????
a2 = [min_row,max_column];    %// ?????
a3 = [max_row,max_column];    %// ?????
a4 = [max_row,min_column];    %// ?????
plot(a1,'o');
hold on
plot(a2,'o');
hold on
plot(a3,'o');
hold on
plot(a4,'o');
hold on

line(a1, a2);   %// ????
hold on
line(a2, a3);  % // ????
hold on
line(a3, a4);   %// ????
hold on
line(a4, a1); %  // ????



hold on
w=max_column-min_column;
h=max_row-min_row;
rec=rectangle('position',[max_row,min_column,w,h])
plot(rec);










%Another method to detect the edge
clc
clear all
close all
url='ImgA000001.tif';
img=imread(url);
hsv=rgb2hsv(img);
s=hsv(:,:,2);
bw=im2bw(s,graythresh(s));
se=strel('disk',5);
bw2=imclose(bw,se);
bw3=bwareaopen(bw2,200);
imshow(bw3)

















