function[i, j] = ij (h_block, v_block, h_index, v_index, h_max, v_max)
	% Calculates indexes for matrices made of smaller blocks 
	% (instead of spread across more dimensions)
	%
	% h_block - number of horizontal block
	% v_block - number of vertical block
	% h_index - index of horizontal within block
	% v_index - index of vertical within block
	% v_max - size of vertical blocks
	% h_max - size of horizontal blocks

	i = v_max * (v_block - 1) + v_index;
	j = h_max * (h_block - 1) + h_index;

	% USAGE:
	% for sigmas: v_max = h_max = D (dimension of random variable)
	%			  h_block = state
	%			  v_block = component
	%			  h_index = v_index = dimension (usually used as block (:,:))
	%		  ->  like so: 
	%					[i_s1, j_s1] = ij(s, k, 1, 1, D, D);
%                 		[i_s2, j_s2] = ij(s, k, D, D, D, D);
	% for miu: v_max = D (dimension of random variable)  ?? / 1
	%		   h_max = M (number of components)
	%		   v_block = 1 (only one block vertically always)
	%		   h_block = state
	%		   v_index = number of dimension (usually used as block (:))
	%		   h_index = component
	%	   ->  like so: 
	%				[aux, j_miu] = ij(s, 1, k, 1, M, D);
	% for xi: v_max = M (number of components)
	%		  h_max = 1
	%		  v_block = state
	%		  h_block = number/time of observation (t)
	%		  v_index = component
	%		  h_index = 1 (length of block is 1, so irrelevant)
	%	  ->  like so: 
	%				[i_xi, j_xi] = ij(t, s, 1, k, 1, M);
	%
	% for b_cont_comp: v_max = M (number of components)
	%				   h_max = 1
	%				   v_block = state
	%				   h_block = number/time of observation (t)
	%		  		   v_index = component
	%		  		   h_index = 1 (length of block is 1, so irrelevant) ??
	%			   ->  like so: 
	%						[i_b, j_b] = ij(t, s, 1, k, 1, M);


