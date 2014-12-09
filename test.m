function done = test()
	im1 = im2double(imread('input/test1.jpg'));
	im2 = im2double(imread('input/test2.jpg'));

	horizontalMerge(im1, im2);
	done = 0;
end



function done = horizontalMerge(im1, im2)

	halfWidth = round(size(im1,2)/2);
	width = size(im1,2);

	im1p = im1(:,halfWidth:width,:);
	im2p = im2(:,1:(halfWidth+1),:);

	imMid = combineMiddle(im1p,im2p,true);

	im = zeros(size(im1,1),width + halfWidth,3);

	im(:,1:(halfWidth-1),:) = im1(:,1:(halfWidth-1),:);
	im(:,halfWidth:width,:) = imMid(:,:,:);
	im(:,(width+1):(width + halfWidth),:) = im2(:,(halfWidth+1):width,:);

	imshow(im);
	done = 0;
end


function done = verticalMerge(im1, im2)

	halfHeight = round(size(im1,1)/2);
	height = size(im1,1);

	im1p = im1(halfHeight:height,:,:);
	im2p = im2(1:halfHeight,:,:);
	imMid = combineMiddle(im1p,im2p,false);
	
	im = zeros(height + halfHeight,size(im1,2),3);

	im(1:(halfHeight-1),:,:) = im1(1:(halfHeight-1),:,:);
	im(halfHeight:height,:,:) = imMid(:,:,:);

	im((height+1):(height+halfHeight),:,:) = im2(halfHeight:height,:,:);

	imshow(im);

	done = 0;
end