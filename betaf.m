function [ beta ] = betaf( obs, a, b )
% beta(t, i) - the probability that obs(1...t) were generated given that at time t we are in state i

T = length(obs); % nr of observations
N = size(a, 1); % nr of states

beta = zeros(T, N);
beta(T, :) = ones(1, N);

for t = T-1:-1:1
        for i = 1:N
                beta(t, i) = sum(a(i, :) .* beta(t + 1, :) .* b(:, t+1)');
        end
end

end
