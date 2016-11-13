function res = mat2vec(A)
    res = zeros(size(A, 1) * size(A, 2), 1);
    for i = 1 : size(A, 1)
        for j = 1 : size(A, 2)
            res((i - 1) * size(A, 2) + j) = A(i, j);
        end
    end
end
