%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: homographyTransformR
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function check = homographyTransformR(coords2,H)
    % This function used to check whether homography matrix correctly
    % reverse transforms corresponding points. 
    % code adapted from homographyTransform.m
    
    coords2 = coords2';
    
    % backwards mapping function 
    % compute H' * [x,y,z]'
    % need to convert cartensian coords to homogenous.
    q = H \ [coords2; ones(1, size(coords2,2))];
    p = q(3,:);
    
    % normalize coords by dividing by z (homogenous coord). 
    check = [q(1,:)./p; q(2,:)./p];
end