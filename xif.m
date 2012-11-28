function [ xi ] = xif( obs, pi, a, miu, sigmas, b, c, alfa, Beta )
% xi(i, t) - probability that at moment t we are in state s with
% mixing component k, given the entire sequence of observations obs(1...T)
% i = s * k

% xi (i, t) - [[state s x comp k, obs t]] (columns)
% dimensions: NxM, T


% xi (1, j, k)
% for (t = 2:T)
% 	for (j = 1:N)
% 		xi(t, j, k) = sum(alfa(t-1, :) *. a(:, j)) * c(j, k) * 
%					  b_cont_comp(j * (n-1) + k, t) * beta(t, j) /   ??
%					  sum(alfa(t, :));
%	end
% end
%

T = length(obs); % nr of observations
N = length(pi); % nr of states
M = size(c,2); % number of mixture components

% density on each mixture component
% b = b_cont_comp( obs, miu, sigmas, c );

% pt t = 1: fol pi
for s = 1:N
	for k = 1:M
		xi(s * k, 1) = pi(s) * c(s, k) * b((s -1 ) * M + k, 1) * Beta(1, s)...
		 / sum(alfa(T, :)); % b??
	end
end

% order of loops is not relevant, because definition of xi is not recursive
% (elements don't depend on one another)
for t = 2:T
	for s = 1:N
		for k = 1:M
			xi((s -1 ) * M + k, t) = sum(alfa(t-1, :) .* a(:, s)')...
			 * c(s, k) * b((s -1 ) * M + k, t) * Beta(t, s)...
			 / sum(alfa(T,:));
		end
	end
end


end