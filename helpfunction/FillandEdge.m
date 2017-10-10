% FillandEdge
RGB_imfill=imfill(I);
J=mat2gray(RGB_imfill);

SE=strel('disk',2);  
J1=imopen(J,SE);   
J1=imfill(J1,'holes'); 

level=graythresh(J1);
BW=im2bw(J1,level);
BW1=imfill(BW,'holes');
bub{k}=BW1;

% edge detection
BW2=edge(BW1,'canny');