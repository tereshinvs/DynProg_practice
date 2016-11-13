function res = ae_right_part(t, u)
    global A C G y hi R q Q gamma
    [P, x, h] = decompose_ode_vec(u);
    At = A(t);
    Ct = C(t);
    Gt = G(t);
    Rt = R(t);
    yt = y(t, x);
    qt = q(t);
    Qt = Q(t);
    PP = -(P' * At + At' * P + ...
        1/gamma(t)^2 * P * Ct * Qt * Ct' * P - ...
        hi(t) * Gt' * Rt * Gt);
    if norm(P) < 1e-6
        P = zeros(size(P));
    end
    xx = At * x + Ct * qt + hi(t) * inv(P) * Gt' * Rt * (yt - Gt * x);
    hh = scalar_mult(yt - Gt * x, Rt * (yt - Gt * x));
    res = make_ode_vec(PP, xx, hh);
end
