% Image processing
%Week 1 p1
I=imread('C:\Users\maguangshen\Documents\MATLAB\picture resource\1.jpg');  % input the first image
a=input('intensity level=');   %intensity level
[row,col]=size(I);
for i=1:row
    for j=1:col
        I(i,j)=a;
    end
end
imshow(I);

%Week 1 p2
sym I1
sym sum1 
sym sum2 
sym sum3
sym sum
sym check
I=imread('C:\Users\maguangshen\Documents\MATLAB\picture resource\1.jpg');  % input the first image
%for r=1:10
 %   for v=1:10
  %      I(r,v,1)=picture(r,v,1);
   %     I(r,v,2)=picture(r,v,2);
    %   I(r,v,3)=picture(r,v,3);
   % end
%end
n=input('the neighbour value=');  %input the neighbour value such as 3x3 or 10x10
[row,col,t]=size(I);  % compute the row and column
if mod(n,2)==1 %odd number
    k1=fix(n/2);
    k2=fix(n/2);
    k3=fix(n/2);
    k4=fix(n/2);
end
if mod(n,2)==0 %even number
    k1=fix(n/2)-1;
    k2=fix(n/2);
    k3=fix(n/3)-1;
    k4=fix(n/4);
end
% compute the average
for i=1:row
    for j=1:col  %compute the coefficient k1,k2,k3,k4
        if (i-k1)<=0
            row1=1;
        else
            row1=i-k1;
        end
        if (i+k2)>row
            row2=row;
        else
            row2=i+k2;
        end
        if (j-k3)<=0
            col1=1;
        else
            col1=j-k3;
        end
        if (j+k4)>col
            col2=col;
        else
            col2=j+k4;
        end
        sum1=0;
        sum2=0;
        sum3=0;
        sum4=0;
        m=0;
        check(i,j,1)=row1;
        check(i,j,2)=row2;
        check(i,j,3)=col1;
        check(i,j,4)=col2;
        m=(row2-row1+1)*(col2-col1+1);
        for p=row1:row2
            for q=col1:col2
                sum1=sum1+(I(p,q,1))/m;
                sum2=sum2+(I(p,q,2))/m;
                sum3=sum3+(I(p,q,3))/m;
                %sum=sum+(I(p,q,1)+I(p,q,2)+I(p,q,3))/3;
                %m=m+1;
            end
        end
        sum(i,j,1)=sum1;
        sum(i,j,2)=sum2;
        sum(i,j,3)=sum3;
        I1(i,j,1)=sum1;
        I1(i,j,2)=sum2;
        I1(i,j,3)=sum3;
    end
end
figure(1)
imshow(I)
figure(2)
imshow(I1)


% Week 1 p3
% Rotate the image by 45 degrees
I=imread('C:\Users\maguangshen\Documents\MATLAB\picture resource\1.jpg'); 
A=imrotate(I,45);
figure(1)
imshow(A)
figure(2)
imshow(I)
% Just for reference
X = gpuArray(imread('pout.tif'));
Y = imrotate(X, 37, 'loose', 'bilinear');
figure; imshow(Y)


% Week 1 p4
% 3x3 block division or 5x5
sym sum1 
sym sum2 
sym sum3
I=imread('C:\Users\maguangshen\Documents\MATLAB\picture resource\1.jpg');  % input the first image
%n=input('the block value=');
n=3;
[a,b,t]=size(I);
row=fix(a/n);
col=fix(b/n);
% define the average block value
%sym Ip % define the block average value
%row=10;
%col=10;
sym I1
 % define the length of divisor
for i=1:row
    for j=1:col
        row1=3*i-2;
        row2=3*i;
        col1=3*j-2;
        col2=3*j;
        sum1=0;
        sum2=0;
        sum3=0;
        sum=0;
        m=n*n;
        for p=row1:row2
            for q=col1:col2
                sum1=sum1+(I(p,q,1))/m;
                sum2=sum2+(I(p,q,2))/m;
                sum3=sum3+(I(p,q,3))/m;
                sum=sum+1;
            end
        end
        %Ip(i,j,1)=sum1;
        %Ip(i,j,2)=sum2;
        %Ip(i,j,3)=sum3;
        for r=row1:row2
            for v=col1:col2
                I1(r,v,1)=sum1;
                I1(r,v,2)=sum2;
                I1(r,v,3)=sum3;
            end
        end
    end
end
figure(1)
imshow(I1)
figure(2)
imshow(I)

% Week 2 p.1 
% JPEG compression
% 1. Divide the image into non-overlapping 8x8 blocks


