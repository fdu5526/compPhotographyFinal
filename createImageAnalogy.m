function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B);
	Asize = size(A);
	Bp = zeros(size(B));

	randSearchCount = 100;

	% loop through B
	for by = 1:Bsize(1)
		for bx = 1:Bsize(2)
			b = [B(by,bx,1),B(by,bx,2),B(by,bx,3)];

			% find match in A
			ayL = randi([1,Asize(1)], 1, randSearchCount);
			axL = randi([1,Asize(2)], 1, randSearchCount);
			bestA = [1,1]; bestDist = 100000;
			for c = 1:randSearchCount
				ax = axL(c);
				ay = ayL(c);
				
				a = [A(ay,ax,1),A(ay,ax,2),A(ay,ax,3)];
				d = dist2(a,b);

				if(d < bestDist)
					bestDist = d;
					bestA = [ay,ax];
				end
			end

			Bp(by, bx, :) = Ap(bestA(1),bestA(2),:);
		end
	end

	output = Bp;
end


function n2 = dist2(v1, v2)
	n2 = sum((v1 - v2) .^ 2);
end

