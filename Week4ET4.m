clearvars
close all
clc

a = [1,1];

h = [0.4,0.6];
theta = 0.1;

h = [linspace(-1,1,100)',linspace(-1,1,100)'];
x = a(1)+h(:,1);
y = a(2)+h(:,2);

f = @(x,y) exp(x.*y);

T4 = @(x,y) exp(1)*( ...
    -1+x+1/2*(x-1).^2+1/2*(y-1).^2+...
    y+2*(x-1).*(y-1));

tv = abs(f(x,y)-T4(x,y))-abs(errorTerm(theta,h,a))


function R = errorTerm(theta,h,a)

    dalpha12 = @(x,y) 2*x.*exp(x.*y)+x.^2.*y.*exp(x.*y);
    dalpha21 = @(x,y) 2.*y.*exp(x.*y)+y.^2.*x*exp(x.*y);
    dalpha03 = @(x,y) x.^3*exp(x.*y);
    dalpha30 = @(x,y) y.^3*exp(x.*y);

    x = a(1)+theta*h(1);
    y = a(2)+theta*h(2);
    R = dalpha12(x,y)/2*h(1).*h(2).^2 ...
        +dalpha21(x,y)/2*h(1).^2.*h(2)+...
        dalpha03(x,y)/3*h(2).^3+...
        dalpha30(x,y)/3*h(1).^3;
end

