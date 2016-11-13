function res = make_ode_vec(P, x, h)
    res = [reshape(P, [size(P, 1) * size(P, 2) 1]); x; h];
end