function [ obs ] = generate_obs_cont( T, pi, a, miu, sigma, c )
% miu1 = mean for first component (2-dim)
% miu2 = mean for second compunent (2-dim)
% sigma1 = covariance for first component (2-dim)
% sigma2 = covariance for second component (2-dim)
% c = probability for components of mixture

% ex:
% sigma = [4 2; 2 3]
% c = [0.2 0.8; 0.5 0.5; 0.7 0.3]
% miu = [2 -1 1 0 0  2...
        %1  1 0 1 2 -2];
n = size(c,2); % nr of mixture components
obs = zeros(2, T);
i = index(pi);
for t=1:T
    k = index(c(i,:)');
    obs(:,t) = mvnrnd(miu(:,n*(i-1)+k)', sigma);
	i = index(a(i,:));
end

end

