function [T, res] = be()
    global x0 X0 t0 t1
    options = odeset('RelTol',1e-4,'AbsTol',1e-4);
    odevec = make_ode_vec(inv(X0), x0, 0);
    [T, res] = ode45(@be_right_part, [t0 t1], odevec);
end
