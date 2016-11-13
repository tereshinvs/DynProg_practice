function [T, xc, Xc] = solve(l1, T)
    global N Nu Nv T0 T1 A B C x1 X1 p P q Q options

    [~, xc] = ode45(@(t, xc) A(t) * xc + B(t) * p(t) + C(t) * q(t), T, x1, options);
    [~, l_Xc] = ode45(@shape_right_part, T, [l1; mat2vec(X1)], options);
    Xc = l_Xc(:, N + 1 : end);
end
