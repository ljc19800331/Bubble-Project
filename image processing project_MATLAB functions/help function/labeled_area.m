function [plot_area]=labeled_area(L,num,m,n)
for k=1:num  
sum_x=0;    
sum_y=0;    
area=0; 
for i=1:m
    for j=1:n
        if L(i,j)==k
            sum_x=sum_x+i;  
            sum_y=sum_y+j;  
            area=area+1;   
        end
    end
end
plot_area(k)=area;
end
