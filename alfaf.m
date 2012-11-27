function [ alfa ] = alfaf( obs, pi, a, b )
% alfa(t, i) = the probability that at time t we are in state i
% and have generated observations x_0...x_t
T = length(obs);
N = length(pi);
%b = zeros(N, T);
% M = size(c,2);
%b = b_cont( obs, pi, a, miu, sigma, c );
alfa = zeros(T, N);
alfa(1, :) = pi .* b(:,1)';

for t=2:T
    for s=1:N
        alfa(t, s) = sum(alfa(t-1, :) .* a(:, s)') * b(s,t);
    end
end

end

