%% 5.1
clearvars
close all
clc

% Let's initialize needed values.
f = @(x) x(1).^2+2*x(2).^2;
g = @(x) sin(x(1))+cos(x(2));

a = [1,2]';
b = [3,4]';

f_minus = f(b)-f(a);
g_minus = g(b)-g(a);

% Let's define the gradients of f and g
f_grad = @(x) numGrad(f,x);
g_grad = @(x) numGrad(g,x);

% Let's make a tolerance to check that our values are close enough zero
tol = 1e-4;

% Let's define the direction vector of the line through points a and b.
v = b-a;

% Let's make the points c using the parametric presentation of a line
m = 1e+6;
t = linspace(0,1,m);
c = a+v*t;

% Let's make a loop where we check if the desired point exists.

for i = 1:m
    value_f = f_grad(c(:,i))'*v;
    if abs(value_f-f_minus) < tol
        ind_f = i;
        c_f = c(:,ind_f);
        t_f = t(ind_f);
        break
    end
end

for i = 1:m
    value_g = g_grad(c(:,i))'*v;
    if abs(value_g-g_minus) < tol
        ind_g = i;
        c_g = c(:,ind_g);
        t_g = t(ind_g);
        break
    end
end

disp('Desired point in case of function f:')
disp(c_f)
disp('Desired point in case of function g:')
disp(c_g)

% Let's implement the graphical solution.
m_plot = 1e+2;
t_plot = linspace(0,1,m_plot);
c_plot = a+v*t_plot;

f_values = zeros(m_plot,1);
g_values = zeros(m_plot,1);

for i = 1:m_plot
    f_values(i) = f_grad(c_plot(:,i))'*(b-a);
    g_values(i) = g_grad(c_plot(:,i))'*(b-a);
end

figure
plot(t_plot,f_values)
hold on
plot(t_plot,f_minus*ones(m_plot,1))
plot(t_f,value_f,'ko')
title("f")
xlabel("t")

figure
plot(t_plot,g_values)
hold on
plot(t_plot,g_minus*ones(m_plot,1))
plot(t_g,value_g,'ko')
title("g")
xlabel("t")


% Let's make a numerical function for calculation gradient
function g = numGrad(f,x)
    h = 1e-8;
    n = length(x);
    g = zeros(n,1);
    for i = 1:n
        xi1 = x;
        xi2 = x;
        xi1(i) = x(i)+h;
        xi2(i) = x(i)-h;
        g(i) = (f(xi1)-f(xi2))/(2*h);
    end
end



