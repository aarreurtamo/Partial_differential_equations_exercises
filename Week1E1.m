%% 1.1
clearvars
close all
clc

% b
u = @(x,y) cos(2*y-6*x);
amount = 40;
border = 1;
area = linspace(-border,border,amount);
[x,y] = meshgrid(area,area);
z = u(x,y);
mesh(x,y,z)

% c
hold on
% Let's draw e.g 10 lines
lineAmount = 10; 
% Let's create different constant terms for the lines
d = linspace(-1,1,lineAmount)'; 
x_l = area;
y_l = 3*x_l+d;
z_l = u(x_l,y_l);
for i = 1:lineAmount
    plot3(x_l,y_l(i,:),z_l(i,:))
end