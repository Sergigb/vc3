

function [H] = dlt(points)
% The Direct Linear Transform (DLT) algorithm is a simple algorithm used
% to solve for the homography matrix H given a sufficient set of point 
% correspondences.

% Homography initialization
H = zeros(3,3);
n = numel(points);

% -----------------------------------------------------------------------
% 10. Split points in pt1 and pt2, corresponding to each image. Then,
% convert the points to homogeneous coordinates. 
% http://robotics.stanford.edu/~birch/projective/node4.html
% -----------------------------------------------------------------------
pt1 = points(1:2, :);
pt2 = points(3:4, :);

% Homogeneous coordinates
pt1h = pt1;
pt1h(3,:)=1;
pt2h = pt2;
pt2h(3,:)=1;
   
% Attempt to normalise each set of points so that the origin 
% is at centroid and mean distance from origin is sqrt(2).
 [pt1n, T1] = normalise2dpts(pt1h);
 [pt2n, T2] = normalise2dpts(pt2h);

% Solving systems of equations. -----------------------------------------
% When we want to solve a system so that Ax = b, what we want to find is x,
% it can be quite simple sayingt that x = b/A but it is not true because
% normally A is not invertible so we have to solve it in a different way.
% A is the equation matrix. Each of the rows is a different equation and
% each of the columns is an unknown variable for which we are solving the
% system of equations.
% A initialization
A = zeros(2*n,9);

% Fill A with the proper values at each point
for i=1:n
    % A(2*i-1,1:3) = ...
    % A(2*i-1,4:6) = ...
    % A(2*i-1,7:9) = ...
    % A(2*i,1:3) = ...
    % A(2*i,4:6) = ...
    % A(2*i,7:9) = ...
end

% -----------------------------------------------------------------------
% 11. Solve A applying Singular Value Decomposition to A.
% http://es.mathworks.com/help/matlab/ref/svd.html?s_tid=srchtitle
% -----------------------------------------------------------------------
% [U,D,V] = ...

% -----------------------------------------------------------------------
% 12. Take the last column of the transposed of V, that's the singular
% vector with the lowest singular value.
% -----------------------------------------------------------------------
% h = ...

% -----------------------------------------------------------------------
% 13. Reshape h to be a 3x3 matrix.
% -----------------------------------------------------------------------
% H = ...

end