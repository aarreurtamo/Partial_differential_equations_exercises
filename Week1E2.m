%% 1.2
clearvars
close all
clc

% b
u = @(x,y) 1/3*y+sin((x-1/2*y.^2)/5);

border = 10;
density = 0.5;
[x,y] = meshgrid(-border:density:border,-border:density:border);
z = u(x,y);
figure
mesh(x,y,z)

% c
t = -5:density:5;
x_curve = 1/2*t.^2;
y_curve = t;
u_curve = 1/3*t;

hold on
plot3(x_curve,y_curve,u_curve,"k");

% Let's check that the wanted point is on the curve
plot3(0,0,0,"k*")

% d
% Let's draw the vectors.
density_v = 1.5;
[x_v,y_v] = meshgrid(-border:density_v:border,-border:density_v:border);
z_v = u(x_v,y_v);
v_x = y_v;
v_y = ones(size(x_v));
v_u = 1/3*ones(size(x_v));

% Let's do normalization and draw.
v_xn = v_x./sqrt(v_x.^2+v_y.^2+v_u.^2);
v_yn = v_y./sqrt(v_x.^2+v_y.^2+v_u.^2);
v_un = v_u./sqrt(v_x.^2+v_y.^2+v_u.^2);
quiver3(x_v,y_v,z_v,v_xn,v_yn,v_un,0.5,"r")

