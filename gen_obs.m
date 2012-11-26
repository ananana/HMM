miu = [20 -10 1 -5 30  2;...
       10  1  5  1  2 -20];
 a = [rand_prob_vect(3); rand_prob_vect(3); rand_prob_vect(3)]
 pi = rand_prob_vect(3)
 sigma = [4 2; 2 3];
 c = [0.2 0.8; 0.5 0.5; 0.7 0.3];
 generate_obs_cont(10, pi, a, miu, sigma, c)