function [ a, pi ] = random_model (nr_states)

a = [];

pi = rand_prob_vect(nr_states);
for i=1:nr_states
%	b = [b; rand_prob_vect(obs_size)];
	a = [a; rand_prob_vect(nr_states)];
end

end
