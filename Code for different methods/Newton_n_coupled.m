x0 = [1 2]';                                                               %initial guess
tol = 1e-5;                                                                %relative error
error = 10;                                                                %initila error
count = 0;
max_iter = 1000; 

% Solve : Derivative*Y = Fval
% Y = Derivative^(-1)* Fval;

while error > tol 
    Fval = myFunction(x0);                                                  % Evaluate the given equations using the previous iterations
    Derivative = myFunctionDerv(x0);                                        % Evaluate the LHS 2x2 using the previous iteration
    y = Derivative\Fval;                                                    % Corrections at the current iteration, by solving a  
    x_root = x0 - y;                                                        % Desired value of the roots in the curretn iteration 
    error = max(abs((x_root - x0)./x_root));                                % Maximum relative error 
    x0 = x_root;                                                            % Update the previous iteration of root
    if count > max_iter
        fprintf("Max number of allowed iterations exceeded, solution not found");
        break;
    end
end

fprintf("Root : %f.\n",x_root); 

function f = myFunction(x)
f(1,1) = (x(1) - 4)^2 + (x(2) - 4)^2 - 5;
f(2,1) = x(1)^2 + x(2)^2 - 16;
end

function m = myFunctionDerv(x)
m(1,1) = 2*(x(1) - 4);
m(1,2) = 2*(x(2) - 4);
m(2,1) = 2*x(1);
m(2,2) = 2*x(2);
end