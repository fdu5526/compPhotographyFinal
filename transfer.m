function [done] = transfer()
	% load data
	data = loadRiver2();
	A = data{1}; Ap = data{2}; B = data{3}; name = data{4};

	% create the image analogy
	Bp = createImageAnalogy(A, Ap, B);

	% show/save the image
	imwrite(Bp,name);
	%imshow(Bp);

end

% load the river data
function [data] = loadRiver()
	A = im2double(imread('input/river/riverA.jpg'));
	Ap = im2double(imread('input/river/riverAp.jpg'));
	B = im2double(imread('input/river/riverB.jpg'));
	data = {A,Ap,B,'river.jpg'};
end

% load the river2 data
function [data] = loadRiver2()
	A = im2double(imread('input/river2/river2A.jpg'));
	Ap = im2double(imread('input/river2/river2Ap.jpg'));
	B = im2double(imread('input/river2/river2B.jpg'));
	data = {A,Ap,B,'river2.jpg'};
end
