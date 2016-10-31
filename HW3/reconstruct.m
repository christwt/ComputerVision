%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 3: Reconstruct.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [points3D] = reconstruct(disparityMap, stereoParams)
    % this function takes as inputs a disparity Map and a set of stereo
    % parameters and returns the 3D world coordinates of points
    % corresponding to each pixel from the disparity map. 
    
    % Utilizes formula 11.1 from Szeliski textbook:
    % d = F(B/Z), Z = (F*B)/d, Units: (mm*pixels)/pixels = mm
    % d = disparities(pixels), B = baseline(pixels), F = focal length(mm), Z = depth(mm).

    % obtain size of disparity map to create depth matrix. 
    [rows, cols] = size(disparityMap);
    
    % obtain focal length of the left camera 
    focalLen = stereoParams.CameraParameters1.FocalLength;
    
    % convert from pixels to mm. Fx = fx*sx. Fy = fy*sy, fx = Fx/sx, fy =
    % Fy/ sy, let sx = 0.25mm, let sy = 0.25mm
    fx1 = focalLen(1)/0.25;
    fy1 = focalLen(2)/0.25;
 
    % obtain focal lengths of L camera (camera1) via averaging. These values
    % should be very close if the pixels are square. 
    F = (fx1 + fy1)/2;
   
    % obtain principle points of cameras in order to calculate baseline. 
    c1 = stereoParams.CameraParameters1.PrincipalPoint;
    c2 = stereoParams.CameraParameters2.PrincipalPoint;
    % use distance formula to find baseline in pixels. based on distance
    % between principle points of camera. 
    B = sqrt((c2(1)-c1(1)).^2 + (c2(2)-c1(2)).^2);
        
    % create output matrix. 
    points3D = zeros(rows, cols);
    
    % loop through disparity map, calculate depth with formula and place in
    % matrix. 
    for row = 1:rows
        for col=1:cols
            % obtain disparity. 
            d = disparityMap(row,col);
            
            % calculate depth.
            Z = (F*B)/d;
            
            % place in 3D points matrix.
            points3D(row, col) = Z;
        end
    end
end