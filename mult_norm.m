function [ f ] = mult_norm( x, miu, sigma )
% x - observation = column vector
% miu - mean = column vector
% sigma - covariance = square matrix

n = length(x);
f = 1 / ((2*pi)^(n/2)*sqrt(abs(det(sigma)))) *...
 exp( -1/2 * (x - miu)' * inv(sigma) * (x - miu) );

end

