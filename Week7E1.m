%% 7.1
clearvars
close all
clc

% Let's define the fucntion 
u = @(x,y) x.^2-y.^2;

% Let's define polar coordinates
x = @(r,t) r.*cos(t);
y = @(r,t) r.*sin(t);

% Let's define variables for the polar coordinates
t = linspace(0,2*pi);
r = linspace(0,1-1e-3);

% Let's calculate the maximum value of the border
border = u(x(1,t),y(1,t));
max_border = max(max(border));
min_border = min(min(border));

% Let's make a grid for the interioir
[T,R] = meshgrid(t,r);

% Let's calculate the maximum value of the interior
interior = u(x(R,T),y(R,T));
max_interior = max(max(interior));
min_interior = min(min(interior));

disp("The maximum on the border: "+string(max_border))
disp("The minimum on the border: "+string(min_border))

disp("The maximum in the interior: "+string(max_interior))
disp("The minimum in the interior: "+string(min_interior))














