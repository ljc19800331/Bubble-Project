function [bw_separate]=bubble_separate(L,num,m,n)
    for k=1:num    
        [r, c] = find(L==k);
        bw_separate{k}=logical(zeros(m,n));
    for i=1:length(r)
    %    for j=1:length(c)
        bw_separate{k}(r(i),c(i))=1;
    end
end


