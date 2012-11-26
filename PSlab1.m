a = [1/4 1/4 1/6 1/3];
part_sums = [0 0 0 0];
for i=1:4
	part_sums(i) = sum(a(1:i));
endfor

u = rand();
ind = find((part_sums - u) > 0);
alfa = a(ind(1))
n = alfa*randn() % well, not really, but...

