function [x_bary,y_bary,plot_area]=barycenter_recregion_area(L,num,m,n)
for k=1:num  
sum_x=0;    
sum_y=0;    
area=0; 
for i=1:m     % m is 800 for this problem, n is 300 for this problem
    for j=1:n
       if L(i,j)==k
       %if L(i,j)~=0 
       sum_x=sum_x+i;  
            sum_y=sum_y+j;  
            area=area+1;  
            %L(i,j)=
        end
    end
end
x_bary(k)=fix(sum_x/area);  
y_bary(k)=fix(sum_y/area);
plot_area(k)=area;
end


