function [bw]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,bw)

%cut the nozzle of bw
for sss=nozzel_upper_row:800
    for ppp=nozzel_upper_column:300
    bw(sss,ppp)=0;
    end
end
