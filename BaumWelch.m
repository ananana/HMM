function [ a, miu, sigmas, c ] = BaumWelch( a, miu, sigma, c, pi, obs )
    iterations = 1;

    N = length(pi); % nr of states
    M = size(c,2); % nr of mixing components
    D = size(sigma); % dimension of multivariate normal variable
    T = size(obs); % number of observations

    Qv = [];

    % multiplicate sigmas (initially they are the same for all states and components)
    % sigmas = [[sigma] x N x k] => N by k sigma
    for s = 1:N
        for k = 1:M
            [i1, j1] = ij(s, k, 1, 1, D, D);
            [i2, j2] = ij(s, k, D, D, D, D);
            % sigmas((k - 1) * D  + 1: k * D, (s - 1) * D + 1 : s * D) = sigma;
            sigmas(i1:i2, j1:j2) = sigma;
        end
    end

    for it=1:iterations
    	% b
    	b = b_cont( obs, pi, a, miu, sigma, c );
        % alfa
    	alfa = alfa(obs, pi, a, miu, sigma, c, b );
        % beta
    	beta = beta( obs, pi, a, miu, sigma, c, b );
        % xi
        xi = xi( obs, pi, a, miu, sigma, c, alfa, beta );
        % gama
        gama = gama(obs, pi, a, miu, sigma, b, c, alfa, beta);
        % parametrii: a, miu, sigma, c

        % IN PROGRESS: check all indeces again

        % a*
        for i = 1:N
            for j = 1:N
                a(i, j) = sum(gama(i, j, :)) / sum(sum(gama(i, :, :)));
            end
        end

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
                % miu((s - 1) * M + k, :) = zeros(1, N*M);
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
                Qa(i, j, :) = sum(gama(i, j, :) * log(a(i, j)));
            end
        end

        % Qb has the format of xi
        b_c = b_cont_comp( obs, pi, a, miu, sigma, c ); % compute it once and use it for xi as well
        for s = 1:N
            for k = 1:M
                [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                [i_b, j_b] = ij(t, s, 1, k, 1, M); % same??
                Qb(i_xi, :) = sum(xi(i_xi) * log(b_c(i_b, :)));
            end
        end
    
        % Qc has the format of xi
        for s = 1:N
            for k = 1:M
                [i_xi, j_xi] = ij(t, s, k, 1, 1, M);
                Qc(i_xi, :) = sum(xi(i_xi) * log(c(s, k)));
            end
        end
    end

    Q = Qa + Qb + Qc;

    Qv = [Qv Q];

    %plot(iterations, Qv);
    %hold on;
    end

    %hold off;

end

