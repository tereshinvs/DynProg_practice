clear

L = 1.0;
L1 = 2.0;
L2 = 3.0;

C1 = 2.0;
C2 = 2.5;

U10 = 1.0;
U20 = 1.0;
I10 = 1.0;
I20 = 1.0;

Umax = 5.0;

timeVec = [0 40.0];
regTol = 1e-3;

D = L1 * L2 + L * (L1 + L2);
aMat = [0 0 -(L + L2)/D -L/D; ...
        0 0 -L/D -(L + L1)/D; ...
        1/C1 0 0 0; ...
        0 1/C2 0 0];
  
lambda = eig(aMat)

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4 1e-4]);
%[T, Y] = ode45(@(t, x) aMat * x, timeVec, [U10, U20, I10, I20], options);
[T, Y] = ode45(@(t, x) aMat * x, timeVec, [I10, I20, U10, U20], options);

plot(T, Y(:, 4));
xlabel('t');
ylabel('x_4');
