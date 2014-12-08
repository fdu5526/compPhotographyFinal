% runs dijkstra, find min error, split image
function output = combineMiddle(im1, im2, isLeft2Right)
	
	sizeIm = size(im1);
	imDiff = abs(im1 - im2);

	% the graph, index is (width*(y-1) + x)
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

	botMid = sizeIm(2)/2;
	topMid = (sizeIm(1)-1)*sizeIm(2) + botMid;
	[dist,paths,pred] = graphshortestpath(G,botMid,topMid);

	p = 1;
	paths = sort(paths);
	im = zeros(sizeIm);

	if(isLeft2Right)
		% merge the 2 images
		for y = 1:sizeIm(1)
			for x = 1:sizeIm(2)

				if(p <= size(paths,2))
					px = mod(paths(p), sizeIm(2));
				else
					px = 0;
				end

				if(px < x)
					im(y,x,:) = im2(y,x,:);
				elseif(px == x)
					p = p + 1;
					im(y,x,:) = 0.5*im1(y,x,:) + 0.5*im2(y,x,:);
				else
					im(y,x,:) = im1(y,x,:);
				end
			end
		end
	end

	output = im;
end


function d = pixelDiff(p1,p2)
	x = p1(1,1,1) - p2(1,1,1);
	y = p1(1,1,2) - p2(1,1,2);
	z = p1(1,1,3) - p2(1,1,3);

	d = x*x + y*y + z*z;
end