function [I_trans] = apply_H(I,H)
% Apply the transformation H to the image I

% Get theinput image size
[nrows, ncols, nchan] = size(I);

% Get the image corners in homogeneous coordinates
c1 = [1 1 1]';
c2 = [ncols 1 1]';
c3 = [1 nrows 1]';
c4 = [ncols nrows 1]';

% -----------------------------------------------------------------------
% 14. Multiply the homography for each of the corners so we can know when
% they will lie and the new size of the image.
% -----------------------------------------------------------------------

Hc1 = H*c1;
Hc2 = H*c2;
Hc3 = H*c3;
Hc4 = H*c4;

% -----------------------------------------------------------------------
% 15. You are working with homogeneous coordinates so your corners should
% be homogeneous to. Make them homogeneous.
% -----------------------------------------------------------------------
Hc1h = Hc1./Hc1(3);
Hc2h = Hc2./Hc2(3);
Hc3h = Hc3./Hc3(3);
Hc4h = Hc4./Hc4(3);


% Compute extremal transformed corner coordinates so we know the size and
% the shape our new images will have
xmin = round(min([Hc1h(1) Hc2h(1) Hc3h(1) Hc4h(1)]));
xmax = round(max([Hc1h(1) Hc2h(1) Hc3h(1) Hc4h(1)]));
ymin = round(min([Hc1h(2) Hc2h(2) Hc3h(2) Hc4h(2)]));
ymax = round(max([Hc1h(2) Hc2h(2) Hc3h(2) Hc4h(2)]));

% -----------------------------------------------------------------------
% 16. Now we have to compute the same for each point in the image.
% -----------------------------------------------------------------------
% 16.1 Do a meshgrid from xmin to xmax and from ymin to ymax to obain all
% the X and Y cooordinate pairs of the image.

if (xmax - xmin) + 1 > 6000
    I_trans = [0,0];
    return
end
if (ymax - ymin) + 1 > 6000
    I_trans = [0,0];
    return
end

[X,Y] = meshgrid(xmin:xmax,ymin:ymax);

% 16.2 Check how much rows and columns we will have subtracting the min to
% the max and adding 1
Ncols = (xmax - xmin) + 1;
Nrows = (ymax - ymin) + 1;

% Now we create a variable W with the same number of rows and columns and
% add it to a vector that we will call XYW
W = ones(Nrows,Ncols);
XYW = [X(:) Y(:) W(:)]';

clear X
clear Y
clear W

% 16.3 invert the homography
Hi = inv(H);

% 16.4 Multiply the inverted homography by the points XYW
HiXYWs = Hi * XYW;

clear XYW

% We turn them to their original shape
HX = reshape(HiXYWs(1,:), Nrows, Ncols);
HY = reshape(HiXYWs(2,:), Nrows, Ncols);
HW = reshape(HiXYWs(3,:), Nrows, Ncols);

% 16.5 Make the coordinates homogeneous
HX = HX./HW;
HY = HY./HW;

clear HW

% This transforms the image
I_trans = zeros(Nrows, Ncols, nchan);
for c=1:nchan,
    I_trans(:,:,c) = interp2(double(I(:,:,c)), HX, HY, 'linear', 0);
end