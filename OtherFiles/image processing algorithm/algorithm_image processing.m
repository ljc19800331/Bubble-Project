clear all；
sc=6/30;                               %缩放系数，即每个像素的实际尺寸，单位为mm/像素,实际测量的气泡直径为mm
firstimage=1;                            %第一张图像序号
lastimage=9;                             %最后一张图像序号1190
deta=1;                                     %相邻两张图像之间的序号间隔
RGB1=imread('ImgA999999.tif');                  %背景图像
I1=rgb2gray(RGB1);                               %将真彩色图像转换成灰度图像
[m,n]=size(I1);
csu=0;                                         %照片数
for k=firstimage:deta:lastimage;
csu=csu+1;
    filename=['ImgA00000',num2str(k),'.tif'];
    Q{k}=imread(filename,'tif');             %读取图像
    RGB2=Q{k};                               %将RGB2的图像赋值给Q{k}
%figure;imshow(RGB2);
I2=rgb2gray(RGB2);                         %原始图片
J1=imcomplement(I1);                      %对图像数据进行取反运算，实现底片效果
J2=imcomplement(I2);
for i=1:m                              
    for j=1:n
        if J2(i,j)-J1(i,j)>1
            J(i,j)=J2(i,j)-J1(i,j);          %减影算法
        else
            J(i,j)=0;
        end 
    end
end
I=J;
%figure;imshow(I);
%RGB=imabsdiff(RGB2,RGB1);                   %待处理图像减去背景图像
%I=rgb2gray(RGB);                            %将真彩图像转化为灰度图像
%figure;imshow(I);
f0=0;g0=0;
f1=20;g1=100;
f2=100;g2=180;
f3=255;g3=255;
r1=(g1-g0)/(f1-f0);
b1=g0-r1*f0;
r2=(g2-g1)/(f2-f1);
b2=g1-r2*f1;
r3=(g3-g2)/(f3-f2);
b3=g2-r3*f2;                                %图像填充处理

X2=double(I);
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
J=mat2gray(g);                             %灰度增强

%figure;imshow(J);                          %黑白照片（清晰）

SE=strel('disk',2);
J1=imopen(J,SE);                           %开操作去除小区域
J1=imfill(J1,'holes'); 
%figure;imshow(J1);                         %黑白照片（稍模糊）
%level=graythresh(J1);                      %最大类间方差找到图片的合适阈值
BW=im2bw(J1,0.57);                         %最大类间方差法二值化图像（手动定阈值）
BW1=imfill(BW,'holes');                    %图像填充
BW2=bwperim(BW1);                          %二值化图像边缘提取
    %figure;imshow(BW1);                   %最终图像
    %se=strel('disk',8);                   %羽化半径
%I2=imerode(BW1,se);
%figure;imshow(I2);                        %腐蚀以后的图像
bub{k}=I2;                                %将BW1赋值给bub{k}
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