%% 2.2
clearvars
close all
clc

% Let's define the needed variables
I = 11;
N = 31;
x = linspace(0,1,I)';
t = linspace(0,1,N)';

dt = t(2)-t(1);
dx = x(2)-x(1);

uI = 1./(x.^2+1);

s = 2*dt/dx;

% Let's make the multiplier matrix A
A = zeros(I,I);
for n = 1:I-1
    A(n,n) = 1-s;
    A(n,n+1) = s;
end

% Let's make the b vector
b = zeros(I,1);

% Let's make a matrix U where we save the solution
U = zeros(I,N);
U(:,1) = uI;

% Let's make a loop to calulate the solutions.
for n = 1:N-1
    b(end) = 1./((1+2*t(n+1)).^2+1);
    un = A*U(:,n)+b;
    U(:,n+1) = un;
end

% Let's draw the solution
figure
[X,T] = meshgrid(x,t);
Z = 1./((X+2*T).^2+1);
mesh(X,T,Z,'FaceAlpha','0.6')
xlabel('$x$', 'interpreter', 'latex')
ylabel('$t$', 'interpreter', 'latex')
zlabel('$u$', 'interpreter', 'latex')
hold on

for i = 1:I
    plot3(x(i)*ones(1,N),t,U(i,:),'k*')
end
