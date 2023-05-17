%fixed point interations
clc, clear;
x0              = 0.5;                        % Initial guess
x_root          = 1;                        
error           = 10;
tol             = 1e-5;                     % The relative tolerance
count           = 0;
max_iter        = 1000;
flag = 0;

while error > tol
    
    x_root          = myFunction(x0);
    error           = abs((x_root-x0)/x_root);
    x0              = x_root;
    count           = count+1;
    if count>max_iter
        fprintf('Max. no. of allowed interations exceeded.\n');
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

function f = myFunction(x)

Q               = 5;
S               = 0.0002;
B               = 20;
n               = 0.03;
f               = (Q*n/sqrt(S))^(3/5)*(B+2*x)^(2/5)/B;

end
