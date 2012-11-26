function [ a, miu, sigmas, c ] = BaumWelch( a, miu, sigma, c, pi, obs )
iterations = 10;
N = length(pi); % nr of states
M = size(c,2); % nr of mixing components
D = size(sigma); % dimension of multivariate normal variable

% multiplicate sigmas (initially they are the same for all states and components)
% sigmas = [[sigma] x N x k] => N by k sigma
for s = 1:N
    for k = 1:M
        sigmas((k - 1) * D  + 1: k * D, (s - 1) * D + 1 : s * D) = sigma;
    end
end

for it=1:iterations
	% b
	b = b_cont( obs, pi, a, miu, sigma, c );
    % alfa
	alfa = alfa(obs, pi, a, miu, sigma, c, b);
    % beta
	beta = beta( obs, pi, a, miu, sigma, c, b );
    % xi
    xi = xi( obs, pi, a, miu, sigma, c, alfa, beta )
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
    for i = s:N
        for k = 1:M
            miu((s - 1) * M + k, :) = zeros(N*M);
            for t = 1:T
                miu((s - 1 ) * M + k, :) = miu((s - 1) * M + k, :) +...
                (xi((s - 1 ) * M + k, t) * obs(:, t)) / sum(xi((s - 1 ) * M + k, :));
            end
        end
    end

    % sigma*



    % Q pt control - tre sa creasca (o sa fie negative)
    %alfa = alfa (obs, pi, a, miu, sigma, c);
    
end

end

