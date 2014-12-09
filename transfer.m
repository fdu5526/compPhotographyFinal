function [done] = transfer()
	% load data
	data = loadPainting2();
	A = data{1}; Ap = data{2}; B = data{3}; name = data{4};

	% create the image analogy
	Bp = createImageAnalogy(A, Ap, B);

	% show/save the image
	imwrite(Bp,name);
	%imshow(Bp);

end


% load the coast data
function [data] = loadCoast()
	A = im2double(imread('input/coast/coastA.jpg'));
	Ap = im2double(imread('input/coast/coastAp.jpg'));
	B = im2double(imread('input/coast/coastB.jpg'));
	data = {A,Ap,B,'coast.jpg'};
end


% load the city data
function [data] = loadCity()
	A = im2double(imread('input/city/cityA.jpg'));
	Ap = im2double(imread('input/city/cityAp.jpg'));
	B = im2double(imread('input/city/cityB.jpg'));
	data = {A,Ap,B,'city.jpg'};
end

% load the Painting2 data
function [data] = loadPainting2()
	A = im2double(imread('input/painting2/painting2A.jpg'));
	Ap = im2double(imread('input/painting2/painting2Ap.jpg'));
	B = im2double(imread('input/painting2/painting2B.jpg'));
	data = {A,Ap,B,'painting2.jpg'};
end


% load the Painting data
function [data] = loadPainting()
	A = im2double(imread('input/painting/paintingA.jpg'));
	Ap = im2double(imread('input/painting/paintingAp.jpg'));
	B = im2double(imread('input/painting/paintingB.jpg'));
	data = {A,Ap,B,'painting.jpg'};
end


% load the Obama data
function [data] = loadObama2()
	A = im2double(imread('input/obama2/obama2A.jpg'));
	Ap = im2double(imread('input/obama2/obama2Ap.jpg'));
	B = im2double(imread('input/obama2/obama2B.jpg'));
	data = {A,Ap,B,'obama2.jpg'};
end


% load the Obama data
function [data] = loadObama()
	A = im2double(imread('input/obama/obamaA.jpg'));
	Ap = im2double(imread('input/obama/obamaAp.jpg'));
	B = im2double(imread('input/obama/obamaB.jpg'));
	data = {A,Ap,B,'obama.jpg'};
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
