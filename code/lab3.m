
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
addpath('../etse2')

% YOUR CODE STARTS HERE  -------------------------------------------------


% PROBLEM 1 -------------------------------------------------------------
% 
% -----------------------------------------------------------------------
% 1. Read the images taking into account that they are part of a circular
% sequence. That means that the right image for the last one is the first
% one. So all the images have a right and left neighbour.
% -----------------------------------------------------------------------

images = cell(17,1);

for i=1:17
    images{i}=imread(strcat('../etse/', num2str(i,'%05d'),'.jpg'));
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

[points] = interest_points(images, ld, np);

% -----------------------------------------------------------------------
% 8. Now that you have the points loaded in the workspace, check if you
% loaded them well ploting the points over the images. Take into account
% that the points from image 2 have a displacement in x equal to the size
% of the images in the second dimension;
% -----------------------------------------------------------------------
show_points = 0;
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

if ~exist('../results', 'dir')
  mkdir('../results');
end
addpath('../results');

for i = 1:numel(images)
    % TODO. Fill the apply_H function for the left image hacer esto de
    % nuevo
    if i == 1
        index = 18;
    else
        index = i;
    end
    % TODO. Fill the apply_H function for the left image
    [img_transformed1] = apply_H(images{index-1}, inv(H{index-1}));
    img_transformed1 = uint8(img_transformed1);
    name = strcat('../results/etse_image_', int2str(i), '_left.jpeg');
    imwrite(uint8(img_transformed1), name);
    % TODO. Fill the apply_H function for the right image
    if i == 17
        index = 1;
    else
        index = i+1;
    end
    [img_transformed2] = apply_H(images{index},  H{i});
    name = strcat('../results/etse_image_', int2str(i), '_right.jpeg');
    img_transformed2 = uint8(img_transformed2);
    imwrite(uint8(img_transformed2), name);
    
end
clear images;

% TODO. Solve here the extremum cases

% PROBLEM 3 --------------------------------------------------------------
% Place here the code you need to perform the same before with your images.
images = cell(10,1);

for i=1:10
    images{i}=imread(strcat('../etse2/', num2str(i,'%05d'),'.jpg'));
end

ld = 1;
np = 4;

[points] = interest_points2(images, ld, np);

show_points = 0;
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

H = cell(numel(images),1);
for i=1:numel(images) % Special case when i = numel(images)
    % TODO. Fill the dlt function
    H{i} = dlt(points{i});
    
end

if ~exist('../results', 'dir')
  mkdir('../results');
end
addpath('../results');

for i = 1:numel(images)
    % TODO. Fill the apply_H function for the left image
    if i == 1
        index = 11;
    else
        index = i;
    end
    % TODO. Fill the apply_H function for the left image hacer esto de
    % nuevo
    [img_transformed1] = apply_H(images{index-1}, inv(H{index-1}));
    img_transformed1 = uint8(img_transformed1);
    name = strcat('../results/etse2_image_', int2str(i), '_left.jpeg');
    imwrite(uint8(img_transformed1), name);
    % TODO. Fill the apply_H function for the right image
    if i == 10
        index = 1;
    else
        index = i+1;
    end
    [img_transformed2] = apply_H(images{index},  H{i});
    name = strcat('../results/etse2_image_', int2str(i), '_right.jpeg');
    img_transformed2 = uint8(img_transformed2);
    imwrite(uint8(img_transformed2), name);
    
end
% OPTIONAL 1 -------------------------------------------------------------

% OPTIONAL 2 -------------------------------------------------------------

% OPTIONAL 3 -------------------------------------------------------------

% OPTIONAL 4 -------------------------------------------------------------

