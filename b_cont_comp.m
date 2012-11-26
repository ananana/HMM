function [ b ] = b_cont_comp( obs, pi, a, miu, sigma, c )
% b(i, t) - the distribution for a continuous HMM for a given set of observations, 
% for state s at time t, component-wise
% b(i, t) = [[density for state s x comp k, time 1]] (columns)
% miu - matrix of means:
% 		[(means for dim d, comp k)_state1, (means for dim d, comp k)_state2 ... _state s...]
%		miu(d, n*(s-1) + k) - mean for dimension j of component k of density of state i
%		(M = nr of components)
% sigma - covariance matrix, same for everything (every state and every component)
%			dimensions = nxn

% hope it's ok??

T = length(obs); % nr of observations
N = length(pi); % nr of states
b = zeros(N, T); % b(s, t) - mixed normal density function for state s and time t
M = size(c,2); % number of mixture components
n = size(sigma); % dimension of multivariate normal distributions
for i=1:N*M
    for t=1:T
        b(i,t) = mult_norm(obs(t), miu(:,i), sigma);
    end
end

end