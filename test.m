function done = test()
	im1 = im2double(imread('input/test1.jpg'));
	im2 = im2double(imread('input/test2.jpg'));

	halfWidth = round(size(im1,2)/2);
	width = size(im1,2);

	im1p = im1(:,halfWidth:width,:);
	im2p = im2(:,1:(halfWidth+1),:);

	imMid = findMinError(im1p,im2p,true);

	im = zeros(size(im1,1),width + halfWidth,3);


	im(:,1:(halfWidth-1),:) = im1(:,1:(halfWidth-1),:);
	im(:,halfWidth:width,:) = imMid(:,:,:);
	im(:,(width+1):(width + halfWidth),:) = im2(:,(halfWidth+1):width,:);



	imshow(im);
end