function [ gama ] = gama(obs, pi, a, miu, sigma, b, c, alfa, beta)
% gama(i, j, t) - probability that at moment t
% there is a transition between state i and j
% given the set of observations obs(t)
	 
	T = length(obs); % nr of observations
	N = length(pi); % nr of states
	M = size(c,2); % number of mixture components
	n = size(sigma); % dimension of multivariate normal distributions
	
	gama = zeros(N, N, T);

	for i = 1:N       % pot face mai vectorial toata chestia asta?
		for j = 1:N
			gama(i, j, 1) = 1;   % ???
			for t = 2:T
				gama(i,j,t) = (alfa(t-1, i) * a(i, j) * b(j, t) * beta(t, j))								/ sum(alfa(T, :));
			end
		end
	end

end