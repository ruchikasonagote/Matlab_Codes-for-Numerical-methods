clc, clear; hold on; hold all; box on; 

tspan = [0 50];                                                            % Define the starting time and the end time
dt = 1e-3;                                                                 % Time step - remains uniform
N = (tspan(2)-tspan(1))/dt+1;                                              % Number of time instances 
num_steps = N-1;                                                           % Number of time steps
p = 4;              % initial condition
% p = 8;
% p = 0.1;
y_init = [p 0];                                                            % The initial condition
t = zeros(N,1);                                                            % Initiate the time vector 
y = zeros(N,length(y_init));                                               % Initiate the solution matrix (Nx2)
mu = 0.1;                                                                  % Define the parameter mu
% mu = 1;
% mu = 4.5;
% Assign the initial conditions to the solution matrix
for j1 = 1:length(y_init)
    y(1,j1) = y_init(j1);
end

% Implementation of the Rk4 method
for i = 1:num_steps
    t(i+1) = t(i) + dt;
    k1 = MyODE(t(i),y(i,:),mu);                    % Define k1 
    k2 = MyODE(t(i)+dt/2,y(i,:)+0.5*k1*dt,mu);     % Define k2
    k3 = MyODE(t(i)+dt/2,y(i,:)+0.5*k2*dt, mu);     % Define k3
    k4 = MyODE(t(i)+dt/2,y(i,:)+ k3*dt, mu);        % Define k4
    y(i+1,:) = y(i,:)+1/6*(k1+2*k2+2*k3+k4)*dt; 
end

% For plotting 
figure(1), plot(t,y(:,1),'linewidth',1.5); hold on;
figure(2), plot(y(:,1),y(:,2)); hold on;

% ODE
% .y1 = y2
% .y2 = mu(1-y1^2)y2 - y1;

% Define the ODEs
function ydot = MyODE(t,y,mu) 
    ydot = zeros(size(y));                                                 % Initiatee ydot
    ydot(1) = y(2);                                                        % f1(t,y)
    ydot(2) = mu*(1-y(1)^2)*y(2)-y(1);                                     % This is f2(t,y)
end










