function [ b ] = b_cont( obs, pi, a, miu, sigma, c )
% b(s, t) - the density for a HMM 
% 			with continuous density functions = mixture of normals;
%			for a given set of observations; for state s at time t
% miu - matrix of means:
% 		[(means for dim d, comp_k)_state1, (means for dim d, comp_ks)_state2 ...()_state_s...]
%		miu(d, M*(s-1) + k) - mean for dimension j of component k of density of state i
%		(M = nr of components)
% sigma - covariance matrix, same for everything (every state and every component)
%			dimensions = nxn

% TODO: do this by calling b_cont_comp; cause this way you compute stuff twice

T = length(obs); % nr of observations
N = length(pi); % nr of states
b = zeros(N, T); % b(s, t) - mixed normal density function for state s and time t
M = size(c,2); % number of mixture components
n = size(sigma); % dimension of multivariate normal distributions
for s=1:N
    for t=1:T
        for k = 1:M
            b(s,t) = b(s,t) + c(s,k) * mult_norm(obs(t),...
             miu(:,M*(s-1)+k), sigma); % aici era n nu M, dar tre sa fie M! nu?
        end
    end
end

end
