
%image processing week 5


%Hough transform
clc
clear all
I=imread('try_1.tif');
I=rgb2gray(I);
rotI=imrotate(I,33,'crop');
DW=edge(rotI,'canny');   %detect the edge
[H,T,R]=hough(DW);       %hough transform
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P= houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));   %maximum operator
x=T(P(:,2));
y=R(P(:,1));
plot(x,y,'s','color','white');

% Find lines and plot them
lines=houghlines(DW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(rotI), hold on 
max_len=0;
for k=1:length(lines)
    xy=[lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    %plot begining and end of lines 
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    %determine the endpoints of the longest line segment
    len=norm(lines(k).point1-lines(k).point2);
    if(len>max_len)
        max_len=len;
        xy_long=xy;
    end
end

%Otsus transform
clc
clear all
I=imread('4.png');
level=graythresh(I);
BW=im2bw(I,level);
figure,imshow(I),
figure,imshow(BW),
figure,imhist(I)