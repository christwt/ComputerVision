%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: warpImage
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [warpedImg] = warpImage(image, H, min_row, max_row, min_col, max_col, T)
    % this function takes a recovered homography matrix and an image and
    % the corners of the bounding box and warps the image into the box.
    % Similar to warpImg3 but already has calculations complete for
    % bounding box and has Transform matrix T for proper image placement.  
    
    % calculate height and width of output image. 
    width = max_row+min_row;
    fprintf('width mosaic: %d\n', width);
    height = max_col-min_col;
    fprintf('height mosaic: %d\n', height);
    
    % calculate our offset. 
    %row_offset = 1-min_row;
    %fprintf('row offset: %d\n', row_offset);
    %col_offset = width-size(image,2);
    %fprintf('col offset: %d\n', col_offset);
    
    [xi, yi] = meshgrid(min_row:max_row-1, min_col:max_col-1);
    
    % take inverse of Homography matrix for inverse mapping.
    % multiply by translation matrix
    h = inv(H) * T; 
    
    % simple application of H * (x,y) while changing (x,y) coords to
    % homogenous and converting back to (x,y) after translation.
    xx = (h(1,1)*xi+h(1,2)*yi+h(1,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
    yy = (h(2,1)*xi+h(2,2)*yi+h(2,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
    
    % solve for warpedImage pixels using interp2. Do each color channel
    % separately for RGB images. 
    warpedImg(:,:,1) = (interp2(image(:,:,1),xx,yy, 'bilinear',0));
    warpedImg(:,:,2) = (interp2(image(:,:,2),xx,yy, 'bilinear',0));
    warpedImg(:,:,3) = (interp2(image(:,:,3),xx,yy, 'bilinear',0));
    

    
    
end
