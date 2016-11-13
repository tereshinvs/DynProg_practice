function res = ellipsoid_rho(xc, Xc, dir)
    res = scalar_mult(xc, dir) + sqrt(scalar_mult(dir, Xc * dir));
end
