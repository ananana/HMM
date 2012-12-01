function [ gama ] = gamaf(obs, a, b, alfa, Beta)
% gama(i, j, t) - probability that at moment t
% there is a transition between state i and j
% given the set of observations obs(t)
	 
	T = size(obs, 2); % nr of observations
	N = size(a, 1); % nr of states
	
	gama = zeros(N, N, T);

	for i = 1:N       % pot face mai vectorial toata chestia asta?
		for j = 1:N
			% gama(i, j, 1) = 1;   % ??? CICA 0
			for t = 2:T
				gama(i,j,t) = (alfa(t-1, i) * a(i, j) * b(j, t) * Beta(t, j)) /...
				 sum(alfa(T, :));
			end
		end
	end

end