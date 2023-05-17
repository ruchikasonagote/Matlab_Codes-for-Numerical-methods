clc, clear;
%secant method
x0 = 0.4;
x1 = 0.5;
x_root = 1;
error = 10;
tol = 1e-6;
count = 0;
max_itr = 1000;
flag  = 0;

while error > tol
    x_root = x1 - (fun(x1)*(x1 - x0))/(fun(x1) - fun(x0));
    error = abs((x_root - x0)/x_root);
    x0 = x1;
    x1 = x_root;
    count = count + 1;
    if count > max_itr
        fprintf("maximum number of allowed iterations exceeded\n");
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
   f = 7*sin(x)*exp(-x) - 1;
end
