%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 3: calcNCC3
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [disparityMap] = calcNCC3(leftImage, rightImage, dMin, dMax, winSize)
    % convert image to double precision.
    leftImage = im2double(leftImage);
    rightImage = im2double(rightImage);
    
    % determine size for disparity map.
    [rows, cols] = size(leftImage);
    
    % allocate disparityMap
    disparityMap = zeros(rows, cols);
    
    % determine distance to center of window
    centerPixel = (winSize-1)/2;
    
    % pad image to extend area to be checked NaN's are ignored.
    pad = NaN(rows, dMax);
    rightImage = horzcat(rightImage, pad);
    
    % loop through image pixels. 
    for row = 1+centerPixel: rows-centerPixel
        for col = 1+centerPixel: cols-centerPixel
            
            % determine area of left window. 
            left = leftImage(row-centerPixel:row+centerPixel, col-centerPixel:col+centerPixel);
            
            % normalization of window for NCC.
            % calculation from ppt slides: http://www.cse.psu.edu/~rtc12/CSE486/lecture07.pdf
            % determine mean.
            ml = mean2(left);
            
            % numerator: window-mean of window pixels.  
            numl = left-ml;
            
            % denominator: std error of window patch
            denl = sqrt(sum(sum((left-ml).^2)));
            
            % error checking for areas where all pixels match. std = 0 in
            % this case which breaks NCC.
            if denl == 0
                denl = 1;
            end
            % normalize window. 
            left = numl/denl;
            % replicate left window to fit area of interest in right Image.
            left = repmat(left, 1, 65);
            
            % determine window for disparity val of 0. 
            right = rightImage(row-centerPixel:row+centerPixel, col-centerPixel:col+centerPixel);
            
            % normalize as above. 
            mr = mean2(right);
            numr = right-mr;
            denr = sqrt(sum(sum((right-ml).^2)));
            if denr == 0
                denr = 1;
            end
            right = numr/denr;
            
            % loop through remaining disparity levels, create window,
            % normalize and then concatenate on right to create window of
            % interest for calculation.
            for d = 1:64
               c = col + d;
               window = rightImage(row-centerPixel:row+centerPixel, c-centerPixel:c+centerPixel);
               mw = mean2(window);
               numw = window-mw;
               denw = sqrt(sum(sum((window-mw).^2)));
               if denw == 0
                   denw = 1;
               end
               window = numw/denw;
               right = horzcat(right, window);
            end
            
            % perform correlation step on normalized pixels in region of interest.
            NCC = left.*right;
            
            % reshape to create vectors of windows. 
            NCC = reshape(NCC, winSize.^2, 65);
            
            % sum NCC scores. 
            NCC = sum(NCC);
            
            % determine the maximum score. 
            disp = find(NCC == max(NCC));
            
            % Current RULE: if there is more than one max NCC score, take
            % the first index.
            bestMatch = disp(1);
            
            % update the disparity map with calculate disparity. 
            disparityMap(row, col) = bestMatch-1;
        end
    end
    
    
    

end