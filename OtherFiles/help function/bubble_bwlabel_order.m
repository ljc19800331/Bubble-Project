function [L_order,Cell_1,Cell_2,m2]=bubble_bwlabel_order(L,num,m,n)
%Initial value of cell_1 arrary
for i=1:num
cell_1{i}=0;
end

for i=1:num
    cell_2{i}=i;
end

count_1=0;
m2=0;

for i=m:-1:1
    for j=n:-1:1
        flag=0;  %record the position
        if L(i,j)~=0 %see if L(i,j) is equal to 0
          for q=1:num
            if L(i,j)==cell_1{q}        %see if this is a new label
             %L(i,j)=cell_2{q};
             L(i,j)=q;
             flag=1;
            end
          end
          if flag==0
              m2=m2+1;
          count_1=count_1+1;
          cell_1{count_1}=L(i,j);
          L(i,j)=count_1;
          end
        else
            continue;
        end
    end
end
L_order=L;
Cell_1=cell_1;
Cell_2=cell_2;
            
            
            
    
    
        
    