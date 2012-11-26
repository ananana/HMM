function [ a, miu, sigmas, c ] = BaumWelch( a, miu, sigma, c, pi, obs )
    iterations = 1;
    N = length(pi); % nr of states
    M = size(c,2); % nr of mixing components
    D = size(sigma); % dimension of multivariate normal variable
    T = size(obs); % number of observations

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

        % IN PROGRESS:...

        % a*
        for i = 1:N
            for j = 1:N
                a(i, j) = sum(gama(i, j, :)) / sum(sum(gama(i, :, :)));
            end
        end

        % c*
        for j = 1:N
            for k = 1:M
                c(j, k) = sum(xi((j - 1) * M + k, :)) /...
                 sum(sum(xi((j - 1) * M + 1 : j * M, :)));
                 % xi for all t and all components of state j
            end
        end    

        % miu*
        miu = zeros(2, N*M);
        for i = s:N
            for k = 1:M
                % miu((s - 1) * M + k, :) = zeros(1, N*M);
                [_, j_miu] = ij(s, 1, k, 1, D, M);
                for t = 1:T
                    [i_xi, j_xi] = ij(t, 1, k, 1, 1, M);
                    miu(:, j_miu) = miu(:, j_miu) +...
                     (xi((s - 1 ) * M + k, t) * obs(:, t)) / sum(xi((s - 1 ) * M + k, :));
                end
            end
        end

        % sigma*



        % Q pt control - tre sa creasca (o sa fie negative)
        %alfa = alfa (obs, pi, a, miu, sigma, c);
        
    end

end

