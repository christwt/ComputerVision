%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: printLCS.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function printLCS(dirMat, string, i, j, chars)
% This function takes as inputs a sequence for referencing, table of recorded direction values, 
% iterators i,j to search direction table, and array to store the output.
% This function will recursively call itself in order to print out the
% longest common sub-sequence of the 2 sequences.

    % base case, return longest sub-sequence, use fliplr to print in the
    % correct direction.
    if i == 1 || j == 1
        fprintf('\tLongest common sub-sequence found: "%s"\n\n', fliplr(chars));
        return
    else
        % recursive calls
        if dirMat(i,j) == 1
           % if direction = 'NW = 1', head diagonal
           % add character to the NW to the longest substring.
           chars = strcat(chars, string(i-1));
           printLCS(dirMat, string, i-1, j-1, chars);
        elseif dirMat(i,j) == 3
           % if direction = 'W = 3', head left
           printLCS(dirMat, string, i, j-1, chars);
        else
           % if direction = 'N = 2', head up
           printLCS(dirMat, string, i-1, j, chars);        
        end
    end
end
