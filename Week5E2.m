%% 5.2
clearvars
close all
clc

% Let's define the function u as a numerical function
u = @(r,t) log(r)+t;

% Let's make approximations of the derivatives
dr = 1e-4;
dt = pi*1e-5;
u_r = @(r,t) (u(r+dr,t)-u(r-dr,t))./(2*dr);
u_rr = @(r,t)  (u(r+dr,t)-2*u(r,t)+u(r-dr,t))./dr^2;
u_tt = @(r,t)  (u(r,t+dt)-2*u(r,t)+u(r,t-dt))./dt^2;

% Let's make the detla u function using polar Laplacian operator
delta_u = @(r,t) u_rr(r,t)+1./r.*u_r(r,t)+1./r.^2.*u_tt(r,t);

% Let's make points where we calculate the value of delta u
m = 1e+3;
r = 100*rand(m,1)+0.1;
t = linspace(-pi,pi,m)';
[R,T] = meshgrid(r,t);

% Let's calculate the sum
sum_of_values = sum(sum(delta_u(R,T)));
str = string(sum_of_values);
disp('The sum is '+str)








