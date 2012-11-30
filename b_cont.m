function [ b ] = b_cont( obs, miu, sigmas, c )
% b(s, t) - the density for a HMM 
% 			with continuous density functions = mixture of normals;
%			for a given set of observations; for state s at time t
% miu - matrix of means:
% 		[(means for dim d, comp_k)_state1, (means for dim d, comp_ks)_state2 ...()_state_s...]
%		miu(d, M*(s-1) + k) - mean for dimension j of component k of density of state i
%		(M = nr of components)
% sigmas - covariance matrix, initially same for everything (every state and every component)
%		   sigmas = [[sigma] x M x N] => M by N sigma (DxD)

% TODO: do this by calling b_cont_comp; cause this way you compute stuff twice

T = size(obs, 2); % nr of observations
N = size(c, 1); % nr of states
b = zeros(N, T); % b(s, t) - mixed normal density function for state s and time t
M = size(c,2); % number of mixture components
D = size(miu, 1); % dimension of multivariate normal distributions
sigma = zeros(D, D);
for s=1:N
    for t=1:T
        for k = 1:M
        	[i_s1, j_s1] = ij(s, k, 1, 1, D, D);
            [i_s2, j_s2] = ij(s, k, D, D, D, D);
            [_, j_miu] = ij(s, 1, k, 1, M, D);
            sigma = sigmas(i_s1:i_s2, j_s1:j_s2);

            b(s,t) = b(s,t) + c(s,k) * mult_norm(obs(t),...
            miu(:,j_miu), sigma); % aici era n nu M, dar tre sa fie M! nu?
        end
    end
end

end
