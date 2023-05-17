clc, clear;
%newtons method
%x0 = 8;
%x0 = 6;
x0 = 2;
x_root = 1;
error = 10;
tol = 1e-6;
count = 0;
max_itr = 1000;
flag = 0;

while error > tol
    f = fun(x0);
    x_root = x0 - f.Fval/f.derivative;
    error = abs((x_root - x0)/x_root);
    x0 = x_root;
    count = count + 1;
    if count > max_itr
        fprintf("maximum number of iterations excceeded\n");
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
   f.Fval = (exp(-0.5*x))*(4 - x) - 2;
   f.derivative = exp(-0.5*x)*(0.5*x - 3);
end
