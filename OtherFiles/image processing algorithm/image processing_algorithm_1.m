clc
clear all
sc=6/30;                               %
firstimage=1;                            % The number of first image
lastimage=1;                             % The number of last image
deta=1;                                     % The data
RGB1=imread('ImgA000000.tif');                  % read the first image 
I1=rgb2gray(RGB1);                               % change the image to gray scale, maybe it is the background image
[m,n]=size(I1);                                  % the size of I1
csu=0;                                         %  
for k=firstimage:deta:lastimage;
    csu=csu+1;
    filename=['ImgA00000',num2str(k),'.tif'];   % the name of the picture, corresponding to the "1,2,3,4...9" number
    Q{k}=imread(filename,'tif');             % read the file 
    RGB2=Q{k};                               % put the file into RGB2
    %figure;imshow(RGB2);                     % show the original image, %show the first image
    I2=rgb2gray(RGB2);                         % grayscale
    J1=imcomplement(I1);                      % change white and black, zero becomes one and one becomes zero, background image
    J2=imcomplement(I2);                      % the same as J1, 
    for i=1:m                                     
        for j=1:n
            if J2(i,j)-J1(i,j)>1                 % compare with the background image
            J(i,j)=J2(i,j)-J1(i,j);          % if the background image is brighter, then 
            else
            J(i,j)=0;                        % Finally the result will become 0 or the comparison value
            end 
        end
    end
    I=J;      
    %figure(1);imshow(I);    % show the second image
    RGB=imabsdiff(RGB2,RGB1);                   % substraction operation, pixel(RGB2-RBG1), cut the background image
    I=rgb2gray(RGB);                            % change to grayscale
    %figure;imshow(I);                           % show the third image  
    
    f0=0;g0=0;                                  % 
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
            if(f>=0)&(f<=f1)
          g(i,j)=r1*f+b1;
            elseif(f>=f1)&(f<=f2)
            g(i,j)=r2*f+b2;
            elseif(f>=f2)&(f<=f3)
            g(i,j)=r3*f+b3;
            end
        end
    end
J=mat2gray(g);                             % convert matrix to grayscale, increas the grayscale
figure(1);imshow(J);                          % the fourth image, show a clear white-black image

SE=strel('disk',2);                        % 
J1=imopen(J,SE);                           % substract some small regions
J1=imfill(J1,'holes'); 
%figure;imshow(J1);                     %white-black image-a little bit blur
level=graythresh(J1);                      %find an adequate threshold
BW=im2bw(J1,0.57);                         %最大类间方差法二值化图像（手动定阈值）
BW1=imfill(BW,'holes');                    %image imfilling
BW2=bwperim(BW1);                          %edge detection
 %   figure;imshow(BW1);                   %the last image 
    se=strel('disk',8);                    %strel the radius
I2=imerode(BW1,se);
%figure;imshow(I2);                        %image after erosion
bub{k}=I2;                                % BW1 to bub(k)
for sss=679:800                           %下面喷管口那部分不要
    BW2(sss,:)=0;
end
for xxx=1:65                           %上面那部分不要
    BW2(xxx,:)=0;
end
Len(k,:)=bwarea(BW2)*sc;                     %气泡周长，单位为mm
I3=BW1;
for sss=679:800                           %下面喷管口那部分不要
    I3(sss,:)=0;
end
for xxx=1:65                           %上面那部分不要
    I3(xxx,:)=0;
end
A(k,:)=bwarea(I3)*sc*sc;                    %气泡面积，单位为mm2
d(k,:)=sqrt(4*A(k)/pi)-sc*2;                 %气泡当量直径,具有相同面积，单位为mm
[L,num]=bwlabel(BW1,8);                    %将二值图像转化为标签矩阵
j=0;
for i=676:678                             %喷管直径从913像素到950像素（探针线）
j=j+1;
find(L(i,:))~=0;                          %找出喷管直径区域非零值
if isempty(find(L(i,:)~=0))                 
M(csu,j)=0; 
N(csu,j)=0;                               %如果找不出非零值，则令为0
else
[row,col]=find(L(i,:)~=0);
M(csu,j)=min(col);                        %左边夹
N(csu,j)=max(col);                        %右边夹
end
end
end