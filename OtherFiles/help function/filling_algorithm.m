function [g]=filling_algorithm(I,m,n)
%%filling processing here I is RGB image
f0=0;g0=0;
f1=20;g1=100;
f2=100;g2=180;
f3=255;g3=255;
r1=(g1-g0)/(f1-f0);
b1=g0-r1*f0;
r2=(g2-g1)/(f2-f1);
b2=g1-r2*f1;
r3=(g3-g2)/(f3-f2);
b3=g2-r3*f2; 
X2=double(I);  %change I from unit 8 to double
for i=1:m      %here the g matrix is used in this problem
    for j=1:n
        f=X2(i,j);
        g(i,j)=0;
        if(f>=0)&(f<=1)
            g(i,j)=r1*f+b1;
        elseif(f>=f1)&(f<=f2)
            g(i,j)=r2*f+b2;
            elseif(f>=f2)&(f<=f3) 
            g(i,j)=r3*f+b3;       
        end
     end
end