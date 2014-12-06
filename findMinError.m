% runs dijkstra, find min error, split image
function output = findMinError(im1, im2, isLeft2Right)
	
	sizeIm = size(im1);
	imDiff = abs(im1 - im2);

	% 4 values: left, top, right, bottom
	edges = Inf(sizeIm(1), sizeIm(2), 4);

	G = zeros(sizeIm(1)*sizeIm(2),sizeIm(1)*sizeIm(2));

	% compute the edges
	for y = 1:sizeIm(1)
		for x = 1:sizeIm(2)

			p = imDiff(y,x,:);

			if(x-1 >= 1) % left
				pl = imDiff(y,x-1,:);
				G((y-1)*sizeIm(2) + x, (y-1)*sizeIm(2) + x - 1) = pixelDiff(p,pl);
			end
			if(y+1 <= sizeIm(1)) % top
				pt = imDiff(y+1,x,:);
				G((y-1)*sizeIm(2) + x, (y)*sizeIm(2) + x) = pixelDiff(p,pt);
			end
			if(x+1 <= sizeIm(2)) % right
				pr = imDiff(y,x+1,:);
				G((y-1)*sizeIm(2) + x, (y-1)*sizeIm(2) + x + 1) = pixelDiff(p,pr);
			end
			if(y-1 >= 1) % bottom
				pb = imDiff(y-1,x,:);
				G((y-1)*sizeIm(2) + x, (y-2)*sizeIm(2) + x) = pixelDiff(p,pb);
			end
		end
	end

	G = sparse(G);

	%[dist,paths,pred] = graphshortestpath(G,1);


	% compute image by shortest path separation

	output = 0.5*im1 + 0.5*im2;
end


function d = pixelDiff(p1,p2)
	x = p1(1,1,1) - p2(1,1,1);
	y = p1(1,1,2) - p2(1,1,2);
	z = p1(1,1,3) - p2(1,1,3);

	d = x*x + y*y + z*z;
end