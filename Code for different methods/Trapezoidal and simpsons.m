clc, clear all;

% Enter the data here --------------------------------------
num_interval    = 10000000;                                                     % A large number of intervals should be good enough
y               = 1;
x_data          = linspace(y-500,y,num_interval+1);                         % Instead of infinity, take a large negative number as the lower limit
FVal            = 1/sqrt(2*pi)*exp(-x_data.^2/2);

% --------------------------------------------------------------------------
% The trapezoidal rule is implemented below. 
% ---------------------------------------------------------------------

Int_isequal     = 1;                                                        % Take input from the used whether the interval lengths are equal. 1 for yes and 0 for a no.
Data(:,1)       = x_data';                                                  % Collate the x-data and the function value into a single matrix
Data(:,2)       = FVal';
Data            = sortrows(Data,1);                                         % Sort the data, if not sorted already
a               = Data(1,1);
b               = Data(end,1);
F_dobl_derv     = -x_data.*exp(-x_data.^2/2)/sqrt(2*pi);    % double derivative
Error(:,1)      = F_dobl_derv; 

if Int_isequal == 1
    h               = (b-a)/num_interval;                                   % Interval length;
    int_val         = Data(1,2)*h/2+Data(end,2)*h/2+h*sum(Data(2:end-1,2)); % Compute the integral using the trapezoidal rule
else
    int_val         = 0;                                                    % Initiate the integral in the numerator
    for k1 = 1:num_interval
        int_val         = int_val + 0.5*(Data(k1+1,1)-Data(k1,1))*(Data(k1+1,2)+Data(k1,2));    % Compute the integral by adding the contributions from each interval
    end
end

E = (-((b-a)^3)/(12*num_interval^2))*(sum(Error(:,1)));
fprintf('Integral value for y = %f using the Trapezoidal rule, I = %f.\n',y,int_val);
fprintf('Error: %d.\n',E);

% --------------------------------------------------------------------------
% The Simpson's 1/3 rule is implemented below for intervals of equal size.
% ---------------------------------------------------------------------

Data(:,1)       = x_data';                                                  % Collate the x-data and the function value into a single matrix
Data(:,2)       = FVal';
Data            = sortrows(Data,1);                                         % Sort the data, if not sorted already
F_four_derv     = ((x_data.^4 - 6.*(x_data.^2) + 3).*exp(-x_data.^2/2))/sqrt(2*pi);
Error(:,2)      = F_four_derv;
E1 = (((b-a)^5)/(180*num_interval^4))*(sum(Error(:,2)));

if mod(num_interval,2)==0
    h               = (Data(end,1)-Data(1,1))/num_interval;                 % Interval length
    Int_val         = h/3*(Data(1,2)+Data(end,2)+4*sum(Data(2:2:num_interval,2))+2*sum(Data(3:2:num_interval-1,2)));        % Compute the integral's value by summing up the contributions from all the intervals
else
    fprintf('The number of intervals is not even. Hence I shall apply the Simpsons rule to the first %i intervals \nand trapezoidal rule will be applied for the last interval.\n',...
        num_interval-1);
    n1              = num_interval-1;
    h               = (Data(end,1)-Data(1,1))/num_interval;                % Interval length
    % Compute the integral's value by summing up the contributions from
    % upto the (n-1)-th interval and for the final interval apply
    % trapezoidal rule
    Int_val         = h/3*(Data(1,2)+Data(end-1,2)+4*sum(Data(2:2:num_interval-1,2))+2*sum(Data(3:2:num_interval-2,2)))+h/2*(Data(end-1,2)+Data(end,2));        
end

fprintf('Integral value for y = %f using the Simpsons 1/3 rule, I = %f.\n',y,Int_val);
fprintf('Error: %d.\n',E1);
