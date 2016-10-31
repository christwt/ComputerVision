%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 3: calcDisparity.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [disparityMap] = calcDisparity(leftImage, rightImage, dMin, dMax, winSize)
% This function will calculate the disparity map between stereo images using SSD algorithm. 
% inputs: 
%    leftImage (reference), rightImage, dmin(minimum disparity value),
%    dmax(maximum disparity value), winSize(window size for calculation).
%    DepthEstimationFromStereoVideo uses disparity range 0-64.
    
% as DepthEstimationFromStereoVideo.m rectifies the images prior to calling
% disparity, pixels in two images will share the same row and same vertical
% scaling.

    % determine sizes of images. Compute gaussian filter based on window size. 
    [rows, cols] = size(leftImage);
    
    % convert images to double precision for calculations. 
    leftImage = im2double(leftImage);
    rightImage= im2double(rightImage);
    
    % pad image based on disparity in order to extend to corners NaNs will be ignored in calculations. 
    pad = NaN(rows, dMax);
    rightImage = horzcat(rightImage, pad);
    
    % initialize dispMap to be the size of leftImage && rightImage
    disparityMap = zeros(rows, cols);
    
    % determine center pixel of window.
    centerPixel = ((winSize-1)/2);
    
    % increased computation speed with vectorized approach with window size 1 
    if winSize == 1
        % loop through left image, obtain pixel value. 
        for row = 1+centerPixel:rows-centerPixel  
            for col = 1+centerPixel:cols-centerPixel
                
                left = leftImage(row,col);
                %create disparity vector containing x+disparity 0-64
                right = rightImage(row, col+dMin:col+dMax-1);
                
                % compute squared differences.
                SSD = (left-right).^2;
                
                % locate the lowest SSD score. 
                disp = find(SSD == min(SSD));
                
                % our best match is the disparity at that location.
                % Rule: should there be more than one index with min(vec2)
                % use first indexed location
                bestMatch = disp(1);
               
                %place in disparity map.
                disparityMap(row,col) = bestMatch-1;
            end
        end
    end
    
    % matrix/vectorized approach to window sizes > 1.
    if winSize > 1
        % loop through image.
       for row = 1+centerPixel:rows-centerPixel
           for col = 1+centerPixel:cols-centerPixel
               
               %left window. size = [winSize, winSize]
               left = leftImage(row-centerPixel:row+centerPixel, col-centerPixel:col+centerPixel);
               left = repmat(left,1,65);

               % calculate 0 disparity window.
               right = rightImage(row-centerPixel:row+centerPixel, col-centerPixel:col+centerPixel);
               % concatenate windows of increasing disparity. 
               for d = 1:64
                  % new disparity location. 
                  c = col+d;
                  
                  % create window based on pixel center. 
                  window = rightImage(row-centerPixel:row+centerPixel, c-centerPixel:c+centerPixel);
                  
                  % concatenate matrices to create disparity region.
                  right = horzcat(right, window);
               end
               
               % compute SSD of each pixel in region.
               SSD = (left-right).^2;
               
               % apply gaussian filter. 
               SSD = imgaussfilt(SSD, 'FilterSize', winSize);
               
               % reshape matrix to 9 x 65 for win 3, 25 x 65 for win 5
               SSD = reshape(SSD, winSize.^2, 65);

               % sum disparities by window. 
               SSD = sum(SSD);
               
               % determine lowest SSD score. 
               disp = find(SSD == min(SSD));
               
               % Rule: if more than 1 best matching disparity then choose
               % first indexed disparity. 
               bestMatch = disp(1);
               
               % update disparityMap with calculate disparity. 
               disparityMap(row,col) = bestMatch-1;
           end
       end
    end


% NAIVE IMPLEMENTATION FIRST ATTEMPTED.
%     if winSize > 1 
%         % step through image pixels just as above.
%         for row = 1+centerPixel:rowsLeft-centerPixel
%             for col = 1+centerPixel:colsLeft-centerPixel-dMax
%                 % In each column we initialize a temp to store the previous
%                 % score. % initialize to large value as we want to minimize SSD.
%                 prev = realmax;
%                 % track the best match of disparity. 
%                 bestMatch = dMin;
%                 % for each disparity score.
%                 for disparity = dMin:dMax
%                     % apply our window to each image at corresponding (row,col)
%                     % location in left and (row,col+disparity) in right
%                     left = leftImage(row-centerPixel:row+centerPixel, col-centerPixel:col+centerPixel);
%                     right = rightImage(row-centerPixel:row+centerPixel, col+disparity-centerPixel:col+disparity+centerPixel);
%                     % calculate SSD based on disparity. 
%                     ssd = (left - right).^2;
%                     % if window size > 1 convolve with gaussian filter 
%                     ssd = conv2(ssd, gauss);
%                     % final score from summing values in ssd
%                     ssdScore = sum(sum(ssd));
%                
%                     % replace previous disparity score with new score if smaller
%                     % want to minimize SSD score
%                     if prev > ssdScore
%                         % update prev score.
%                         prev = ssdScore;
%                         % update best disparity. 
%                         bestMatch = disparity;
%                     end
%                 end
%                 % update disparity map with best matching disparity.
%                 disparityMap(row,col) = bestMatch;
%             end
%         end
%     end
end
