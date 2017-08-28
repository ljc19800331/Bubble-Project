function []=plot_region_barycenter(k,num,plot_x,plot_y,mini_row,maxi_row,mini_column,maxi_column,nozzel_upper_row,nozzel_upper_column)

for i=1:num
%Plot the point of the nozzel
%hold on
%plot(nozzel_upper_row,nozzel_upper_column,'o');
%Plot others
%hold on
hold  on
plot(plot_y{k}(1,i) ,plot_x{k}(1,i),'*');   %draw the barycenter
hold on
j=num2str(i);
text(plot_y{k}(1,i) ,plot_x{k}(1,i),j);     %label the number\

hold  on
plot(mini_column{k}(1,i),mini_row{k}(1,i),'o');

hold  on
plot(maxi_column{k}(1,i),mini_row{k}(1,i),'o');
hold  on
plot(maxi_column{k}(1,i),maxi_row{k}(1,i),'o');
hold  on
plot(mini_column{k}(1,i),maxi_row{k}(1,i),'o');
hold on
line([mini_column{k}(1,i),maxi_column{k}(1,i)],[mini_row{k}(1,i),mini_row{k}(1,i)],'Color','red')
hold on
line([maxi_column{k}(1,i),maxi_column{k}(1,i)],[mini_row{k}(1,i),maxi_row{k}(1,i)],'Color','red')
hold on
line([maxi_column{k}(1,i),mini_column{k}(1,i)],[maxi_row{k}(1,i),maxi_row{k}(1,i)],'Color','red')
hold on
line([mini_column{k}(1,i),mini_column{k}(1,i)],[maxi_row{k}(1,i),mini_row{k}(1,i)],'Color','red')
end
