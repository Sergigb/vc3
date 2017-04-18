
% IMPORTANT NOTE: This is a function which you have to compute just once, 
% to select the image points and then store them in your 'points' folder.

function [points] = interest_points(images, ld, np)
% ------------------------------------------------------------------------
% 3. Create a points folder and add it to your path (use mkdir)
% ------------------------------------------------------------------------

if ~exist('../points', 'dir')
  mkdir('../points');
end
addpath('../points');

% ------------------------------------------------------------------------
% 4. Check if the ld flag is set to load data (1) or to select points (0)
% ------------------------------------------------------------------------
if ld == 1
      % ------------------------------------------------------------------
      % 7.- Now that you already selected and saved the points properly, if
      % the load flag is set to 1, you have to load the variable in your
      % workspace. http://es.mathworks.com/help/matlab/ref/load.html
      % ------------------------------------------------------------------
      points = load('points_etse.mat', 'points');  
      points = points.points;
else
      points = cell(numel(images),1);
      
      % ------------------------------------------------------------------
      % 5.- Visit all the images (one and the following one) and call the
      % function pick_points with the two images to show.
      % ------------------------------------------------------------------
      
      for i=1:numel(images)
          im1 = images{i};
          if(i == numel(images))
              im2 = images{1};
          else
              im2 = images{i+1};
          end
            [points{i}] = pick_points(im1, im2, np);
      end
      
      % ------------------------------------------------------------------
      % 6.- Store the variable points in the points folder you created
      % previously with a proper name, for example points_iiia.mat or
      % points_etse.mat, so you will be load to store points from different
      % datasets. http://es.mathworks.com/help/matlab/ref/save.html
      % ------------------------------------------------------------------
      
      save('../points/points_etse.mat', 'points');      
end
    

end

function [points] = pick_points(im1, im2, num)

    points = zeros(4,num);
    
    figure(1), imshow(uint8(im1)); hold on,
    figure(2), imshow(uint8(im2)); hold on,
    
    for p=1:num
        figure(1),
        [y1,x1] = ginput(1);
        plot(y1,x1,'c+');
        
        figure(2),
        [y2,x2] = ginput(1);
        plot(y2,x2,'y+');
        
        points(:,p) = [x1,y1,x2,y2]';
        
        
    end
end