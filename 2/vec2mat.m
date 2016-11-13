function res = vec2mat(v, n, m)
    res = zeros(n, m);
    for i = 1 : n
        for j = 1 : m
            res(i, j) = v((i - 1) * m + j);
        end
    end
end
