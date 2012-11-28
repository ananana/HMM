function [ a, miu, sigmas, c, Qv ] = BaumWelch( a, miu, sigma, c, pi, obs )
    iterations = 10;

    N = length(pi); % nr of states
    M = size(c,2); % nr of mixing components
    D = size(miu, 1); % dimension of multivariate normal variable
    T = size(obs); % number of observations

    Qv = [];

    % multiplicate sigmas (initially they are the same for all states and components)
    % sigmas = [[sigma] x M x N] => M by N sigma
    sigmas = sigma_to_sigmas(sigma, N, M, D);
    % b
    b = b_cont( obs, miu, sigmas, c );
    % b component-wise
    b_c = b_cont_comp( obs, miu, sigmas, c );

    for it=1:iterations
        % alfa
        alfa = alfaf(obs, pi, a, b );
        % beta
    	beta = betaf( obs, a, b );
        % xi
        xi = xif( obs, pi, a, miu, sigmas, b_c, c, alfa, beta );
        % gama
        gama = gamaf(obs, a, b, alfa, beta);
        % parametrii: a, miu, sigma, c

        % IN PROGRESS: check all indeces again

        % a*
        for i = 1:N
            for j = 1:N
                a(i, j) = sum(gama(i, j, :)) / sum(sum(gama(i, :, :)));
            end
        end
        % question: what about pi? 
        % daca in rest il folosim ca parte din a, cu o noua stare initiala.
        % aici ar trebui si el actualizat, nu?

        % c*
        for j = 1:N
            for k = 1:M
                [i_xi1, _] = ij(1, j, 1, k, 1, M);
                [i_xi2, _] = ij(1, j, 1, 1, 1, M);
                [i_xi3, _] = ij(1, j, 1, M, 1, M);
                %c(j, k) = sum(xi((j - 1) * M + k, :)) /...
                %sum(sum(xi((j - 1) * M + 1 : j * M, :)));
                c(j, k) = sum(xi(i_xi1, :)) /...
                 sum(sum(xi(i_xi2:i_xi3, :))); % xi for all t and all components of state j
            end
        end    

        % miu*
        % ?? seems ok, but values are not so close to the original ones, maybe problem?
        miu1 = zeros(2, N*M);
        for s = 1:N
            for k = 1:M
                 miu((s - 1) * M + k, :) = zeros(1, N*M);
                [_, j_miu] = ij(s, 1, k, 1, D, M);
                for t = 1:T
                    [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                    %(xi(i_xi, j_xi) * obs(:, t));
                    miu1(:, j_miu) = (miu1(:, j_miu) +...
                     %(xi((s - 1 ) * M + k, t) * obs(:, t)) / sum(xi((s - 1 ) * M + k, :));
                     (xi(i_xi, j_xi) * obs(:, t)));
                end
                miu1(:, j_miu) = miu1(:, j_miu) / sum(xi(i_xi, :));
            end
        end
        miu = miu1; %??

        % sigma*
        % ?? seems ok, but values are not so close to the original ones, maybe problem?
        sigmas1 = zeros(M*D, N*D);
        for s = 1:N
            for k = 1:M
                [i_s1, j_s1] = ij(s, k, 1, 1, D, D);
                [i_s2, j_s2] = ij(s, k, D, D, D, D);
                [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                [_, j_miu] = ij(s, 1, k, 1, D, M);
                % sigmas((k - 1) * D  + 1: k * D, (s - 1) * D + 1 : s * D) = sigma;
                for t = 1:T
                    sigmas1(i_s1:i_s2, j_s1:j_s2) = sigmas1(i_s1:i_s2, j_s1:j_s2) +...
                     xi(i_xi, t) *...
                      (obs(:, t) - miu(:, j_miu)) *...
                       (obs(:, t) - miu(:, j_miu))';
                end
                sigmas1(i_s1:i_s2, j_s1:j_s2) = sigmas1(i_s1:i_s2, j_s1:j_s2) /...
                 sum(xi(i_xi, :));
            end
        end        
        sigmas = sigmas1; % ???


        % Q pt control - tre sa creasca (o sa fie negative)
        % Qa has the format of gama
        % Qa = zeros(N, N, T);
        for i = 1:N
            for j = 1:N
                Qam(i, j, :) = sum(gama(i, j, :) * log(a(i, j)));
            end
        end
        Qa = sum(sum(Qam(:,:)));

        % Qb has the format of xi
        
        for s = 1:N
            for k = 1:M
                [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                [i_b, j_b] = ij(t, s, 1, k, 1, M); % same??
                Qbm(i_xi, :) = sum(xi(i_xi) * log(b_c(i_b, :)));
            end
        end
        Qb = sum(sum(Qbm(:,:)));
    
        % Qc has the format of xi
        for s = 1:N
            for k = 1:M
                [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                Qcm(i_xi, :) = sum(xi(i_xi) * log(c(s, k)));
            end
        end
        Qc = sum(sum(Qcm(:,:)));

        Q = Qa + Qb + Qc
        Qv = [Qv Q];

    end
    
    plot(1:iterations, Qv);
    hold on;
    hold off;

end

