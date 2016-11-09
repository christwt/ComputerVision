%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 4: stereo.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script will take two set of images, cones and teddy and will create
% disparity maps of the two using dynamic programming. 

% read in images. 
teddyL = imread('teddy2.png');
teddyR = imread('teddy6.png');
conesL = imread('cones2.png');
conesR = imread('cones6.png');

% read in the ground truth disparity maps for L/R disparity. 
teddyGround = imread('teddygrounddisp2.png');
conesGround = imread('conesgdisp2.png');

% convert all images to grayscale. 
teddyLGray = rgb2gray(teddyL);
teddyRGray = rgb2gray(teddyR);
conesLGray = rgb2gray(conesL);
conesRGray = rgb2gray(conesR);

% compute the 2 disparity maps using calculate disparity. 
% note that all images have been previously rectified. 
teddyDispMap = calculateDisparity(teddyLGray, teddyRGray);
conesDispMap = calculateDisparity(conesLGray, conesRGray);

% create 2 subplots to display DP disparity maps alongside their ground
% truths.
% display teddy images. 
figure;
subplot(1,2,1)
imshow(teddyGround);
title('Teddy Ground Truth');
subplot(1,2,2)
cDMap = displayDMap(teddyDispMap);
title('Teddy DP Disparity Map');
% display cones images. 
figure;
subplot(1,2,1)
imshow(conesGround);
title('Cones Ground Truth');
subplot(1,2,2)
tDMap = displayDMap(conesDispMap);
title('Cones DP Disparity Map');

