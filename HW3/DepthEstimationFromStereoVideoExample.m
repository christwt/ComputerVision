%% Depth Estimation From Stereo Video
% This example shows how to detect people in video taken with a calibrated
% stereo camera and determine their distances from the camera.
%
%   Copyright 2013-2014 The MathWorks, Inc.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 3: Altered Depth Estimation From Stereo Video Script
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the Parameters of the Stereo Camera
% Load the |stereoParameters| object, which is the result of calibrating
% the camera using either the |stereoCameraCalibrator| app or the
% |estimateCameraParameters| function.

% Load the stereoParameters object.
load('handshakeStereoParams.mat');

% Visualize camera extrinsics.
showExtrinsics(stereoParams);

%% Create Video File Readers and the Video Player
% Create System Objects for reading and displaying the video
videoFileLeft = 'handshake_left.avi';
videoFileRight = 'handshake_right.avi';

readerLeft = vision.VideoFileReader(videoFileLeft, 'VideoOutputDataType', 'uint8');
readerRight = vision.VideoFileReader(videoFileRight, 'VideoOutputDataType', 'uint8');
player = vision.DeployableVideoPlayer('Location', [20, 400]);

%% Read and Rectify Video Frames
% The frames from the left and the right cameras must be rectified in order
% to compute disparity and reconstruct the 3-D scene. Rectified images 
% have horizontal epipolar lines, and are row-aligned. This simplifies 
% the computation of disparity by reducing the search space for matching
% points to one dimension.  Rectified images can also be combined into an
% anaglyph, which can be viewed using the stereo red-cyan glasses to see
% the 3-D effect.
frameLeft = readerLeft.step();
frameRight = readerRight.step();

[frameLeftRect, frameRightRect] = ...
    rectifyStereoImages(frameLeft, frameRight, stereoParams);

figure;
imshow(stereoAnaglyph(frameLeftRect, frameRightRect));
title('Rectified Video Frames');

%% Compute Disparity
% In rectified stereo images any pair of corresponding points are located 
% on the same pixel row. For each pixel in the left image compute the
% distance to the corresponding pixel in the right image. This distance is
% called the disparity, and it is proportional to the distance of the
% corresponding world point from the camera.
frameLeftGray  = rgb2gray(frameLeftRect);
frameRightGray = rgb2gray(frameRightRect);
    
disparityMap = disparity(frameLeftGray, frameRightGray);
% Task 1: call calculate disparity w/ SSD function 3 times with window sizes 1, 3, 5.
disparityMap1 = calcDisparity(frameLeftGray, frameRightGray, 0, 64, 1);
% disparityMap2 = calcDisparity(frameLeftGray, frameRightGray, 0, 64, 3);
% disparityMap3 = calcDisparity(frameLeftGray, frameRightGray, 0, 64, 5);
% % create 2x2 subplot with corresponding disparity maps. 
figure;
 subplot(2,2,1)
 imshow(disparityMap, [0, 64]); % disparity range is from 0-64.
 title('Built In Disparity Map');
 colormap jet
 colorbar
 subplot(2,2,2)
 imshow(disparityMap1, [0,64]);
 title('SSD Disparity Map win = 1');
 colormap jet
 colorbar
%  subplot(2,2,3)
%  imshow(disparityMap2, [0,64]);
%  title('Disparity Map win = 3');
%  colormap jet
%  colorbar
%  subplot(2,2,4)
%  imshow(disparityMap3, [0,64]);
%  title('Disparity Map win = 5');
%  colormap jet
%  colorbar
% 
% % Task 2: call calculate disparity with NCC function 3 times with window sizes 3, 5, 7.
%  disparityMap4 = calcNCC3(frameLeftGray, frameRightGray, 0, 64, 3);
%  disparityMap5 = calcNCC3(frameLeftGray, frameRightGray, 0, 64, 5);
%  disparityMap6 = calcNCC3(frameLeftGray, frameRightGray, 0, 64, 7);
% % create 2x2 subplot and plot corresponding disparity maps from NCC
% % function.
%  figure;
%  subplot(2,2,1)
%  imshow(disparityMap, [0, 64]); % disparity range is from 0-64.
%  title('Built In Disparity Map');
%  colormap jet
%  colorbar
%  subplot(2,2,2)
%  imshow(disparityMap4, [0,64]);
%  title('NCC Disparity Map win = 3');
%  colormap jet
%  colorbar
%  subplot(2,2,3)
%  imshow(disparityMap5, [0,64]);
%  title('NCC Disparity Map win = 5');
%  colormap jet
%  colorbar
%  subplot(2,2,4)
%  imshow(disparityMap6, [0,64]);
%  title('NCC Disparity Map win = 7');
%  colormap jet
%  colorbar
%  
%  % Task 3: call L-R consistency check function twice with LR/RL disparity
%  % maps using SSD and NCC with window size 3. Plot resulting binary images
%  % sided by side. 
%  % create RL disparity maps
%  % utilize fliplr function to switch images in order to use same disparity
%  % calculation algorithm. 
%  RdisparityMapSSD = calcDisparity(fliplr(frameRightGray), fliplr(frameLeftGray), 0, 64, 3);
%  RdisparityMapNCC = calcNCC3(fliplr(frameRightGray), fliplr(frameLeftGray), 0, 64, 3);
%  % create outlier maps. be sure to flip RL disparity map to allow disparities to line up. 
%  outlierMap1 = consistencyCheck(disparityMap2, fliplr(RdisparityMapSSD), 1);
%  outlierMap2 = consistencyCheck(disparityMap4, fliplr(RdisparityMapNCC), 1);
%  % plot outlier maps for each method.
%  figure;
%  subplot(2,1,1)
%  imshow(outlierMap1);
%  title('SSD Outlier Map: win = 3 TLR = 1');
%  subplot(2,1,2)
%  imshow(outlierMap2);
%  title('NCC Outlier Map: win = 3, TLR = 1');

%% Reconstruct the 3-D Scene
% Reconstruct the 3-D world coordinates of points corresponding to each
% pixel from the disparity map.

% Task4: create reconstruct scene function to return matrix of depth vales
% for every pixel in the left image.

% points3D1 = my implementation, returns matrix of "Z" depth values for
% every pixel in L image.
%points3D1 = reconstruct(disparityMap3, stereoParams);
points3D = reconstructScene(disparityMap, stereoParams);

% Convert to meters and create a pointCloud object
points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', frameLeftRect);

% Create a streaming point cloud viewer
player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');

% Visualize the point cloud
view(player3D, ptCloud);


%% Detect People in the Left Image
% Use the |vision.PeopleDetector| system object to detect people.

% Create the people detector object. Limit the minimum object size for
% speed.
peopleDetector = vision.PeopleDetector('MinSize', [166 83]);

% Detect people.
bboxes = peopleDetector.step(frameLeftGray);

%% Determine The Distance of Each Person to the Camera
% Find the 3-D world coordinates of the centroid of each detected person
% and compute the distance from the centroid to the camera in meters.

% Find the centroids of detected people.
centroids = [round(bboxes(:, 1) + bboxes(:, 3) / 2), ...
    round(bboxes(:, 2) + bboxes(:, 4) / 2)];

% Find the 3-D world coordinates of the centroids.
centroidsIdx = sub2ind(size(disparityMap), centroids(:, 2), centroids(:, 1));
X = points3D(:, :, 1);
Y = points3D(:, :, 2);
Z = points3D(:, :, 3);
centroids3D = [X(centroidsIdx)'; Y(centroidsIdx)'; Z(centroidsIdx)'];

% Find the distances from the camera in meters.
dists = sqrt(sum(centroids3D .^ 2));
    
% Display the detected people and their distances.
labels = cell(1, numel(dists));
for i = 1:numel(dists)
    labels{i} = sprintf('%0.2f meters', dists(i));
end
figure;
imshow(insertObjectAnnotation(frameLeftRect, 'rectangle', bboxes, labels));
title('Detected People');

%% Process the Rest of the Video
% Apply the steps described above to detect people and measure their
% distances to the camera in every frame of the video.

while ~isDone(readerLeft) && ~isDone(readerRight)
    % Read the frames.
    frameLeft = readerLeft.step();
    frameRight = readerRight.step();
    
    % Rectify the frames.
    [frameLeftRect, frameRightRect] = ...
        rectifyStereoImages(frameLeft, frameRight, stereoParams);
    
    % Convert to grayscale.
    frameLeftGray  = rgb2gray(frameLeftRect);
    frameRightGray = rgb2gray(frameRightRect);
    
    % Compute disparity. 
    disparityMap = disparity(frameLeftGray, frameRightGray);
    
    % Reconstruct 3-D scene.
    points3D = reconstructScene(disparityMap, stereoParams);
    points3D = points3D ./ 1000;
    ptCloud = pointCloud(points3D, 'Color', frameLeftRect);
    view(player3D, ptCloud);
    
    % Detect people.
    bboxes = peopleDetector.step(frameLeftGray);
    
    if ~isempty(bboxes)
        % Find the centroids of detected people.
        centroids = [round(bboxes(:, 1) + bboxes(:, 3) / 2), ...
            round(bboxes(:, 2) + bboxes(:, 4) / 2)];
        
        % Find the 3-D world coordinates of the centroids.
        centroidsIdx = sub2ind(size(disparityMap), centroids(:, 2), centroids(:, 1));
        X = points3D(:, :, 1);
        Y = points3D(:, :, 2);
        Z = points3D(:, :, 3);
        centroids3D = [X(centroidsIdx), Y(centroidsIdx), Z(centroidsIdx)];
        
        % Find the distances from the camera in meters.
        dists = sqrt(sum(centroids3D .^ 2, 2));
        
        % Display the detect people and their distances.
        labels = cell(1, numel(dists));
        for i = 1:numel(dists)
            labels{i} = sprintf('%0.2f meters', dists(i));
        end
        dispFrame = insertObjectAnnotation(frameLeftRect, 'rectangle', bboxes,...
            labels);
    else
        dispFrame = frameLeftRect;
    end
    
    % Display the frame.
    step(player, dispFrame);
end

% Clean up.
reset(readerLeft);
reset(readerRight);
release(player);

%% Summary
% This example showed how to localize pedestrians in 3-D using a calibrated
% stereo camera.

%% References
% [1] G. Bradski and A. Kaehler, "Learning OpenCV : Computer Vision with
% the OpenCV Library," O'Reilly, Sebastopol, CA, 2008.
%
% [2] Dalal, N. and Triggs, B., Histograms of Oriented Gradients for
% Human Detection. CVPR 2005.

displayEndOfDemoMessage(mfilename)

