% see the result (functions)
figure(1)
imshow(RGB_b)
title('Original background Image');
figure(2)
imshow(l1)
title('gray original background Image');
figure(3)
imshow(Q{k})
title('Original Image');
figure(4)
imshow(l2)
title('gray original Image');
figure(5)
imshow(J1)
title('imcomple back original Image');
figure(6)
imshow(J2)
title('imcomple original Image');
figure
imshow(J)
title('jianying algorithm')
figure(7)
imshow(RGB)
title('imabsdiff');
figure(8)
imshow(I)
title('RGB to gray');
figure(9)
imshow(g)
title('after filling process');
figure(10)
imshow(J)
title('after filling process, enhance the grayscale');
figure(11)
imshow(J1)
title('imopen and imfill')
figure(12)
imshow(BW)
title('after binary process')
figure(13)
imshow(BW1)
title('imfill')
figure(14)
imshow(BW2)
title('edge detection')









