%suggestion from the TA
%1.histogram 
%histogram(I(:))
%hist(I(:))
%histogram(I(:))
%histogram(double(I(:)))
%hist(double(I(:)))
%imshow(I)
clc
clear all
firstimage=1;
lastimage=1;
deta=1;
RGB1=imread('ImgA000000.tif');    %background image
%I=imshow(RGB1);
I1=rgb2gray(RGB1);          %change color image to gray image
figure(1);imshow(I1);       % first, the background grayscale image
[m,n]=size(I1); 
duke=0;                     %the number of picture
for k=firstimage:deta:lastimage
    duke=duke+1;
    filename=['ImgA00000',num2str(k),'.tif'];
    Q{k}=imread(filename,'tif');
    RGB2=Q{k};
    I2=rgb2gray(RGB2);
    figure(2);imshow(I2);   % second, the original grayscale image
    J1=imcomplement(I1);    % 255-(pixel value) make bubble become black and background becomes white
    figure(3);imshow(J1);   % third, the imcomplexment images, make the background become more obvious
    J2=imcomplement(I2);     
    figure(4);imshow(J2);   % the same as before
    RGB=imabsdiff(RGB2,RGB1);   % cut the background, to make the difference more obvious(for the bubble part)
    I=rgb2gray(RGB);
    figure(5);imshow(I);    
    f0=0;g0=0;              % 
    f1=20;g1=100;
    f2=100;g2=180;
    f3=255;g3=255;
    r1=(g1-g0)/(f1-f0);
    b1=g0-r1*f0;
    r2=(g2-g1)/(f2-f1);
    b2=g1-r2*f1;
    r3=(g3-g2)/(f3-f2);
    b3=g2-r3*f2;                                % image padding/image completion
    X2=double(I);                               % change I to double
    for i=1:m
        for j=1:n
        f=X2(i,j);
        g(i,j)=0;
          if(f>=0)&(f<=f1)     % f between 0 and 20
          g(i,j)=r1*f+b1;
          elseif(f>=f1)&(f<=f2)  % f between 20 and 100
          g(i,j)=r2*f+b2;
          elseif(f>=f2)&(f<=f3)  % f between 100 and 255
          g(i,j)=r3*f+b3;
          end
        end
    end
J=mat2gray(g);                             % convert matrix to grayscale, from 0-1
figure(6);imshow(J);                          % the fourth image, show a clear white-black image
end












