function [ prob ] = test_models( T )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
obs = generate_obs(T);
pi1 = [1/2 1/2 0];
a1 = [1/3 1/3 1/3; 0 1/2 1/2; 1/2 1/2 0];
b1 = [0.6 0.4; 0.3 0.7; 0.8 0.2];
prob(1) = forward(obs, pi1, a1, b1);

pi2 = [0 0 1];
a2 = [1/4 1/2 1/2; 1 0 0; 1/3 1/3 1/3];
b2 = [0.2 0.8; 0.5 0.5; 0.3 0.7];
prob(2) = forward(obs, pi2, a2, b2);

end

