function [ b_c ] = b_cont_comp( obs, miu, sigmas, c )
% b(i, t) - the distribution for a continuous HMM for a given set of observations, 
% for state s at time t, component-wise
% b(i, t) = [[density for state s x comp k, time 1]] (columns)
% miu - matrix of means:
% 		[(means for dim d, comp k)_state1, (means for dim d, comp k)_state2 ... _state s...]
%		miu(d, n*(s-1) + k) - mean for dimension j of component k of density of state i
%		(M = nr of components)
% sigma - covariance matrix, same for everything (every state and every component)
%			dimensions = nxn
%			sigmas - M x N sigma

% hope it's ok??



	T = size(obs, 2); % nr of observations
	N = size(c,1); % nr of states
	M = size(c,2); % number of mixture components
	D = size(miu, 1); % dimension of multivariate normal distributions
	b_c = zeros(N*M, T); % b(s, t) - mixed normal density function for state s and time t, comp k
	for s = 1:N
		for k = 1:M
			[i_s1, j_s1] = ij(s, k, 1, 1, D, D);
	        [i_s2, j_s2] = ij(s, k, D, D, D, D);
	        [_, ind] = ij(s, 1, k, 1, M, M); % era D h_max??
	        sigma = sigmas(i_s1:i_s2, j_s1:j_s2);
		    for t=1:T
		    	b_c(ind,t) = mult_norm(obs(t), miu(:,ind), sigma); % ??
		    end
		end
	end

end