%% 4.1
% Leibniz rule task
clc
close all
clear
% Define two functions C^k(R^2)
syms x y
f(x,y) = x^2+y^2;
g(x,y) = exp(x+y);

% Define the order of differentiation for each variable
alpha = [4,3];

%Evaluation point
x_diff = [1,1];

% Compute the derivative using General Leibniz Rule
D_alpha_fg = general_leibniz_rule(f, g, alpha, x_diff, [x,y]);

% Check
% h(x,y) = f(x,y)*g(x,y);
% dhx(x,y) = diff(h,x,alpha(1));
% dhxy(x,y) = diff(dhx,y,alpha(2));
% dhxy(x_diff(1),x_diff(2));


function D_alpha_fg = general_leibniz_rule(f, g, alpha, x_diff, var)
    % Initialize the result
    D_alpha_fg = 0;
    
    x = var(1);
    y = var(2);
    % Generate all multi-indices beta such that beta <= alpha
    betas = generate_multi_indices(alpha);

    % Loop over all beta multi-indices
    for i = 1:size(betas, 1)
        beta = betas(i,:);
        alpha_minus_beta = alpha-beta;
        
        % Compute the multinomial coefficient
        coeff = multinomial_coeff(alpha, beta);
        
        % Implement symbolic derivation logic:
        Df_abx = diff(f,x,alpha_minus_beta(1));
        Df_abxy = diff(Df_abx,y,alpha_minus_beta(2));

        Dg_bx = diff(g,x,beta(1));
        Dg_bxy = diff(Dg_bx,y,beta(2));

        A = subs(Df_abxy,[x,y],x_diff);
        B = subs(Dg_bxy,[x,y],x_diff);

 
        % Update the solution value,alpha_minus_beta(1)                                                
        D_alpha_fg = D_alpha_fg + coeff*A*B;

    end
end

function coeff = multinomial_coeff(alpha, beta)
    coeff_f = @(j) factorial(alpha(j))...
        /(factorial(beta(j))*factorial(alpha(j)-beta(j)));
    coeff = coeff_f(1)*coeff_f(2);
end

function indices = generate_multi_indices(alpha)        
    % Generate all multi-indices beta such that beta <= alpha

    k = max(alpha);
    n = factorial(k+1)/factorial(k+1-2);                                  
    indices = zeros(n,2);

    lineStart = 1;
    lineEnd = 0;
    
    for i = 1:alpha(1)+1  
        lineEnd = lineEnd + alpha(2)+1;
        indices(lineStart:lineEnd,1) = i-1;
        indices(lineStart:lineEnd,2) = 0:alpha(2);
        lineStart = lineStart + alpha(2)+1;
    end
   
    % Let's take empty lines out
    if lineEnd < n
        indices = indices(1:lineEnd,:);
    end
end

