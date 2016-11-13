function [T, xc, Xc] = static_projection(l1, l2, T_, dphi)
    global N Nu Nv T0 T1 A B C x1 X1 p P q Q dT options
    
    l1 = l1 / norm(l1);
    l2 = l2 - scalar_mult(l2, l1) * l1;
    
    T = [];
    xc = [];
    Xc = [];

    phi = 0 : dphi : (2 * pi);
    
    for j = 1 : size(T_, 2)
        j
        size(T_, 2)
        for i = 1 : size(phi, 2)
            l = l1 * cos(phi(i)) + l2 * sin(phi(i));
            if j > 1
                [~, lv] = ode45(@(t, x) -A(t)' * x, [T_(j) T_(1)], l, options);
                [~, xctmp, Xctmp] = solve(lv(end, :)', T_(1 : j));
            else
                xctmp = x1';
                Xctmp = mat2vec(X1)';
            end
            if norm(vec2mat(Xctmp, N, N)) < 1e-2
                %Xctmp = 0.01 * eye(N);
                continue;
            end
            if size(T, 1) > 0
                T = [T; T_(j)];
                xc = [xc; xctmp(end, :)];
                Xc = [Xc; Xctmp(end, :)];
            else
                T = T_(j);
                xc = xctmp(end, :);
                Xc = Xctmp(end, :);
            end
        end
    end
end
