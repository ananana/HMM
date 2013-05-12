function [ probf, probv ] = test_models_both( nr_models, T, obs_size, nr_states )

%nr_models = 10;
%obs_size = 2;
%nr_states = 3;

[a, pi] = random_model(nr_states);
b = b_discrete(obs_size, nr_states);

obs = generate_obs(T, a, b, pi );
probf(1) = forward(obs, a, b, pi);
[probv(1),aux] = Viterbi(obs, a, b, pi);

for i = 2:nr_models
    [ra, rpi] = random_model(nr_states);
    rb = b_discrete(obs_size, nr_states);
	probf(i) = forward(obs, ra, rb, rpi);
	[probv(i),aux] = Viterbi(obs, ra, rb, rpi);
end 

sumaf = sum(probf);
sumav = sum(probv);
probf = probf / sumaf;
probv = probv / sumav;
end
