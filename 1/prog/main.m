clear

L = 5.0;
L1 = 1.0;
L2 = 3.0;

C1 = 1.0;
C2 = 4.0;

U10 = 0.1;
U20 = 0.1;
I10 = 0.2;
I20 = 0.2;

Umax = 1.0;

elltool.conf.Properties.getAbsTol()
elltool.conf.Properties.getRelTol()
elltool.conf.Properties.setNTimeGridPoints(100)

timeVec = [0 30.0];
dirsMat = rand(4, 10);
regTol = 1e-3;
basisMat = [0 0 1 0; 0 0 0 1]';

D = L1 * L2 + L * (L1 + L2);

aMat = [0 0 -(L + L2)/D -L/D; ...
        0 0 -L/D -(L + L1)/D; ...
        1/C1 0 0 0; ...
        0 1/C2 0 0];

bMat = [L/D; ...
        (L+L1)/D; ...
        0; ...
        0];

uBoundsEllObj = Umax * ell_unitball(1);

lsys = elltool.linsys.LinSysContinuous(aMat, bMat, uBoundsEllObj);
x0EllObj = [I10; I20; U10; U20] + ellipsoid(zeros(4, 4));

rsObj = elltool.reach.ReachContinuous(lsys, x0EllObj, dirsMat, timeVec, ...
    'isRegEnabled', true, 'isJustCheck', false, 'regTol', regTol);
[ia, t] = rsObj.get_ia();
zero = ellipsoid(zeros(4, 4));
dst = zero.distance(ia);
touch = -1;
for i = 1 : size(t, 2)
    if all(dst(:, i) == 0)
        touch = i;
        break;
    end
end

psObj = rsObj.projection(basisMat);
plObj=smartdb.disp.RelationDataPlotter('figureGroupKeySuffFunc', ...
    @(x)sprintf('_tube_without_disturbance%d',x));

% plot the whole reach tube:
psObj.plotByEa('b', plObj); % to have the use of plObj isn’t necessary
%psObj.plotByEa(’g’);

if touch ~= -1
    t(touch)
    % ReachContinuous’s cut() doesn’t work with projections:
    psObj = psObj.cut(4);

    plObj=smartdb.disp.RelationDataPlotter('figureGroupKeySuffFunc', ...
        @(x)sprintf('set_without_disturbance%d',x));
    % plot reach set approximation at time t = 4:
    hold on;
    psObj.plotByEa('r', plObj); % to have the use of plObj isn’t necessary
    %psObj.plotByEa(’g’);end
    %plot(0, 0, 'MarkerEdgeColor', 'g', 'MarkerSize', 50);
end
