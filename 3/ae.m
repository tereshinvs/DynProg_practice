function [T, xc, Xc] = ae()
    global x0 X0 t0 t1 gamma N
    options = odeset('RelTol',1e-2,'AbsTol',1e-4);
    odevec = make_ode_vec(inv(X0), x0, 0);
    
    T = (t0 : (t1 - t0) / 10 : t1)';
    
    xc = [];
    Xc = [];
    
    gamma = @(t) 0.9 * t.^2;
    [~, tres] = ode45(@ae_right_part, T, odevec, options);
    beta = get_beta(gamma, T, tres(:, N * N + N + 1));
    beta = repmat(beta, [N*N 1])
    xc = [xc; tres(:, N * N + 1 : N * N + N)'];
    Xc = [Xc; tres(:, 1 : N * N)'./beta];

    gamma = @(t) 1./t.^2;
    [~, tres] = ode45(@ae_right_part, T, odevec, options);
    beta = get_beta(gamma, T, tres(:, N * N + N + 1));
    beta = repmat(beta, [N*N 1])
    xc = [xc; tres(:, N * N + 1 : N * N + N)'];
    Xc = [Xc; tres(:, 1 : N * N)'./beta];

    gamma = @(t) 1.5./t;
    [~, tres] = ode45(@ae_right_part, T, odevec, options);
    beta = get_beta(gamma, T, tres(:, N * N + N + 1));
    beta = repmat(beta, [N*N 1])
    xc = [xc; tres(:, N * N + 1 : N * N + N)'];
    Xc = [Xc; tres(:, 1 : N * N)'./beta];

%     gamma = @(t) t;
%     [~, tres] = ode45(@ae_right_part, T, odevec, options);
%     beta = get_beta(gamma, T, tres(:, N * N + N + 1));
%     beta = repmat(beta, [N*N 1])
%     xc = [xc; tres(:, N * N + 1 : N * N + N)'];
%     Xc = [Xc; tres(:, 1 : N * N)'./beta];
% 
%     gamma = @(t) exp(t);
%     [~, tres] = ode45(@ae_right_part, T, odevec, options);
%     beta = get_beta(gamma, T, tres(:, N * N + N + 1));
%     beta = repmat(beta, [N*N 1])
%     xc = [xc; tres(:, N * N + 1 : N * N + N)'];
%     Xc = [Xc; tres(:, 1 : N * N)'./beta];
end
