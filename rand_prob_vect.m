function [ vect ] = rand_prob_vect( N )
vect = rand(1, N);
suma = sum(vect);
vect = vect ./ suma;
end