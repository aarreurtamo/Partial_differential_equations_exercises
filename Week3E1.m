%% 3.1
clearvars
close all
clc

% The function call
f = @(x,y) x.*y; 
a = [1,1]; 
r = 5; 
w3e1(f,r,a);

function w3e1(f,r0,a)

    % Let's define needed values
    m = 50;
    t = linspace(0,2*pi,m)';
    r = linspace(0,r0,m);

    % For practice, let's make the meshgrid without the meshgrid command
    T = zeros(m,m);
    for i = 1:m
        T(:,i) = ones(m,1)*t(i);
    end

    R = zeros(m,m);
    for i = 1:m
        R(i,:) = ones(1,m)*r(i);
    end

    % Let's define x and y using polar cordinates
    x = R.*cos(T)+a(1); 
    y = R.*sin(T)+a(2);
    z = f(x,y);

    mesh(x,y,z,'FaceAlpha','0.6')
    xlabel("x")
    ylabel("y")
    zlabel("z")
    title("Function f in a closed ball domain B(a,r)")
end