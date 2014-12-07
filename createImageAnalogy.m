function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B); Asize = size(A); Bp = zeros(size(B));

	% independent magic numbers
	searchCount = 100;
	halfPatchSize = 10;

	patchSize = halfPatchSize*2;

	% loop through B
	for by = (1+halfPatchSize):halfPatchSize:(Bsize(1)-halfPatchSize)
		for bx = (1+halfPatchSize):halfPatchSize:(Bsize(2)-halfPatchSize)

			% get data in B
			bYRange = (by-halfPatchSize):(by+halfPatchSize);
			bXRange = (bx-halfPatchSize):(bx+halfPatchSize);
			b = B(bYRange,bXRange,:);
			b = b(:)';

			% the patch to left of bx by on Bp
			bpXLeft = zeros(halfPatchSize*2+1, halfPatchSize+1,3);
			if(bx-patchSize >= 1)
				bpXLeft = Bp(bYRange, (bx-halfPatchSize):bx, :);
			end
			bpXLeft = bpXLeft(:)';

			% the patch to top of bx by on Bp
			bpYTop = zeros(halfPatchSize*2+1, halfPatchSize+1,3);
			if(by-patchSize >= 1)
				bpYTop = Bp(by:(by+halfPatchSize), bXRange, :);
			end
			bpYTop = bpYTop(:)';



			% generate random coordinates
			ayL = randi([1+halfPatchSize,Asize(1)-halfPatchSize], 1, searchCount);
			axL = randi([1+halfPatchSize,Asize(2)-halfPatchSize], 1, searchCount);
			
			% search in A $searchCount times
			bestA = {}; bestDist = 100000;
			for c = 1:searchCount
				ax = axL(c);
				ay = ayL(c);

				% get data in A
				AYRange = (ay-halfPatchSize):(ay+halfPatchSize);
				AXRange = (ax-halfPatchSize):(ax+halfPatchSize);
				a = A(AYRange,AXRange,:);
				a = a(:)';
				apXLeft = A(AYRange,1:(halfPatchSize+1),:);
				apXLeft = apXLeft(:)';
				apYTop = A((ay-halfPatchSize):ay,AXRange,:);
				apYTop = apYTop(:)';

				% weighted SSD
				d = dist2(a,b) + dist2(apXLeft,bpXLeft) + dist2(apYTop,bpYTop);

				% found best distance
				if(d < bestDist)
					bestDist = d;
					bestA = {AYRange,AXRange};
				end
			end

			



			if(false)
				%set best patch to be in Bp
				bestA = Ap(bestA{1},bestA{2},:);
				for y = bYRange
					for x = bXRange
						p = bestA(y - bYRange(1) + 1, x - bXRange(1) + 1, :);

						% blend linearly horizontally
						if(bx-patchSize >= 1)
							Bp(y, x, :) = 0.5*p + 0.5*bpXLeft(y - bYRange(1) + 1, x - bXRange(1) + 1, :);
						end

						% TODO also blend vertically

					end
				end
			end
			
		end
	end

	output = Bp;
end

