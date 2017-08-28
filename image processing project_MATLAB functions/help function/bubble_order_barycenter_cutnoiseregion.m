function [L_order_1,Cell_3]=bubble_order_barycenter_cutnoiseregion(L,plot_xonly,k,num,m,n)

for q1=1:num
cell(q1)=0;
end

change_cell=(plot_xonly{k}); %change cell array to ordinary array
change_cell=sort(change_cell,'descend'); %in order from the descending
count=0;

for i=m:-1:1
    for j=n:-1:1
        flag=0;
        if L(i,j)~=0
            for q=1:num
                if L(i,j)==cell(q)
                    L(i,j)=q;
                    flag=1;
                end
            end
            if flag==0
                m1=L(i,j);
                for p=1:num
                    if plot_xonly{k}(1,m1)==change_cell(p)
                        cell(p)=m1;
                        L(i,j)=p;
                        %continue;
                    end
                end
            end
        else
            continue;
        end
    end
end

L_order_1=L;
Cell_3=cell;



