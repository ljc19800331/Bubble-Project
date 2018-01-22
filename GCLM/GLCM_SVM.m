% GLCM and SVM main function 
clc;clear all;close all;

%% Load the data
%flag_class = '2\';
%flag_doc = strcat('C:\Users\magua\Documents\MATLAB\Bubble image processing\bubble_svm_train\',flag_class);
%% 
tic;
for f = 1:4
    flag_class = strcat(num2str(f),'\');
    flag_doc = strcat('C:\Users\magua\Documents\MATLAB\Bubble image processing\bubble_svm_train\',flag_class);
for k = 1: 100

firstimage=1;
lastimage=1;
delta=1;                                

if k>0 && k<10
        picture='ImgA00000';
end
if k>=10 && k<100
        picture='ImgA0000';
end    
if k>=100 && k<1000
        picture='ImgA000';
end    

filename=[picture,num2str(k),'.tif'];
flag_file = strcat(flag_doc,filename);
Q{k}=imread(flag_file,'tif');  
RGB_original=Q{k};
img_gray = rgb2gray(RGB_original); 
rs = size(img_gray);
M = rs(1); N = rs(2);

% figure(1);
% subplot(1,2,1)
% imshow(RGB_original);
% subplot(1,2,2)
% imshow(img_gray);

[glcm_0, img_glcm] = graycomatrix(img_gray, 'NumLevels', 16, 'offset',[0,1]);
[glcm_45, img_glcm] = graycomatrix(img_gray, 'NumLevels', 16, 'offset',[-1,1]);
[glcm_90, img_glcm] = graycomatrix(img_gray, 'NumLevels', 16, 'offset',[-1,0]);
[glcm_135, img_glcm] = graycomatrix(img_gray, 'NumLevels', 16, 'offset',[-1,-1]);

%% Generate normalized feature vector based on GLCM
P = zeros(16,16,4);
P(:,:,1) = glcm_0;
P(:,:,2) = glcm_45;
P(:,:,3) = glcm_90;
P(:,:,4) = glcm_135;

% normalize the matrix
for n = 1:4
    P(:,:,n) = P(:,:,n)/sum(sum(P(:,:,n)));
end

%% calculate the four feature analysis

H = zeros(1,4);
I = H;
Ux = H;      Uy = H;
deltaX= H;  deltaY = H;
C =H;

for n = 1:4
    E(n) = sum(sum(P(:,:,n).^2)); %%energy
    for i = 1:16
        for j = 1:16
            if P(i,j,n)~=0
                H(n) = -P(i,j,n)*log(P(i,j,n))+H(n); %%entropy
            end
            I(n) = (i-j)^2*P(i,j,n)+I(n);  %%moment of inertia

            Ux(n) = i*P(i,j,n)+Ux(n); %?x
            Uy(n) = j*P(i,j,n)+Uy(n); %?y
        end
    end
end

for n = 1:4
    for i = 1:16
        for j = 1:16
            deltaX(n) = (i-Ux(n))^2*P(i,j,n)+deltaX(n); %?x
            deltaY(n) = (j-Uy(n))^2*P(i,j,n)+deltaY(n); %?y
            C(n) = i*j*P(i,j,n)+C(n);             
        end
    end
    C(n) = (C(n)-Ux(n)*Uy(n))/deltaX(n)/deltaY(n); %relativity   
end

% Take the average and RMS as the final eight vectors features

a1 = mean(E); 
b1 = sqrt(cov(E));

a2 = mean(H); 
b2 = sqrt(cov(H));

a3 = mean(I);  
b3 = sqrt(cov(I));

a4 = mean(C);
b4 = sqrt(cov(C));

img_vec((f-1)*100+k,1)=a1;
img_vec((f-1)*100+k,2)=b1;
img_vec((f-1)*100+k,3)=a2;
img_vec((f-1)*100+k,4)=b2;
img_vec((f-1)*100+k,5)=a3;
img_vec((f-1)*100+k,6)=b3;
img_vec((f-1)*100+k,7)=a4;
img_vec((f-1)*100+k,8)=b4;

end
end
toc;
%% 
for flag_label = 1:4
    Label((flag_label-1)*100+1:(flag_label)*100)= flag_label;
end
Label = Label';
%% SVM classification
X = img_vec;
Y = Label;
cp = cvpartition(Y,'k',10); % Stratified cross-validation
Mdl = fitcecoc(X,Y);
CVMdl = crossval(Mdl);
%cfMat = crossval(Mdl,X,Y,'partition',cp);
%% Validate the data
X = img_vec;
Y = Label;

regf=@(XTRAIN,ytrain,XTEST)(XTEST*regress(ytrain,XTRAIN));
cvMse = crossval('mse',X,Y,'predfun',regf);

order = unique(Y); % Order of the group labels
cp = cvpartition(Y,'k',10); % Stratified cross-validation
f = @(xtr,ytr,xte,yte)confusionmat(yte,...
classify(xte,xtr,ytr),'order',order);
cfMat = crossval(f,X,Y,'partition',cp);
cfMat = reshape(sum(cfMat),4,4);
cvMCR = crossval('mcr',X,Y,'predfun',f,'partition',cp);





