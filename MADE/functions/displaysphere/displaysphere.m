function [  ] = displaysphere( A )
%PLOTSPHERE Summary of this function goes here

[x, y, z] = getsphere(A);
plot3(x,y,z,'o','MarkerSize',8,'LineWidth',2);
set(gca,'FontSize',40);
grid on;


end

