
clearvars,
close all,
clc,

% IMPORTANT. Don't touch the code here, make place your code and images as
% you need to make it work but DON'T CHANGE THIS LINES -------------------

% TODO. Uncomment one dataset at a time.
% addpath('../ciencies')
% addpath('../cnm')
addpath('../etse')
% addpath('../iiia')

% TODO. Edit and uncomment this line to ass your dataset to the path
% addpath('mydataset')

% YOUR CODE STARTS HERE  -------------------------------------------------


% PROBLEM 1 -------------------------------------------------------------

% -----------------------------------------------------------------------
% 1. Read the images taking into account that they are part of a circular
% sequence. That means that the right image for the last one is the first
% one. So all the images have a right and left neighbour.
% -----------------------------------------------------------------------

images = cell(17,1);

for i=1:17
    images{i}=imread(strcat(num2str(i,'%05d'),'.jpg'));
end

% IMPORTANT. ld is a parameter that allows you to pick the points or load
% them. When you deliver the lab the load option should be selected (1) in
% order to pass the lab. If it is not selected the points won't be loaded
% and the rest of the lab could not be corrected.
ld = 1;     % Load a previous matrix of points (1), pick new points (0)
np = 4;     % Number of points to pick.

% -----------------------------------------------------------------------
% 2. Fill the gaps in pick_points function and use it to select the points
% along all your sequence.
% -----------------------------------------------------------------------

%h,w intercambiados


[points] = interest_points(images, ld, np);

% -----------------------------------------------------------------------
% 8. Now that you have the points loaded in the workspace, check if you
% loaded them well ploting the points over the images. Take into account
% that the points from image 2 have a displacement in x equal to the size
% of the images in the second dimension;
% -----------------------------------------------------------------------
show_points = 1;
[h,w,l] = size(images{1});
if show_points == 1
    for i=1:size(images,1)-1
    imshow([images{i,1}, images{i+1,1}]); hold on,
    
    % Plot of the points over the image 1
    pts1 = points{i}(1:2,:);
    plot(points{i}(2, :) , points{i}(1, :) ,'y+');
    
    % Plot of the points over the image 2 with displacement
    pts2 = points{i}(3:4,:);
    plot(points{i}(4, :)+w, points{i}(3, :),'c+');
    
    hold off,
    pause(0.005)
    end
end


% PROBLEM 2 --------------------------------------------------------------

% -----------------------------------------------------------------------
% 9. Compute the homography (using the DLT algorithm) (use the provided
% reference). Fill the DLT Function and the apply_H function 
% -----------------------------------------------------------------------
H = cell(numel(images),1);
for i=1:numel(images) % Special case when i = numel(images)
    % TODO. Fill the dlt function
    H{i} = dlt(points{i});
    
end

for i=1:numel(images) % Maybe you have to change this values
    
    % TODO. Fill the apply_H function for the left image
    [img_transformed] = apply_H(images{i,1}, inv(H{i}));%%CAMBIAR A H{i-1} Y LOS INTERVALOS !O O!OK !OK O!
    
    % TODO. Fill the apply_H function for the right image
    % [img_transformed] = apply_H(..., H{i})
end

% TODO. Solve here the extremum cases

% PROBLEM 3 --------------------------------------------------------------
% Place here the code you need to perform the same before with your images.

% OPTIONAL 1 -------------------------------------------------------------

% OPTIONAL 2 -------------------------------------------------------------

% OPTIONAL 3 -------------------------------------------------------------

% OPTIONAL 4 -------------------------------------------------------------

