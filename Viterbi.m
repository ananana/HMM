function [ p, S ] = Viterbi( obs, a, b, pi )
% V(t,j) - probability of most probable sequence of states up to moment t, if in state j
% B(t,j) - most probable sequence of states up to moment t, if in state j 
N = length(pi);
T = length(obs);
V = zeros(T, N);
B = zeros(T, N);
%S = zeros(1, N);
S = [];

V(1, :) = pi .* b(:, obs(1) + 1)';
for t=2:T
    for j=1:N
        [m, argm] = max(V(t-1, :) .* a(:, j)');
        V(t, j) = m * b(j, obs(t) + 1);
        B(t, j) = argm(1);
    end
end
[m, argm] = max(V(T, :));
p = m;
st = argm(1);
for t=T-1:-1:1
    st = B(t+1, st);
    S = [st S];
end

end

