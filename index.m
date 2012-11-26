function [ ind ] = index( alphas )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(alphas);
part_sums = zeros(1, n);
for i=1:n
    part_sums(i) = sum(alphas(1:i));
end

u = rand(1);
ind_vect = find(part_sums > u);
ind = ind_vect(1);

end

