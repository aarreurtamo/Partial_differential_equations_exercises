%% 2.2
clc
close all
clearvars

% Define the function
syms x y
f = 0.2*exp(0.5*x+3*y);

expansion_point =   [1,1];          
expansion_order = 5;           

% % Plot the original function

r = 0.5;
m = 50;
p_line = linspace(1-r,1+r,m);
[x_p,y_p] = meshgrid(p_line,p_line);
z_p = 0.2*exp(0.5*x_p+3*y_p);
m_o = mesh(x_p,y_p,z_p,'FaceAlpha','0.6',FaceColor='r');
hold on
xlabel("x")
ylabel("y")
zlabel("z")

% Go through each of the different expansion orders and plot each surface
for k = 1:expansion_order
    ts = taylor_series(f, [x,y], expansion_point, k);
    ts_p = matlabFunction(ts);
    z_p = ts_p(x_p,y_p);
    mesh(x_p,y_p,z_p,'FaceAlpha','0.6',FaceColor='none');
end


function ts = taylor_series(func, vars, point, k)
    % Initialize output
    taylor_expansion = 0;

    % Generate all values of alphas
    alphas = generate_combs(k);

    % Generate the series
    % Go through each tuple alpha (combination of derivatives)
    for i = 1:length(alphas) 
        cur_alpha = alphas(i,:);
        
        % Implement derivation logic:
        dfx = diff(func,vars(1),cur_alpha(1));
        df = diff(dfx,vars(2),cur_alpha(2));

        % Evaluate the value of the derivative at expansion point
        dval = subs(df,vars,point);
 
        % Generate one term of the Taylor expansion
        alpha_fac = factorial(cur_alpha(1))*factorial(cur_alpha(2));
        term = dval/alpha_fac*(vars(1)-point(1))^cur_alpha(1)...
            *(vars(2)-point(2))^cur_alpha(2);
        
        % Add the new term to the expansion
        taylor_expansion = taylor_expansion + term; 
    end
    ts = simplify(taylor_expansion);
end

function derivatives = generate_combs(k) 
    n = factorial(k+1)/factorial(k+1-2);
    derivatives = zeros(n,2);
    line = 1;
    for i = 1:k+1
        for j = 1:k+1
            if i == 1 && j == 1
                line = line+1;
            elseif ((i-1)+(j-1) <= k )
                derivatives(line,:) = [i-1,j-1];
                line = line+1;
            end
            
        end
    end
    if line < n
        if derivatives(line,1) == 0 && derivatives(line,2) == 0
            derivatives = derivatives(1:line-1,:);
        end
    end
end



