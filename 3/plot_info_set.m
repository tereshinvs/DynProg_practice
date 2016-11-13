function plot_info_set(T, E)
    global N;
    for i = 1 : size(T, 2)
        for j = 1 : size(E, 1) / (N * N + N)
            [P, x, ~] = decompose_ode_vec(E(j * (N * N + N) + 1 : (j + 1) * (N * N + N)));
        end
    end
end