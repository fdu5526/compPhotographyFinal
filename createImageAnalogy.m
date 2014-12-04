function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B); Asize = size(A); Bp = zeros(size(B));

	% independent magic numbers
	searchCount = 50;
	halfPatchSize = 4;

	patchSize = halfPatchSize*2+1;

	% loop through B
	for by = (1+halfPatchSize):patchSize:(Bsize(1)-halfPatchSize)
		for bx = (1+halfPatchSize):patchSize:(Bsize(2)-halfPatchSize)

			% get map in B (real photograph)
			bYRange = (by-halfPatchSize):(by+halfPatchSize);
			bXRange = (bx-halfPatchSize):(bx+halfPatchSize);
			b = B(bYRange,bXRange,:);
			b = b(:)';

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

				% SSD distance
				d = dist2(a,b);

				% found best distance
				if(d < bestDist)
					bestDist = d;
					bestA = {AYRange,AXRange};
				end
			end

			% set best patch to be in Bp
			Bp(bYRange, bXRange, :) = Ap(bestA{1},bestA{2},:);
		end
	end

	imshow(Bp)
	output = Bp;
end

