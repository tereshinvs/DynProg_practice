function res = get_beta(gamma, T, h)
    res = 1 - h;
    for i = 2 : size(T, 1)
        res(i) = res(i) + trapz(T(1:i), gamma(T(1:i)).^2 + 1);
    end
    res = res';
end