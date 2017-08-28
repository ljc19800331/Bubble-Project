firstimage = input('The first image is (1~1000)');
lastimage = input('The last image is (1~1000)');
deltaImg=1;                             
img_background=imread('ImgA000000.tif');
back2gray=rgb2gray(img_background); 
[m,n]=size(back2gray);
csu=0;