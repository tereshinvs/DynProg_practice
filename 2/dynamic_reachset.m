function [xc, Xc] = dynamic_reachset(fl1, fl2, T1, t, dphi)
    global N Nu Nv T0 T1 A B C x1 X1 p P q Q dT options

    l1 = fl1(t);
    l2 = fl2(t);
    l1 = l1 / norm(l1);
    l2 = l2 - scalar_mult(l2, l1) * l1;

    xc = [];
    Xc = [];

    phi = 0 : dphi : (2 * pi);

    for i = 1 : size(phi, 2)
        l = l1 * cos(phi(i)) + l2 * sin(phi(i));
        [~, lv] = ode45(@(t, x) -A(t)' * x, [t T1], l, options);
        [~, xctmp, Xctmp] = solve(lv(end, :)', T1 : -dT : t);
        if norm(vec2mat(Xctmp, N, N)) < 1e-2
            Xctmp = mat2vec(0.01 * eye(N));
        end
        if size(xc, 1) > 0
            xc = [xc; xctmp(end, :)];
            Xc = [Xc; Xctmp(end, :)];
        else
            xc = xctmp(end, :);
            Xc = Xctmp(end, :);
        end
    end
end
