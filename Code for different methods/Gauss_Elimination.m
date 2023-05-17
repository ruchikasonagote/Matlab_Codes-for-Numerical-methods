clc, clear;
% Gauss elimination

% Define the coefficient matrix
% A = [100 -50 50; 50 -130 80; 0 -80 80];
k1 = 100;
k2 = 50;
k3 = 80;
k4 = 200;
A = [k1+k2 -k2 0 0; k2 -(k2+k3) -k3 0; 0 -k3 k3+k4 -k4; 0 0 -k4 k4];
% Define the RHS Source vector
B = [0; 0; 0; 2000];

X = GaussElm(A,B);                                                         %Function call to solve the eqaution AX = B using Gauss Elimination

fprintf('Root: %f.\n',X);

function X = GaussElm(A,B)
n = length(B);                                                             % Length of the vector B - Number of equations  
X = zeros(n,1);                                                            % Initiate the solution

% Forward Elimination
for k1 = 1:n-1                                                             % Loop across the pivot rows
    for k2 = k1+1:n                                                      % Second loop scanning across the rows below the pivot
        ratio = A(k2,k1)/A(k1,k1);                                         % Define the multiplier for each row below the pivot
        for k3 = k1:n                                                      % The third loop to implement the row substraction
            A(k2,k3) = A(k2,k3) - ratio*A(k1,k3);                          % Row Substraction
        end
        B(k2,1)  = B(k2,1) - ratio*B(k1,1);                                % Update the RHS Source Vector
    end    
end

% Backward Substitution
X(n,1) = B(n,1)/A(n,n);                                                    % n-th element of the solution
%Xj = (Bj - Sum(Ajk*Xk))/Ajj;
for k1 = n-1:-1:1
    Sum = 0;
    for k2 = k1+1:n                                                        % To carry out the sum in numerator
        Sum = Sum + A(k1,k2)*X(k2,1);
    end
    X(k1,1) = (B(k1,1) - Sum)/A(k1,k1);
end


end
