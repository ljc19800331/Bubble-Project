function [J] =Jianying_algorithm(J1,J2,m,n)
for i=1:m
    for j=1:n
        if J2(i,j)-J1(i,j)>1
         J(i,j)=J2(i,j)-J1(i,j); % jianying algorithm
          else
         J(i,j)=0;
          end
      end
 end      