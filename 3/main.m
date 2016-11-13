clear

global N x0 X0 A C G R q Q t0 t1 y hi

N = 2;

x0 = [0; 0];
X0 = [1 0; 0 1];

A = @(t) [0 0; 0 -1];
C = @(t) [1; 0.5];
G = @(t) [1 0; 0 -1];

R = @(t) [1];

q = @(t) 1;
Q = @(t) 1;

t0 = 1;
t1 = 4;

hi = @(t) 1;

solve = @ae;

l1 = [1; 0];
l2 = [0; 1];

hold on
grid on

G = @(t) [1 1; 0 -1];
y = @(t, x) G(t) * x;
[T, xc, Xc] = solve();
%Xc(:, end)
%plot_static_reach_tube(T, xc, Xc, l1, l2, 5e-2, 'g');
plot_static_reachset(xc(:, end), Xc(:, end), l1, l2, 1e-2);

G = @(t) [0 0; -1 1];
y = @(t, x) G(t) * x;
[T, xc, Xc] = solve();
%plot_static_sreach_tube(T, xc, Xc, l1, l2, 5e-2, 'r');

G = @(t) [-1 1; 0 1];
y = @(t, x) G(t) * x;
[T, xc, Xc] = solve();
%plot_static_reach_tube(T, xc, Xc, l1, l2, 5e-2, 'b');
%plot_static_reachset(xc(:, end), Xc(:, end), l1, l2, 1e-2);
