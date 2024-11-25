%% 6.2
clearvars
close all
clc

% Let's define needed variables.
f = @(x) abs(x);
m = 1000;
y_p = linspace(-1,1,m)';
x_p = linspace(-1,1,m);

% Let's define the mollifier function
mol = @(x) exp(1./(abs(x).^2-1));
C = 1./integral(mol,-1,1);
mol_eps = @(epsilon,x) epsilon.^(-1).*C.*mol(x./epsilon);


% Let's plot the orginal function.
plot(x_p,f(x_p),'k')
hold on

% Let's make a variable for the differences of x and y
differences = x_p-y_p;

% Let's calcuclate values for the mollifed function for different values of
% epsilon

plot_iterations = 5;
epsilon_values = linspace(0,1,plot_iterations);
for epsilon = epsilon_values
    f_epsilon = convolution(f,y_p,differences,epsilon,m,mol_eps);
    plot(x_p,f_epsilon)
end


% Let's adjust epsilon
epsilon = 0; 

f_epsilon = convolution(f,y_p,differences,epsilon,m,mol_eps);

% Let's use least squares method to adjust the epsilon parameter
min_sq_sum = sum((f(y_p)-f_epsilon).^2);
best_epsilon = epsilon;

iterations = 500;
best_f_epsilon = f_epsilon;

for epsilon = linspace(0,0.1,iterations)

    f_epsilon = convolution(f,y_p,differences,epsilon,m,mol_eps);
    sq_sum = sum((f(y_p)-f_epsilon).^2);

    % Let's update the value of the square sum
    if sq_sum < min_sq_sum
        min_sq_sum = sq_sum;
        best_epsilon = epsilon;
        best_f_epsilon = f_epsilon;
    end

end


plot(y_p,best_f_epsilon,'--')
disp("Adjusted epsilon: "+string(best_epsilon))


function f_epsilon = convolution(f,y_p,differences,epsilon,m,mol_eps)

    % Let's define the step size in the integral approximations
    dy = abs(y_p(2)-y_p(1));

    % Let's implement the piecewise functions using logical operations
    ind1 = abs(y_p) < 1;
    ind2 = abs(differences/epsilon) < 1;
    ind = ind1.*ind2;

    % Let's initialize a vector for the values of the mollified function.
    f_epsilon = zeros(m,1);

    % Let's make a loop where we calculate the values of the mollified
    % function
    for i = 1:length(y_p)
        % Let's find the indexes where the mollifier function and f have
        % non-zero values
        non_zero_index = find(ind(:,i) > 0);
        y = y_p(non_zero_index);
        difference = differences(non_zero_index,i);
        % Let's calculate the integral
        f_epsilon(i) = dy*sum(f(y).*mol_eps(epsilon,difference));
    end
end











