%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: findLCS.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [LCS, DIR] = findLCS(string1, string2)
% This function takes as inputs 2 sequences then finds/prints the longest
% common sub-sequences between the two. The output is the table of length
% values for the two sequences and the direction table. 
% This function implements the algorithm described in the lecture slides. 
% Dynamic programming solution to Longest Common Substring Problem
% subsequence does not have to be continuous but it does have to be in
% order.
 
% determine lengths of sequences.
len1 = numel(string1);
len2 = numel(string2);

% create LCStable with rows initialized to zero. 1st row and 1st col
% will remain zero.
rows = len1 + 1;
cols = len2 + 1;
lenMat = zeros(rows, cols);
% create similar direction table to store directions to obtain longest
% subsequence. 1st row and 1st col = 0
dirMat = zeros(rows, cols);

% loop through lengthTable, calculate longest sub-sequence. Adjust indexing to
% account for matlab indexing starting at 1.
for i = 2:rows;
    for j = 2:cols;
        % compare sequence indices
        if (string1(i-1) == string2(j-1))
            NW = lenMat(i-1, j-1);
            lenMat(i,j) = NW + 1;
            % update direction travelled with 'NW = 1'
            dirMat(i,j) = 1;
        elseif lenMat(i-1,j) >= lenMat(i,j-1);
            N = lenMat(i-1, j);
            lenMat(i, j) = N;
            % update direction travelled with 'N = 2'
            dirMat(i,j) = 2;
        else
            W = lenMat(i, j-1);
            lenMat(i, j) = W;
            % update direction travelled with 'W = 3'
            dirMat(i,j) = 3;
        end
    end
end

% length of longest sub-sequence is the bottom right index of table. 
LCScount = lenMat(rows, cols);

% print the length of the longest sub-sequence.
fprintf('\nPrint Longest Subsequence:\n\n');
fprintf('\tLength of the LCS between strings "%s" and "%s" is: %d\n', string1, string2, LCScount);

% outputs
LCS = lenMat;
DIR = dirMat;

% initialize empty chars to print longest sub-sequence.
chars = '';
% call print LCS function to display longest sub-sequence.
printLCS(dirMat, string1, rows, cols, chars);

end