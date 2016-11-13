function res = rotate_matrix(v2, v1)
    global N
    
    v1 = v1 / norm(v1);
    v2 = v2 / norm(v2);
    
    c = scalar_mult(v1, v2);
    s = sqrt(1 - c^2);
    S = [c s; -s c];
    q1 = v1;
    if abs(s) < 1e-6
        q2 = zeros(N, 1);
    else
        q2 = 1/s * (v2 - c * v1);
    end
    Q1 = [q1 q2];
    res = eye(N) + Q1 * (S - eye(2)) * Q1';
end
