function [ Beta ] = betaf( obs, a, b )
% beta(t, i) - the probability that obs(1...t) were generated given that at time t we are in state i

T = size(obs, 2); % nr of observations
N = size(a, 1); % nr of states

Beta = zeros(T, N);
Beta(T, :) = ones(1, N);

for t = T-1:-1:1
        for i = 1:N
                Beta(t, i) = sum(a(i, :) .* Beta(t + 1, :) .* b(:, t+1)');
        end
        Beta(t, :) = Beta(t, :) / sum(Beta(t, :));
end

end
