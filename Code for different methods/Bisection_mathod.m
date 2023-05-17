clc, clear;

vl              = 1;                                % Initial guess for left boundary of interval
vu              = 5;                                % Initial guess for right boundary of interval
v_root          = vu;
v_root_prev     = vu;
tol             = 1e-6;                             % Relative tolerance
error           = 10;


while error > tol
    v_root              = 0.5*(vu+vl);
    
    if myFunction(vl)*myFunction(v_root) < 0
        vu                  = v_root;
    else
        vl                  = v_root;
    end
    
    error               = abs((v_root-v_root_prev)/v_root);
    v_root_prev         = v_root;
end

fprintf('Root: %f.\n',v_root);


function f = myFunction(v)
R               = 0.518*1e3;
T               = -50+273.15;
Tc              = 191;
Pc              = 4580*1e3;
P               = 65000;
a               = 0.427*R^2*Tc^2.5/Pc;
b               = 0.0866*R*Tc/Pc;
f               = P - R*T/(v-b) + a/(v*(v+b)*sqrt(T));
end