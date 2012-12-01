function [ f ] = mult_norm( x, miu, sigma )
% x - observation = column vector
% miu - mean = column vector
% sigma - covariance = square matrix

n = length(x);
f = 1 / ((2*pi)^(n/2)*det(sigma)^(1/2)) *...
 exp( -1/2 * (x - miu)' * inv(sigma) * (x - miu) );

end

