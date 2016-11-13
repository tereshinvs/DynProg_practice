clear
warning('off','all')
global N Nu Nv T0 T1 A B C x1 X1 p P q Q dT options l1 l2 dphi

% N = 4;
% Nu = 2;
% Nv = 2;
% 
% T0 = 0;
% T1 = 6;
% dT = 0.5;
% t = 0;
% 
% A = @(t) 0.1 * [1 0 1 0; 0 1 0 3; 0 0 2 0; 0 0 0 1];
% B = @(t) [1 0; 0 1; 0 0; 0 0];
% C = @(t) [1 0; 0 1; 0 0; 0 0];
% 
% x1 = [0; 0; 0; 0];
% X1 = eye(N);
% 
% p = @(t) [0; 0];
% P = @(t) eye(Nu);
% 
% q = @(t) [0; 0];
% Q = @(t) eye(Nv);
% 
% options = odeset('RelTol', 1e-3,'AbsTol', 1e-3);
% 
% l1 = [1; 0; 0; 0];
% l2 = [0; 0; 1; 0];
% dphi = 0.5;

N = 4;
Nu = 4;
Nv = 1;

T0 = 0;
T1 = 10;
dT = 0.5;

A = @(t) 0.1 * sin(t) * eye(N);
B = @(t) [1 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0];
C = @(t) [0.1; 0.2; 0.1; 0.1];

x1 = [0; 0; 0; 0];
X1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

p = @(t) [0; 0; 0; 0];
P = @(t) [20 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

q = @(t) [0];
Q = @(t) [0.1];

options = odeset('RelTol', 1e-5,'AbsTol', 1e-5);

%l1 = [1; 0; 0; 0];
%l2 = [0; 1; 0; 0];
l1 = @(t) [1; 0; 0; 0];
l2 = @(t) [0; 0; sin(t); cos(t)];
dphi = 0.3;

t = 0;

% N = 4;
% Nu = 1;
% Nv = 1;
% 
% L = 5.0;
% L1 = 1.0;
% L2 = 3.0;
% 
% C1 = 1.0;
% C2 = 4.0;
% 
% U10 = 0.1;
% U20 = 0.1;
% I10 = 0.2;
% I20 = 0.2;
% 
% Umax = 1.0;
% 
% T0 = 0;
% T1 = 30.0;
% dT = 0.5;
% 
% D = L1 * L2 + L * (L1 + L2);
% 
% A = @(t) [0 0 -(L + L2)/D -L/D; ...
%         0 0 -L/D -(L + L1)/D; ...
%         1/C1 0 0 0; ...
%         0 1/C2 0 0];
% 
% B = @(t) [L/D; ...
%         (L+L1)/D; ...
%         0; ...
%         0];
% C = @(t) [0; 0; 0; 0];
% 
% x1 = [I10; I20; U10; U20];
% X1 = 0.01 * eye(N);
% 
% p = @(t) [0];
% P = @(t) [Umax];
% 
% q = @(t) [0];
% Q = @(t) [1];

options = odeset('RelTol', 1e-5,'AbsTol', 1e-5);

l1 = [0; 0; 0; 1];
l2 = [0; 0; 1; 0];

dphi = 0.3;
 
t = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = T1 : -dT : T0;
[Te, xc, Xc] = static_projection(l1, l2, T, dphi);
plot_static_reach_tube(T, Te, xc, Xc, l1, l2, 0.1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%T = T1 : -dT : T0;
%[Te, xc, Xc] = dynamic_projection(l1, l2, T, dphi);
%plot_dynamic_reach_tube(T, Te, xc, Xc, l1, l2, 0.1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[xc, Xc] = static_reachset(l1, l2, T1, t, dphi);
%plot_static_reachset(xc, Xc, l1, l2, 0.01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[xc, Xc] = dynamic_reachset(l1, l2, T1, t, dphi);
%plot_dynamic_reachset(xc, Xc, l1, l2, t, 0.01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%l1 = [1; 0; 0];
%[T, xc, Xc] = solve(l1, T);

%dir1 = [1; 0; 0];
%dir2 = [0; 1; 0];
%dphi = 0.1;
%plot_ellipsoid_tube(T, xc, Xc, dir1, dir2, dphi);