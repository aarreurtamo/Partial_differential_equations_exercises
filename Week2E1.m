%% 2.1
clearvars
close all
clc

% Let's make the needed variables.
I = 7;
N = 21;
x = linspace(0,1,I)';
t = linspace(0,1,N)';

dt = t(2)-t(1);
dx = x(2)-x(1);
u1 = zeros(I,1);
s = 2*dt/dx;

% Let's make the multiplier matrix A
A = zeros(I,I);
for n = 2:I
    A(n,n-1) = s;
    A(n,n) = 1-s;
end

% Let's make the b vector
b = dt./(x.^2+1);
b(1) = 1/2*atan(2*t(2));

% U is matrix where the solution is saved.
U = zeros(I,N);
U(:,1) = u1;

% Let's make the first iteration outside the loop
u2 = A*u1+b;
U(:,2) = u2;

% Let's make a loop for the rest of the iterations.
for n = 3:N
    b(1) = 1/2*atan(2*t(n));
    un = A*U(:,n-1)+b;
    U(:,n) = un;
end

% Let's draw the soluton.
figure
[X,T] = meshgrid(x,t);
Z = 1/2*atan(X)-1/2*atan(X-2*T);
mesh(X,T,Z,'FaceAlpha','0.6')
xlabel('$x$', 'interpreter', 'latex')
ylabel('$t$', 'interpreter', 'latex')
zlabel('$u$', 'interpreter', 'latex')


hold on
for i = 1:I
    plot3(x(i)*ones(1,N),t,U(i,:),'k*')
end
