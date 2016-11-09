%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: calculateDisparity.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [disparityMap] = calculateDisparity(leftImage, rightImage)
% this function takes as inputs the grayscale rectified left and right stereo images
% and returns the corresponding disparityMap using dynamic programming.

    % convert images to double precision for calculations
    leftImage = im2double(leftImage);
    rightImage = im2double(rightImage);

    % determine size of images
    [rows, cols] = size(leftImage);

    % allocate space for disparity map.
    disparityMap = zeros(rows, cols);
    
    % set occ constant.
    occ = 0.01;

    % loop through rows and call dynamic programming function to return the row
    % vector of the disparity map.
    for row = 1:rows
        % call getDisparity function with corresponding scanlines in left and 
        % right images to return row vector of disparities.
        dispVec = getDisparity(leftImage(row,:), rightImage(row,:), occ);
        disparityMap(row,:) = dispVec;
    end

end