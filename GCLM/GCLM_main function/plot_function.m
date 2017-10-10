


%save('D:\image processing_ GCLM\GCLM result');
%filename = 'test.mat';
%save(filename)
for n=1:5
    for k=1:20
        show(n,k)=result_meanI{n,k};
    end
end
for n=1:5
    hold on
    plot(show(n,:));
end
%different color for this part


%The energy 

close all

color=[1 0 0;  0 1 0;  0 0 1;  0.5 0.8 0.9 ; 1 1 0];

i=1;

for n=1:5
    for k=1:20 
        mean_C(n,k)=result_meanC{n,k};
    end
end
for n=1:5
    hold on
    plot(mean_C(n,:),'color',color(i,:),'LineWidth',5);
    i=i+1;
%    plot(x,cp,'color',color(i,:));
end
grid on;
legend('group 1','group 2','group 3','group 4','group 5','Location','bestoutside','fontsize',30);
title('The correlation indicator for GCLM method','Fontsize',15);
xlabel('The number of image','Fontsize',15);
ylabel('The correlation indicator','Fontsize',15);




























