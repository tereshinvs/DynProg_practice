function plot_ellipsoid_tube(t, xc, Xc, dir1, dir2, dphi)
    global N
    
    dir1 = dir1 / norm(dir1);
    dir2 = dir2 - scalar_mult(dir2, dir1) * dir1;
    
    phi = [0 : dphi : (2 * pi) 0];
    tres = zeros(size(t, 2), size(phi, 2));
    xres = zeros(size(t, 2), size(phi, 2));
    yres = zeros(size(t, 2), size(phi, 2));
    for i = 1 : size(t, 2)
        xct = xc(i, :)';
        Xct = vec2mat(Xc(i, :), N, N);
        for j = 1 : size(phi, 2)
            dir = dir1 * cos(phi(j)) + dir2 * sin(phi(j));
            %dist = ellipsoid_rho(xct, Xct, dir)
            dirres = xct + Xct * dir / sqrt(scalar_mult(dir, Xct * dir));
            tres(i, j) = t(i);
            xres(i, j) = scalar_mult(dirres, dir1);
            yres(i, j) = scalar_mult(dirres, dir2);
        end
    end
    
    tres;
    xres;
    yres;
    surf(tres, xres, yres, 'FaceAlpha', 0.5, 'FaceColor', 'g');
    xlabel('t');
    ylabel('x');
    zlabel('y');
end
