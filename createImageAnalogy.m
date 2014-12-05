function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B); Asize = size(A); Bp = zeros(size(B));

	% independent magic numbers
	searchCount = 100;
	halfPatchSize = 20;

	patchSize = halfPatchSize*2;

	% loop through B
	for by = (1+halfPatchSize):halfPatchSize:(Bsize(1)-halfPatchSize)
		for bx = (1+halfPatchSize):halfPatchSize:(Bsize(2)-halfPatchSize)

			% get data in B
			bYRange = (by-halfPatchSize):(by+halfPatchSize);
			bXRange = (bx-halfPatchSize):(bx+halfPatchSize);
			b = B(bYRange,bXRange,:);
			b = b(:)';

			bXLeft = b;
			if(bx-patchSize >= 1)
				bXLeft = Bp(bYRange, (bx-patchSize):bx, :);
				bXLeft = bXLeft(:)';
			end

			bYTop = b;
			if(by-patchSize >= 1)
				bYTop = Bp((by-patchSize):by, bXRange, :);
				bYTop = bYTop(:)';
			end



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

				% weighted SSD
				d = 2*dist2(a,b) + dist2(a,bXLeft) + dist2(a,bYTop);

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

	output = Bp;
end

