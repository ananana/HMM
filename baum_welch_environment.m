sigma = [4 2; 2 3];
sigmas = sigma_to_sigmas(sigma, 5, 2, 2);

c = [0.2 0.8; 0.5 0.5; 0.7 0.3; 0.2 0.8; 0.1 0.9];

%miu = [2 -1 1 0 0  2 3 1 4 5;       1  1 0 1 2 -2 1 3 4 5];
miu = rand(2, 10) * 10;
[a, pi] = random_model(10, 5);

[a2, pi2] = random_model(10, 5);
miu2 = ones(2, 10) * 5;
sigma2 = [2 1; 1 3];
sigmas2 = sigma_to_sigmas(sigma2, 5, 2, 2);
c2 = [0.3 0.7; 0.3 0.7; 0.5 0.5; 0.4 0.6; 0.6 0.4];

obs = generate_obs_cont(100, pi, a, miu, sigma, c);
b = b_cont( obs, miu, sigmas, c );
b = b_cont( obs, miu2, sigmas2, c2 );
%alfa = alfaf( obs, pi, a, b )
%Beta = betaf( obs, a, b )

[ a1, miu1, sigmas1, c1, Qv] = BaumWelch(a2, miu2, sigma2, c2, pi, obs);
