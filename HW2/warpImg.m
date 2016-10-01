%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: warpImg
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [warpedImg] = warpImg(image, H)
    % this algorithm will warp an image into the plane of another image
    % using a recovered Homography matrix H. 
    
    [m,n,~] = size(image);
    
    % algorithm based on slides: http://www.cse.psu.edu/~rtc12/CSE486/lecture14_6pp.pdf
    % special attention paid to tutorials with meshgrid and interp2.
    
    % meshgrid of coordinates to transform. 
    [xi, yi] = meshgrid(1:n, 1:m);
    
    % take inverse of Homography matrix for inverse mapping. 
    h = inv(H); 
    % simple application of H * (x,y) while changing (x,y) coords to
    % homogenous and converting back to (x,y) after translation.
    xx = (h(1,1)*xi+h(1,2)*yi+h(1,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
    yy = (h(2,1)*xi+h(2,2)*yi+h(2,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
    
    % solve for warpedImage pixels using interp2. Do each color channel
    % separately for RGB images. 
    warpedImg(:,:,1) = (interp2(image(:,:,1),xx,yy, 'bilinear',0));
    warpedImg(:,:,2) = (interp2(image(:,:,2),xx,yy, 'bilinear',0));
    warpedImg(:,:,3) = (interp2(image(:,:,3),xx,yy, 'bilinear',0));
    
    
    