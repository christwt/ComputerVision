%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: getDisparity.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dispVec] = getDisparity(leftVec, rightVec, occ)
% This function takes as inputs a left scanline vector, a right scanline
% vector and an occlusion value and returns the calculated disparities
% using the absolute difference between pixel intensity values.

% cost function: d(i,j) = (leftImage(i)-rightImage(j)).^2

    % determine number of columns in row vector.
    len = size(leftVec, 2);
    % size of cost matrix
    rows = len + 1;
    cols = len + 1;

    % allocate matrix to store costs.
    costMat = zeros(rows, cols);

    % allocate direction matrix for backtracking.
    dirMat = zeros(rows, cols);

    % set up cost matrix:
    % first col = D(rows, 0) = rows * occ
    for row = 1:rows
        costMat(row, 1) = row * occ; 
    end
    % first row = D(0, cols) = cols * occ
    for col = 2:cols
        costMat(1, col) = col * occ;
    end

    % loop through cost matrix and perform dynamic programming calculations.
    % do not use dispMax. instead calculate entire table and update
    % entire direction matrix.
    for r = 2:rows
        for c = 2:cols
            %costMat(2,2) = d11 = (Il(1)-Ir(1)).^2
            if r == 2 && c == 2
               NW = (leftVec(r-1)-rightVec(c-1)).^2;
               costMat(r,c) = NW;
               dirMat(r,c) = 1;
            else
                % d(i,j) = min(D(i-1, j-1) + d(i,j), D(i-1,j) + occ, D(i,j-1) + occ
                NW = costMat(r-1, c-1) + (leftVec(r-1)-rightVec(c-1)).^2;
                N = costMat(r-1, c) + occ;
                W = costMat(r, c-1) + occ;
                % determine min of above (N, W, NW).
                % update direction matrix depending on min. NW = 1, N = 2, W = 3;
                if NW < N && NW < W
                    costMat(r, c) = NW;
                    dirMat(r,c) = 1;
                elseif N < NW && N < W
                    costMat(r,c) = N;
                    dirMat(r,c) = 2;
                else
                    costMat(r,c) = W;
                    dirMat(r,c) = 3;
                end
            end
        end
    end

    % allocate column vector to store disparities. initialize to NaN so we
    % don't have to update occluded pixels.
    vec = NaN(1, len);
    % call backtracking function in order to return disparity vector
    % pass the direction matrix and row vector to fill.
    dispVec = backtrack(dirMat, vec); 

end