%% 6.1
clearvars
close all
clc

f = @(x,y) x.^2-y.^2;

n = 2;
r = 1;
alpha2 = pi;

surface_area = n*alpha2*r.^(n-1);

f_tilde = @(theta) f(r*cos(theta),r*sin(theta));

f_zero_mvt = 1/surface_area*integral(f_tilde,0,2*pi);

disp('f(0,0) = '+string(f(0,0)))
disp('Using MVT we get f(0,0) = '+string(f_zero_mvt))






