function [P, x, h] = decompose_ode_vec(y)
    global N
    P = reshape(y(1 : N*N), [N N]);
    x = y(N*N + 1 : N*N + N);
    h = y(N*N + N + 1 : end);
end
