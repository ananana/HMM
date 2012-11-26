function [ p ] = forward_precise( obs, a, b, pi )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N = length(pi);
T = length(obs);
alfa = zeros(T, N);
b = b * 10;
alfa(1, :) = pi .* b(:, obs(1) + 1)';
for t=2:T
    for j=1:N
        alfa(t, j) = sum(alfa(t-1, :) .* a(:, j)') * b(j, obs(t) + 1);
    end
end
p = sum(alfa(T,:));

%p = p / 10^T;

