%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: mosaicImg
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mosaic] = mosaicImg(reference, image2, H)
% this function will stitch together a reference image with another image that has
% already been warped into its plane via homography transform. See
% warpImg()  

    % build boundary box.
    % compute corners of reference
    r_min_row = 1;
    r_min_col = 1;
    r_max_row = size(reference,1);
    r_max_col = size(reference,2);
    
    % compute transformed corners of image2.
    [row,col,~] = size(image2);
    
    % compute the out boundaries of the transformed corners. 
    corners = H\[[1;1;1], [1;row;1], [col;row;1] [col;1;1]];
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
    i_min_row = bound_box(1);
    i_max_row = bound_box(2);
    i_min_col = bound_box(3);
    i_max_col = bound_box(4);
    
    min_row = floor(min(i_min_row, r_min_row));
    max_row = floor(max(i_max_row, r_max_row));
    min_col = ceil(min(i_min_col, r_min_col));
    max_col = ceil(max(i_max_col, r_max_col));
     
    %fprintf('xmax %d\n', min_row);
    %printf('xmin %d\n', max_row);
    %fprintf('ymax %d\n', min_col);
    %fprintf('ymin %d\n', max_col);
    
    % determine height and width of output image. 
    width = max_row-min_row;
    height = max_col-min_col;
    fprintf('height mosaic: %d width mosaic: %d\n', height, width);
    
    % paste reference image into boundary box based on calculated offsets.
    [~,c,~] = size(reference);
    
    % calculate offsets to place reference
    r_offset = 1 - min_col;
    c_offset = width-c;
    fprintf('row_offset: %d\n', r_offset);
    fprintf('col_offset: %d\n', c_offset);
    
    % create transform matrix for image placement in output matrix.
    T = [1 0 -c_offset;0 1 min_col;0 0 1];
    
    % warp reference image into panorama using identity homography.
    mosaic1 = warpImage(reference, eye(1), min_row, max_row, min_col, max_col, T);
    
    % interpolate remaining pixels from warped image2 into different
    % panorma image frame.
    mosaic2 = warpImage(image2, H, min_row, max_row, min_col, max_col, T);
    
    %[u,v,~] = size(mosaic2);
    %fprintf(' mosaic2 height: %d, width: %d', u,v);
    
    % for more complete blending of edges use max function to smooth
    % overlap areas.
    % idea to use max function from: 
    %http://home.deib.polimi.it/boracchi/teaching/IAS/Stitching/stitch.html
    mosaic = max(mosaic1, mosaic2);

end