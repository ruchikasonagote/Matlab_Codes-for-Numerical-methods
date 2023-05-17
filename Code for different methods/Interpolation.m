%langrange interplotation for polynomial 

clc, clear;
t=[700 720 740 760 780];
v=[0.0977 0.12184 0.14060 0.15509 0.16643];

n = length(t) - 1;
% the x for which y is needed
T = 750;  

sum = 0;
for i = 1:n+1
    L=1;
    for j= 1:n+1
        if j ~= i
            L=L*(T-t(j))/(t(i)-t(j));
        end
    end
    sum =sum +v(i)*L;
end
V = sum;
fprintf('Ans: %d.\n',V);