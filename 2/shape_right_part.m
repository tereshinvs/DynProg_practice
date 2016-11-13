function res = shape_right_part(t, l_Xcm)
    global A B C Q P N
    
    lt = l_Xcm(1 : N);
    Xc = vec2mat(l_Xcm((N + 1) : end), N, N);
    
    At = A(t);
    Bt = B(t);
    Ct = C(t);
    Qt = Q(t);
    Pt = P(t);
    
    BtPtBtT = Bt * Pt * Bt';
    pi_l_t = sqrt(scalar_mult(lt, BtPtBtT * lt) / scalar_mult(lt, Xc * lt));
    if ~isreal(pi_l_t)
        pi_l_t = 0;
    end
    CtQtCtT = Ct * Qt * Ct';
    sqrtCtQtCtT = sqrtm(CtQtCtT);
    if isnan(sqrtCtQtCtT)
        sqrtCtQtCtT = zeros(N);
    end
    if norm(Xc) < 1e-6
        Xc = 0 * eye(N);
        sqrtXc = 0 * eye(N);
    else
        sqrtXc = sqrtm(Xc);
    end
    
    %S_l_t = sqrt(scalar_mult(lt, CtQtCtT * lt) / scalar_mult(lt, Xc * lt)) * sqrtm(Xc) * ...
    %    inv(sqrtCtQtCtT);
    v1 = sqrtCtQtCtT * lt;
    v2 = sqrt(scalar_mult(lt, CtQtCtT * lt) / scalar_mult(lt, Xc * lt)) * sqrtXc * lt;
    S_l_t = rotate_matrix(v2, v1);
    S_l_t_sqrtCtQtCtT = S_l_t * sqrtCtQtCtT;
    %S_l_t_sqrtCtQtCtT = sqrt(scalar_mult(lt, CtQtCtT * lt) / scalar_mult(lt, Xc * lt)) * sqrtXc;
    if isnan(S_l_t_sqrtCtQtCtT)
        S_l_t_sqrtCtQtCtT = 0.01 * eye(N);
    end
    %Xcres = At * Xc + Xc * At' - pi_l_t * Xc - 1/pi_l_t * BtPtBtT + ...
    %    sqrtXc * S_l_t * sqrtCtQtCtT + sqrtCtQtCtT * S_l_t * sqrtXc;

    if abs(pi_l_t) < 1e-6
        Xcres = At * Xc + Xc * At' + sqrtXc * S_l_t_sqrtCtQtCtT + S_l_t_sqrtCtQtCtT' * sqrtXc;
    else
        Xcres = At * Xc + Xc * At' - pi_l_t * Xc - 1/pi_l_t * BtPtBtT + ...
            sqrtXc * S_l_t_sqrtCtQtCtT + S_l_t_sqrtCtQtCtT' * sqrtXc;
    end
    
    lres = -At' * lt;
    
    res = real([lres; mat2vec(Xcres)]);
end
