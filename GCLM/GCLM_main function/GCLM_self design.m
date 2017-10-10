%% 
%clc
%clear all
%close all
%

%

%function []=GCLM()

%clc
%clear all
%close all

%Image=imread('ImgA000001.tif');

%count=1;
%% 
q=5;   %The first group of image
for k=1:20
if k>0 && k<10
        picture='ImgA00000';
end
if k>=10 && k<100
        picture='ImgA0000';
end    
if k>=100 && k<1000
        picture='ImgA000';
end    


%clc
%clear all
%close all
%k=1;
%picture='ImgA00000';
filename=[picture,num2str(k),'.tif'];
Q{k}=imread(filename,'tif');  
Image=Q{k};
[M,N,O]=size(Image);
Gray=rgb2gray(Image);
%imshow(Gray);


for i=1:M
    for j=1:N
        for n=1:256/16
            if (n-1)*16<=Gray(i,j) & Gray(i,j)<=(n-1)*16+15
                Gray(i,j)=n-1;
            end
        end
    end
end
%% 
%figure(1)
%imshow(Gray)
%% 
P=zeros(16,16,4);
for m=1:16
    for n=1:16
        for i=1:M
            for j=1:N
                if j<N&Gray(i,j)==m-1&Gray(i,j+1)==n-1
                    P(m,n,1) = P(m,n,1)+1;
                    P(n,m,1) = P(m,n,1);
                end
                if i>1&j<N&Gray(i,j)==m-1&Gray(i-1,j+1)==n-1
                    P(m,n,2) = P(m,n,2)+1;
                    P(n,m,2) = P(m,n,2);
                end
                if i<M&Gray(i,j)==m-1&Gray(i+1,j)==n-1
                    P(m,n,3) = P(m,n,3)+1;
                    P(n,m,3) = P(m,n,3);
                end
                if i<M&j<N&Gray(i,j)==m-1&Gray(i+1,j+1)==n-1
                    P(m,n,4) = P(m,n,4)+1;
                    P(n,m,4) = P(m,n,4);
                end
            end
        end
        if m==n
            P(m,n,:) = P(m,n,:)*2;
        end
    end
end

for n = 1:4
    P(:,:,n) = P(:,:,n)/sum(sum(P(:,:,n)));
end
%% 
H = zeros(1,4);
I = H;
Ux = H;      Uy = H;
deltaX= H;  deltaY = H;
C =H;
for n = 1:4
    E(n) = sum(sum(P(:,:,n).^2)); 
    for i = 1:16
        for j = 1:16
            if P(i,j,n)~=0
                H(n) = -P(i,j,n)*log(P(i,j,n))+H(n); 
            end
            I(n) = (i-j)^2*P(i,j,n)+I(n);  
           
            Ux(n) = i*P(i,j,n)+Ux(n); 
            Uy(n) = j*P(i,j,n)+Uy(n); 
        end
    end
end
for n = 1:4
    for i = 1:16
        for j = 1:16
            deltaX(n) = (i-Ux(n))^2*P(i,j,n)+deltaX(n); 
            deltaY(n) = (j-Uy(n))^2*P(i,j,n)+deltaY(n); 
            C(n) = i*j*P(i,j,n)+C(n);             
        end
    end
    C(n) = (C(n)-Ux(n)*Uy(n))/deltaX(n)/deltaY(n);   
end
%%               
result_E{q,k}=E;
result_H{q,k}=H;
result_I{q,k}=I;
result_C{q,k}=C;

a1 = mean(E)   ;
b1 = sqrt(cov(E));
result_meanE{q,k}=a1;
result_covE{q,k}=b1;

a2 = mean(H) 
b2 = sqrt(cov(H))
result_meanH{q,k}=a2;
result_covH{q,k}=b2;

a3 = mean(I)  
b3 = sqrt(cov(I))
result_meanI{q,k}=a3;
result_covI{q,k}=b3;

a4 = mean(C)
b4 = sqrt(cov(C))
result_meanC{q,k}=a4;
result_covC{q,k}=b4;

end

%sprintf('0,45,90,135 %f, %f, %f, %f',E(1),E(2),E(3),E(4))  
%sprintf('0,45,90,135 %f, %f, %f, %f',H(1),H(2),H(3),H(4))  
%sprintf('0,45,90,135 %f, %f, %f, %f',I(1),I(2),I(3),I(4))  
%sprintf('0,45,90,135 %f, %f, %f, %f',C(1),C(2),C(3),C(4))  
                
