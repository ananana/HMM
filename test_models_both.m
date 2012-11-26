function [ prob1, prob2 ] = test_models_both( nr_models, T, obs_size, nr_states )

%nr_models = 10;
%obs_size = 2;
%nr_states = 3;

[a, pi] = random_model(obs_size, nr_states);
b = b_discrete(obs_size, nr_states);

obs = generate_obs(T, a, b, pi );
prob1(1) = forward(obs, a, b, pi);
[prob2(1),_] = Viterbi(obs, a, b, pi);

for i = 2:nr_models
    [ra, rpi] = random_model(obs_size, nr_states);
    rb = b_discrete(obs_size, nr_states);
	prob1(i) = forward(obs, ra, rb, rpi);
	[prob2(i),_] = Viterbi(obs, ra, rb, rpi);
end 

suma1 = sum(prob1);
suma2 = sum(prob2);
prob1 = prob1 / suma1;
prob2 = prob2 / suma2;
end
