% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: formatFact.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [reportPicture] = formatFace(detectedFace, bboxPoints)
% This function takes as input the video frame containing the located face
% and the list of 4 corner points of the bounding box of the detected face
% and returns an image of the detected face for the report generation.

    % Extract face from video based on bounding box corner points. Extend
    % marginally to get entirety of face.
    reportPicture = detectedFace(bboxPoints(1,2)-30:bboxPoints(4,2)+30,bboxPoints(1,1):bboxPoints(3,1),:);
    [height, width, ~] = size(reportPicture);
    ratio = 200/height;
    
    % Filter extracted image prior to resizing.
    % sharpen edges prior to resizing.
    reportPicture = imsharpen(reportPicture);
    
    % Resize image based on user input to mandatory height of 200px. 
    reportPicture = imresize(reportPicture, [height*ratio, width*ratio]);
    %fprintf('height: %d, width: %d\n',size(reportPicture,1),size(reportPicture,2));
    figure; imshow(reportPicture);
end