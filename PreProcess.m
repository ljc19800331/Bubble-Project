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
Q{k}=imread(filename,'tif');  
RGB_original=Q{k};
origin2gray=rgb2gray(RGB_original);