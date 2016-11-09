%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: backtrack.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vec] = backtrack(dirMat, vec)
% This function takes as inputs a direction Matrix and a row vector of
% NaN. This function will perform backtracking based on the direction
% matrix in order to create a row vector of disparities. 

    % obtain size of direction matrix. 
    [rows, cols] = size(dirMat);
    
    % set iterators. 
    r = rows; % left scanline
    c = cols; % right scanline
    
    % stop if we reach index 1 in left/right scanline.
    while(r ~= 1 && c ~= 1)
        % direction matrix lookup. NW = 1
       if dirMat(r, c) == 1
           % calculate disparity based on absolute difference between pixel
           % indices. 
           disparity = abs(r-c);
           % update output row vector.
           vec(r-1) = disparity;
           % update iterators.
           r = r-1;
           c = c-1;
       % direction matrix lookup. N = 2.
       elseif dirMat(r,c) == 2
           % this would indicate an occluded pixel in left scanline,
           % already at NaN so don't need to update row vector. just update
           % iterators. 
           r = r-1;
       % direction matrix lookup. W = 3. 
       elseif dirMat(r,c) == 3
           % this indicates a disoccluded pixel in right scanline, 
           % do nothing except update iterators. 
           c = c-1;
       end       
    end
end