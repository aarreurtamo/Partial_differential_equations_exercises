%% 2
clearvars
close all
clc

% Let's define needed varables
m = 50;
x1 = linspace(0,1,m);

% Let's make a numerical function out of the p-norm formula 
x2 = @(p) (1-x1.^p).^(1/p);

% Let's initialize the figure
figure
hold on
axis([-1.5,1.5,-1.5,1.5])
xlabel("x1")
ylabel("x2")
title("p-norm when the value of p increases ")

% To draw the whole circle we need 4 different plot commands
P1 = plot(x1,x2(2),'b');
P2 = plot(-x1,x2(2),'b');
P3 = plot(x1,-x2(2),'b');
P4 = plot(-x1,-x2(2),'b');

% Let's implement the animation using a loop
for p = 3:500
    pause(1)
    % We only need to change the data of x2
    % x1 remains the same
    P1.YData = x2(p);
    P2.YData = x2(p);
    P3.YData = -x2(p);
    P4.YData = -x2(p);
end


