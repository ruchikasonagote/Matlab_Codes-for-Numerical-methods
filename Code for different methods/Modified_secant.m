clc, clear;
% modified secant method
x0 = 0.5825;
dx = 0.05;   % small dx
x_root = 1;
error = 10;
tol = 1e-6;
count = 0;
max_itr = 1000;
flag  = 0;

while error > tol
    x_root = x0 - (fun(x0)*dx)/(fun(x0 + dx) - fun(x0));
    error = abs((x_root - x0)/x_root);
    x0 = x_root;
    count = count + 1;
    if count > max_itr
        fprintf("Maximum number of allowed iterations exceeded\n");
        flag = 1;
        break;
    end
end

if flag == 0
    fprintf('Root: %f.\n',x_root);
    fprintf("Error : %f.\n",error);
else
    fprintf('Solution not found.\n');
end

function f = fun(x)
   f = x^5 + 16.05*x^4 + 88.75*x^3 - 132.0375*x^2 + 116.35*x + 31.6875;
end
