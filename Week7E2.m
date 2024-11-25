%% 7.2
clearvars
close all
clc

% Let's initialize needed variables
u = @(x,y) sin(x).*sin(y);
m = 10;
x = linspace(-pi,pi,m);
y = x;

% Let's calculate the values of u in the domain
[X,Y] = meshgrid(x,y);
U = u(X,Y);

% LEt's define tha gradient
[u_x,u_y] = gradient(U);
grad_mag = sqrt(u_x.^2+u_y.^2);

% Let's calculate the maximum of the gradient
u_max = max(max(U));
grad_max = max(max(grad_mag));

disp("Maximum of u in the domain: "+string(u_max))
disp("Maximum of the gradient: "+string(grad_max))






