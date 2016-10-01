%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: vision_hwk2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [warpedImg] = warpImg3(image, H)
    % this algorithm will warp an image into the plane of another image
    % using a recovered Homography matrix H. 
    % process adapted from http://www.di.ens.fr/willow/teaching/recvis10/assignment2/vgg_warp_H.m 
    % obtain size of image to warp.
    [m,n,~] = size(image);
    
    % compute the out boundaries of the transformed corners. 
    % Currently transforms image to fit within warped coord system. This is
    % not right. 
    corners = H*[[1;1;1], [1;m;1], [n;m;1] [n;1;1]];
    
    % transform our homogenous coords back to (x,y).
    corners(1,:) = corners(1,:)./corners(3,:);
    corners(2,:) = corners(2,:)./corners(3,:);
    
    % calculate max and min of x and y values after transformation. Round
    % to pixel values. 
    bound_box = [
      ceil(min(corners(1,:)));
      ceil(max(corners(1,:)));
      ceil(min(corners(2,:)));
      ceil(max(corners(2,:)));
      ];
  
    % obtain coordinates by which we can meshgrid out output coordinate
    % system.
    x_min = bound_box(1);
    x_max = bound_box(2);
    y_min = bound_box(3);
    y_max = bound_box(4);
    
    %fprintf('xmax %d\n', x_max);
    %fprintf('xmin %d\n', x_min);
    %fprintf('ymax %d\n', y_max);
    %fprintf('ymin %d\n', y_min);
    % algorithm based on slides: http://www.cse.psu.edu/~rtc12/CSE486/lecture14_6pp.pdf
    % special attention paid to tutorials with meshgrid and interp2.
    
    % meshgrid of coordinates to transform, based on bounding box. 
    [xi, yi] = meshgrid(x_min:x_max, y_min:y_max);
    
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