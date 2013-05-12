function [ prob ] = test_models_Viterbi( nr_models, T )

%nr_models = 10;
obs_size = 2;
nr_states = 5;

[a, pi] = random_model(nr_states);
b = b_discrete(obs_size, nr_states);

%pi1 = [1/2 1/2 0];
%a1 = [1/3 1/3 1/3; 0 1/2 1/2; 1/2 1/2 0];
%b1 = [0.6 0.4; 0.3 0.7; 0.8 0.2];

obs = generate_obs(T, a, b, pi);
[p, s] = Viterbi(obs, a, b, pi);
prob(1) = p;

for i = 2:nr_models
    [ra, rpi] = random_model(nr_states);
    rb = b_discrete(obs_size, nr_states);
	[p, s] = Viterbi(obs, ra, rb, rpi);
	prob(i) = p;
end 

suma = sum(prob);
prob = prob / suma;
end
