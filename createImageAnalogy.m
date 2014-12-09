function output = createImageAnalogy(A, Ap, B)
	
	rng(1);

	% initial setup
	Bsize = size(B); Asize = size(A); Bp = zeros(size(B));

	% independent magic numbers
	searchCount = 3000;
	halfPatchSize = 4;
	overlapSize = 3;

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
			bpXLeft = zeros(halfPatchSize*2+1, overlapSize+1,3);
			if(bx-patchSize >= 1)
				bpXLeft = Bp(bYRange, (bx-halfPatchSize):(bx-halfPatchSize+overlapSize), :);
			end
			bpXLeftT = bpXLeft(:)';

			% the patch to top of bx by on Bp
			bpYBot = zeros(overlapSize+1,halfPatchSize*2+1,3);
			if(by-patchSize >= 1)
				bpYBot = Bp((by-halfPatchSize):(by-halfPatchSize+overlapSize), bXRange, :);
			end
			bpYBotT = bpYBot(:)';


		



			% generate random coordinates
			ayL = randi([1+halfPatchSize,Asize(1)-halfPatchSize], 1, searchCount);
			axL = randi([1+halfPatchSize,Asize(2)-halfPatchSize], 1, searchCount);
			
			% search in A $searchCount times
			bestARanges = {}; bestDist = 100000;
			for c = 1:searchCount
				ax = axL(c);
				ay = ayL(c);

				% get data in A
				AYRange = (ay-halfPatchSize):(ay+halfPatchSize);
				AXRange = (ax-halfPatchSize):(ax+halfPatchSize);
				a = A(AYRange,AXRange,:);
				a = a(:)';
				apXLeft = Ap(AYRange,(ax-halfPatchSize):(ax-halfPatchSize+overlapSize),:);
				apXLeft = apXLeft(:)';
				apYBot = Ap((ay-halfPatchSize):(ay-halfPatchSize+overlapSize),AXRange,:);
				apYBot = apYBot(:)';

				% weighted SSD
				d = 5*dist2(a,b) + dist2(apXLeft,bpXLeftT) + dist2(apYBot,bpYBotT);

				% found best distance
				if(d < bestDist)
					bestDist = d;
					bestARanges = {AYRange,AXRange};
				end
			end

			% calculate min error for combining correctly
			bestAp = Ap(bestARanges{1}, bestARanges{2}, :);
			bestApLeft = bestAp(:,1:(overlapSize+1),:);
			bestApBot = bestAp(1:(overlapSize+1),:,:);
			bpXLeftNew = combineMiddle(bpXLeft, bestApLeft, true);
			bpXBotNew = combineMiddle(bpYBot, bestApBot, false);
			

			yRange = (by-halfPatchSize+overlapSize+1):(by+halfPatchSize);
			xRange = (bx-halfPatchSize+overlapSize+1):(bx+halfPatchSize);
			Bp(yRange, xRange,:) = bestAp((overlapSize+2):size(bestAp,1), (overlapSize+2):size(bestAp,2),:);

			% assign combined images to output
			Bp((by-halfPatchSize):(by-halfPatchSize+overlapSize), bXRange,:) = bpXBotNew;	 % combine bottom
			Bp(bYRange, (bx-halfPatchSize):(bx-halfPatchSize+overlapSize),:) = bpXLeftNew; % combine left


		end
	end

	output = Bp;
end

