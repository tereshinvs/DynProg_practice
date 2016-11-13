function plot_dynamic_reach_tube(T, Te, xc, Xc, fl1, fl2, dphi)
    global N
    
    phi = [0 : dphi : (2 * pi) 0];
    tres = zeros(size(T, 2), size(phi, 2));
    xres = zeros(size(T, 2), size(phi, 2));
    yres = zeros(size(T, 2), size(phi, 2));
    
    pos = 1;
    for i = 1 : size(T, 2)
        l1 = fl1(T(i));
        l2 = fl2(T(i));
        l1 = l1 / norm(l1);
        l2 = l2 - scalar_mult(l2, l1) * l1;
        for j = 1 : size(phi, 2)
            curpos = pos;
            dir = l1 * cos(phi(j)) + l2 * sin(phi(j));
            dist = 0;
            distv = dir;
            
            while curpos < size(Te, 1) && abs(Te(curpos) - T(i)) < 1e-6
                xct = xc(curpos, :)';
                Xct = vec2mat(Xc(curpos, :), N, N)';
                if norm(Xct) < 1e-4
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
                curpos = curpos + 1;
            end
            
            tres(i, j) = T(i);
            xres(i, j) = scalar_mult(distv, l1);
            yres(i, j) = scalar_mult(distv, l2);
        end
        pos = curpos;
    end
    
    surf(tres, xres, yres, 'FaceAlpha', 0.5, 'FaceColor', 'g');
    xlabel('t');
    ylabel('x');
    zlabel('y');
end
