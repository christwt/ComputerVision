%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: computeHomography
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H = computeHomography(src, dest)
% This function will take pairs of corresponding points in a source and
% destination image and compute the Homography that transforms source
% coords to dest coords. 

% determine size of corresponding points.
n = size(src, 1);
% allocate coefficient matrix
A = zeros(2*n, 9);

% fill matrix in the form described by:
% http://www.cse.psu.edu/~rtc12/CSE486/lecture16.pdf
% create 2x9 matrix, fills with values, use SVD to solve.
for i = 1:n
   x_src = src(i, 1);
   y_src = src(i, 2);
   x_dest = dest(i,1);
   y_dest = dest(i,2);
   A(2*i-1:2*i, :) =  [x_src y_src 1  0  0  0 -x_src*x_dest -y_src*x_dest -x_dest
                       0  0  0  x_src y_src 1 -x_src*y_dest -y_src*y_dest -y_dest];
end

% obtain eigenvector with the smallest value.
% could use SVD, but instead can use eig() which gives all eigenvectors.
[H_vec, ~] = eig(A' * A);
H_vec = H_vec(:,1);

% use reshape to obtain 3x3 homography matrix.
H = reshape(H_vec, 3, 3)';

end