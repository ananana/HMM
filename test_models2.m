function [ prob ] = test_models2( nr_models, T )

%nr_models = 10;
obs_size = 2;

pi = rand_prob_vect(3);
b = [rand_prob_vect(obs_size); rand_prob_vect(obs_size); rand_prob_vect(obs_size)];
a = [rand_prob_vect(3); rand_prob_vect(3); rand_prob_vect(3)];

%pi1 = [1/2 1/2 0];
%a1 = [1/3 1/3 1/3; 0 1/2 1/2; 1/2 1/2 0];
%b1 = [0.6 0.4; 0.3 0.7; 0.8 0.2];

obs = generate_obs(T, pi, a, b);

prob(1) = forward(obs, pi, a, b);
for i = 2:nr_models
    pi = rand_prob_vect(3);
    b = [rand_prob_vect(obs_size); rand_prob_vect(obs_size); rand_prob_vect(obs_size)];
    a = [rand_prob_vect(3); rand_prob_vect(3); rand_prob_vect(3)];
    prob(i) = forward(obs, pi, a, b);
end 
suma = sum(prob);
prob = prob / suma;
end
