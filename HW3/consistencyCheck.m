%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 3: consistencyCheck.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [outlierMap] = consistencyCheck(LR, RL, TLR)
% This function accepts as inputs a LR disparity map and RL disparity map,
% and performs a left-right consistency check, returning a binary image in
% which outliers to the relation abs(dlr(x)-drl(x+dlr(x)) <= TLR have the
% value 1 and the inliers have a value 0. Note that we have used fliplr to
% flip the images in order to utilize the same disparity function.

    % determine size of output image. 
    [rows, cols] = size(LR);

    % allocate output binary image. 
    outlierMap = zeros(rows, cols);
    
    % traverse through outlier map
    % traverse pixels in outlier map.
    for row = 1:rows
        for col = 1:cols
            % obtain disparity at position in LR.
            dlr = LR(row,col);
            % position along epipolar line.
            x = col;
            % if out of bounds.
            if x+dlr<1||x+dlr>cols
                % outlier
                outlierMap(row, col) = 1;
            else
            % obtain disparity at position x+dlr in RT.
                xdlr = round(x+dlr);
                drl =  RL(row, xdlr);
                % check relation.
                if abs(dlr-drl) <= TLR
                    % inlier
                    outlierMap(row,col) = 0;
                else
                    % outlier 
                    outlierMap(row,col) = 1;
                end
            end
        end
    end
end