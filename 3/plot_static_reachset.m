function plot_static_reachset(xc, Xc, l1, l2, dphi)
    global N
    hold on
    
    l1 = l1 / norm(l1);
    l2 = l2 - scalar_mult(l2, l1) * l1;
    
    phi = [0 : dphi : (2 * pi) 0];

    for i = 1 : size(xc, 1)/N
        xres = zeros(size(phi, 2));
        yres = zeros(size(phi, 2));
        xct = xc(((i - 1) * N + 1) : i * N);
        Xct = inv(vec2mat(Xc(((i - 1) * N*N + 1) : i * N*N), N, N)');
        for j = 1 : size(phi, 2)
            dir = l1 * cos(phi(j)) + l2 * sin(phi(j));
            tvect = xct + dir / sqrt(scalar_mult(dir, inv(Xct) * dir));
            xres(j) = scalar_mult(tvect, l1);
            yres(j) = scalar_mult(tvect, l2);
        end

        plot(xres, yres);
    end
    
    xres = zeros(size(phi, 2));
    yres = zeros(size(phi, 2));

    for j = 1 : size(phi, 2)
        dir = l1 * cos(phi(j)) + l2 * sin(phi(j));
        dist = 0;
        distv = dir;
            
       for i = 1 : size(xc, 1)/N
            xct = xc(((i - 1) * N + 1) : i * N);
            Xct = inv(vec2mat(Xc((i - 1) * N*N + 1 : i * N*N), N, N));
            tdir = inv(Xct) * dir;
            tdist = sqrt(scalar_mult(tdir, Xct * tdir));
            tvect = xct + Xct * tdir / tdist;
            if tdist > dist
                dist = tdist;
                distv = tvect;
            end
        end
            
        xres(j) = scalar_mult(distv, l1);
        yres(j) = scalar_mult(distv, l2);
    end

    plot(xres, yres, 'r');
    xlabel('l_1');
    ylabel('l_2');
end
