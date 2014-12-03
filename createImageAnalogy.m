function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B);
	Asize = size(A);
	Bp = zeros(size(B));

	randSearchCount = 3;
	halfPatchSize = 1;

	% loop through B
	for by = (1+halfPatchSize):(Bsize(1)/(halfPatchSize*2+1))
		for bx = (1+halfPatchSize):(Bsize(2)/(halfPatchSize*2+1))
			
			byRange = (by-halfPatchSize):(by+halfPatchSize);
			bxRange = (bx-halfPatchSize):(bx+halfPatchSize);

			b = B((by-halfPatchSize):(by+halfPatchSize),(bx-halfPatchSize):(bx+halfPatchSize),:)

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


function p = bestMatch(A, Ap, B, Bp, s, l, q)

	p = 0;
end


function p = bestApproximateMatch(A, Ap, B, Bp, l, q)
	p = 0;
end

function p = bestCoherenceMatch(A, Ap, B, Bp, s, l, q)
	p = 0;
end

