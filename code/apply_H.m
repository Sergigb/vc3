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
Hc1 = c1*H
Hc2 = c2*H
Hc3 = c3*H
Hc4 = c4*H

% -----------------------------------------------------------------------
% 15. You are working with homogeneous coordinates so your corners should
% be homogeneous to. Make them homogeneous.
% -----------------------------------------------------------------------
% Hc1h = ...
% Hc2h = ...
% Hc3h = ...
% Hc4h = ...
        
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
% [X,Y] = meshgrid(...,...);

% 16.2 Check how much rows and columns we will have subtracting the min to
% the max and adding 1
% Ncols = ...
% Nrows = ...

% Now we create a variable W with the same number of rows and columns and
% add it to a vector that we will call XYW
W = ones(Nrows,Ncols);
XYW = [X(:) Y(:) W(:)]';

% 16.3 invert the homography
% Hi = ...

% 16.4 Multiply the inverted homography by the points XYW
HiXYWs = Hi * XYW;

% We turn them to their original shape
HX = reshape(HiXYWs(1,:), Hnrows, Hncols);
HY = reshape(HiXYWs(2,:), Hnrows, Hncols);
HW = reshape(HiXYWs(3,:), Hnrows, Hncols);

% 16.5 Make the coordinates homogeneous
% HX = ...
% HY = ...

% This transforms the image
I_trans = zeros(Hnrows, Hncols, nchan);
for c=1:nchan,
    I_trans(:,:,c) = interp2(double(I(:,:,c)), HX, HY, 'linear', 0);
end