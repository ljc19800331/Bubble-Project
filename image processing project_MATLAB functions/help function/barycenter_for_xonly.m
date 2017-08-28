function [bary_xonly]=barycenter_for_xonly(L,num,m,n)

for k=1:num  
sum_x=0;      
area=0; 
for i=1:m     % m is 800 for this problem, n is 300 for this problem
    for j=1:n
       if L(i,j)==k
       sum_x=sum_x+i;  
            area=area+1;  
        end
    end
end
bary_xonly(k)=fix(sum_x/area);  
end