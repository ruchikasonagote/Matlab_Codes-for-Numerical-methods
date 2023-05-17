clc, clear all; hold on; box on;

N = 10;                                                                    % Specify the number of grid points
x   =  linspace(0, 1, N);                                                  % Generate grid points 
dx = x(2) - x(1);                                                          % Grid size
uL = 0;                                                                    % Left boundary condition
uR = 1;                                                                    % Left boundary condition
p = 10;                                                                    % The perameter 'p' in the eqaution
% p = 20;
% p = 50;
% p = 100;

% Initiate the matrix A and B
A = zeros(N,N);
B = zeros(N,1);

% Define the fucntion a(x) and b(x) and c(x)
a = ones(N,1);
b = zeros(N,1);
c = zeros(N,1);
for k1 = 2:N-1
    b(k1)   = 1/x(k1);
    c(k1)   = -2*p/x(k1);
end
f = zeros(N,1);

% Define the matrices A and B
A(1,1) = 1;         % For Left boundary condition
B(1,1) = uL;
A(N,N) = 1;            % For Right boundary condition
B(N,1) = uR;

for i = 2:N-1
    A(i,i-1) = a(i,1) - 0.5*b(i,1)*dx;
    A(i,i) = -2*a(i,1) + c(i,1)*dx^2;
    A(i,i+1) = a(i,1) + 0.5*b(i,1)*dx;

    B(i,1) = f(i,1)*dx^2;
end

u = GaussElm(A,B);     % Solve the system of linear eqaution

plot(x,u,'-o','linewidth',2);
xlabel('$x$','Interpreter','Latex','Fontsize',24);
ylabel('$u$','Interpreter','Latex','Fontsize',24);

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




