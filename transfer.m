function [done] = transfer()
	% load data
	data = loadRiver();
	A = data{1}; Ap = data{2}; B = data{3};

	% create the image analogy
	Bp = createImageAnalogy(A, Ap, B);

	% show/save the image
	imshow(Bp);

end


% load the test data
function [data] = loadTest()
	A = im2double(imread('input/test/testA.jpg'));
	Ap = im2double(imread('input/test/testAp.jpg'));
	B = im2double(imread('input/test/testB.jpg'));
	data = {A,Ap,B};
end


% load the river data
function [data] = loadRiver()
	A = im2double(imread('input/river/riverA.jpg'));
	Ap = im2double(imread('input/river/riverAp.jpg'));
	B = im2double(imread('input/river/riverB.jpg'));
	data = {A,Ap,B};
end
