b_cc = b_cont_comp(obs, miu, sigmas, c);
b = b_cont( obs, miu, sigmas, c );
b_c = zeros(2,10);
M=2;
for s=1:5
	[_,ind1] = ij(s,1,1,1,M,M);
	[_,ind2] = ij(s,1,M,1,M,M);
	for t=1:10
		b_c(s,t) = sum(c(s,:)'.*b_cc(ind1:ind2,t));
	end
end

%b_c - b
