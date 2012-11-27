function [ sigmas ] = sigmas(sigma, N, M, D)
	sigmas = zeros(N*D, M*D);
    for s = 1:N
        for k = 1:M
            [i_s1, j_s1] = ij(s, k, 1, 1, D, D);
            [i_s2, j_s2] = ij(s, k, D, D, D, D);
            sigmas(i_s1:i_s2, j_s1:j_s2) = sigma;
        end
    end
end