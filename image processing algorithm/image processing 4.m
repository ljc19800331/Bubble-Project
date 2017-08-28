

clc
clear all
% week 4
imnoise

RGB=imread('4.png');
I=rgb2gray(RGB);
J=imnoise(I,'gaussian',0,0.005);
K=wiener2(J,[10,10]);
figure(1)
imshow(K)
figure(2)
imshow(J)
figure(3)
imshow(I)