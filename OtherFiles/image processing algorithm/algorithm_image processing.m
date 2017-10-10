clear all��
sc=6/30;                               %����ϵ������ÿ�����ص�ʵ�ʳߴ磬��λΪmm/����,ʵ�ʲ���������ֱ��Ϊmm
firstimage=1;                            %��һ��ͼ�����
lastimage=9;                             %���һ��ͼ�����1190
deta=1;                                     %��������ͼ��֮�����ż��
RGB1=imread('ImgA999999.tif');                  %����ͼ��
I1=rgb2gray(RGB1);                               %�����ɫͼ��ת���ɻҶ�ͼ��
[m,n]=size(I1);
csu=0;                                         %��Ƭ��
for k=firstimage:deta:lastimage;
csu=csu+1;
    filename=['ImgA00000',num2str(k),'.tif'];
    Q{k}=imread(filename,'tif');             %��ȡͼ��
    RGB2=Q{k};                               %��RGB2��ͼ��ֵ��Q{k}
%figure;imshow(RGB2);
I2=rgb2gray(RGB2);                         %ԭʼͼƬ
J1=imcomplement(I1);                      %��ͼ�����ݽ���ȡ�����㣬ʵ�ֵ�ƬЧ��
J2=imcomplement(I2);
for i=1:m                              
    for j=1:n
        if J2(i,j)-J1(i,j)>1
            J(i,j)=J2(i,j)-J1(i,j);          %��Ӱ�㷨
        else
            J(i,j)=0;
        end 
    end
end
I=J;
%figure;imshow(I);
%RGB=imabsdiff(RGB2,RGB1);                   %������ͼ���ȥ����ͼ��
%I=rgb2gray(RGB);                            %�����ͼ��ת��Ϊ�Ҷ�ͼ��
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
b3=g2-r3*f2;                                %ͼ����䴦��

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
J=mat2gray(g);                             %�Ҷ���ǿ

%figure;imshow(J);                          %�ڰ���Ƭ��������

SE=strel('disk',2);
J1=imopen(J,SE);                           %������ȥ��С����
J1=imfill(J1,'holes'); 
%figure;imshow(J1);                         %�ڰ���Ƭ����ģ����
%level=graythresh(J1);                      %�����䷽���ҵ�ͼƬ�ĺ�����ֵ
BW=im2bw(J1,0.57);                         %�����䷽���ֵ��ͼ���ֶ�����ֵ��
BW1=imfill(BW,'holes');                    %ͼ�����
BW2=bwperim(BW1);                          %��ֵ��ͼ���Ե��ȡ
    %figure;imshow(BW1);                   %����ͼ��
    %se=strel('disk',8);                   %�𻯰뾶
%I2=imerode(BW1,se);
%figure;imshow(I2);                        %��ʴ�Ժ��ͼ��
bub{k}=I2;                                %��BW1��ֵ��bub{k}
for sss=679:800                           %������ܿ��ǲ��ֲ�Ҫ
    BW2(sss,:)=0;
end
for xxx=1:65                           %�����ǲ��ֲ�Ҫ
    BW2(xxx,:)=0;
end
Len(k,:)=bwarea(BW2)*sc;                     %�����ܳ�����λΪmm
I3=BW1;
for sss=679:800                           %������ܿ��ǲ��ֲ�Ҫ
    I3(sss,:)=0;
end
for xxx=1:65                           %�����ǲ��ֲ�Ҫ
    I3(xxx,:)=0;
end
A(k,:)=bwarea(I3)*sc*sc;                    %�����������λΪmm2
d(k,:)=sqrt(4*A(k)/pi)-sc*2;                 %���ݵ���ֱ��,������ͬ�������λΪmm
[L,num]=bwlabel(BW1,8);                    %����ֵͼ��ת��Ϊ��ǩ����


j=0;
for i=676:678                             %���ֱ����913���ص�950���أ�̽���ߣ�
j=j+1;
find(L(i,:))~=0;                          %�ҳ����ֱ���������ֵ

if isempty(find(L(i,:)~=0))                 
M(csu,j)=0; 
N(csu,j)=0;                               %����Ҳ�������ֵ������Ϊ0

else
[row,col]=find(L(i,:)~=0);
M(csu,j)=min(col);                        %��߼�
N(csu,j)=max(col);                        %�ұ߼�
end
end
end