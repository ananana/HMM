sigma = [4 2; 2 3]
sigmas = sigmas(sigma, 3, 2, size(sigma));

c = [0.2 0.8; 0.5 0.5; 0.7 0.3]
miu = [2 -1 1 0 0  2;       1  1 0 1 2 -2]
[a, pi] = random_model(2, 3)
obs = generate_obs_cont(10, pi, a, miu, sigma, c)
b = b_cont( obs, miu, sigmas, c )
alfa = alfa( obs, pi, a, b )
beta = beta( obs, a, b )
