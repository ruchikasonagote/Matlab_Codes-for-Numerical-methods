clc, clear;
% Gauss-Seidel Iteration

n = 4;                                  % Number of eqautions
X_init = [0,0,0,0]';                  %Initial guess

k1 = 100;
k2 = 50;
k3 = 80;
k4 = 200;
% Define the LHS coefficient matrix
A = [k1+k2 -k2 0 0; k2 -(k2+k3) -k3 0; 0 -k3 k3+k4 -k4; 0 0 -k4 k4];

% Define the RHS Source vector
B = [0; 0; 0; 2000];

% Call the function to implement Gauss Seidel Iterations
X  =  GaussSeidel(A,B,X_init);

[roots, error, num_itr] = GaussSeidel(A,B,X_init);
fprintf('Roots: %f, %f, %f.\n',roots);
fprintf('Error: %f.\n',error);
fprintf('Iterations: %d.\n',num_itr);


% Define the function GaussSeidel
function [X, error, num_itr] = GaussSeidel(A,B,X_init)

num_itr = 0;
error  = 10;                % Initiate Relative Error
tol = 1e-4;                 % Relative Tolerance
X = zeros(size(X_init));    % Initiate the answer 
n = length(X);
X_prev = X_init;
temp_error = zeros(size(X));
while error > tol
% For computing the first element of the  next iteration
   Sum = 0;     
   for j = 2:n
        Sum = Sum + A(1,j)*X_prev(j,1);
   end
   X(1,1) = (B(1,1)-Sum)/A(1,1);
% For calculating the nth element of the next iteration
   for i = 2:n-1
        Sum1 = 0;
        Sum2 = 0;
        for j = 1:i-1
            Sum1 = Sum1 + A(i,j)*X(j,1);
        end
        for j = i+1:n
            Sum2 = Sum2 + A(i,j)*X_prev(j,1);
        end 
        X(i,1) = (B(i,1) - Sum1 - Sum2)/A(i,i);
   end
% For calculating the nth element of the next iteration
   Sum = 0;
   for j = 1:n-1
        Sum = Sum + A(n,j)*X(j,1);
   end
   X(n,1) = (B(n,1) - Sum)/A(n,n);

 % Define relative approximate error
    for i = 1:n
        if abs(X(i)) < 1e-6
            temp_error(i) = abs(X(i,1) - X_prev(i,1));
        else 
            temp_error(i) = abs((X(i,1) - X_prev(i,1))/X(i,1));
        end
    end
    error = max(temp_error);
% Updating the    
    X_prev = X;
    num_itr = num_itr + 1;
end


end
