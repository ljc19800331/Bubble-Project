function [min_row,max_row,min_column,max_column]=rectangle_region(L,num,m,n)

sym max_row;
sym min_row;
sym max_column;
sym min_column;

for k1=1:num    %size(L,1) is the number of row of L matrix
row=mod(  find(L==k1),  size(L,1)         );
%max row
max_row(k1)=max(  mod(  find(L==k1),  size(L,1)         )     );
if max_row(k1)==size(L,1)-1;
max_row(k1)=max_row(k1)+1;
end
%min row
min_row(k1)=min(       mod(  find(L==k1),size(L,1))       );
if min_row(k1)==0
min_row(k1)=1;
end
%max column
max_column(k1)= max( ceil( find(L==k1)/size(L,1)     )              );
%min column
min_column(k1)= min( ceil( find(L==k1)/size(L,1)    ) );

end