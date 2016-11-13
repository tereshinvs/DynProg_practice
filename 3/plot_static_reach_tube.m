function plot_static_reach_tube(T, xc, Xc, l1, l2, dphi, color)
    global N
    
    l1 = l1 / norm(l1);
    l2 = l2 - scalar_mult(l2, l1) * l1;
    
    phi = [0 : dphi : (2 * pi) 0];
    tres = zeros(size(T, 2), size(phi, 2));
    xres = zeros(size(T, 2), size(phi, 2));
    yres = zeros(size(T, 2), size(phi, 2));
    
    for i = 1 : size(T, 1)
        for j = 1 : size(phi, 2)
            dir = l1 * cos(phi(j)) + l2 * sin(phi(j));
            dist = 0;
            distv = dir;
            
            1 : size(xc, 1) / N
            for k = 1 : size(xc, 1) / N
                xct = xc((k - 1) * N + 1 : k * N, i);
                Xct = inv(vec2mat(Xc((k - 1) * N*N + 1 : k * N*N, i), N, N));
                if norm(Xct) < 1e-6
                    tdist = 0;
                    tvect = xct;
                else
                    tdir = inv(Xct) * dir;
                    tdist = sqrt(scalar_mult(tdir, Xct * tdir));
                    tvect = xct + Xct * tdir / tdist;
                end
                if tdist > dist
                    dist = tdist;
                    distv = tvect;
                end
            end
            
            tres(i, j) = T(i);
            xres(i, j) = scalar_mult(distv, l1);
            yres(i, j) = scalar_mult(distv, l2);
        end
    end

    surf(tres, xres, yres, 'FaceAlpha', 0.5, 'FaceColor', color);
    xlabel('t');
    ylabel('l_1');
    zlabel('l_2');
end
