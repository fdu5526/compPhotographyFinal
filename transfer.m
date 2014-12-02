function [done] = transfer()
	% load data
	data = loadRiver();
	A = data{1}; Ap = data{2}; B = data{3};

	% create the image analogy
	Bp = createImageAnalogy(A, Ap, B);

	% show/save the image
	imshow(Bp);

end



% load the river data
function [data] = loadRiver()
	A = im2double(imread('input/riverA.jpg'));
	Ap = im2double(imread('input/riverAp.jpg'));
	B = im2double(imread('input/riverB.jpg'));
	data = {A,Ap,B};
end
