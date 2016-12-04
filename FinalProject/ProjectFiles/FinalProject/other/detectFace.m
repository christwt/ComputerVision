% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: detectFace.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [report] = detectFace(filePath)
% This function takes as inputs a given filePath for a video file then uses
% functions from the Computer Vision Tool Box to: 
% 1. Detect a Face in a Video Frame (Jones Viola).
% 2. Identify Facial Features to Track (KLT).
% 3. Track Facial Features.
% Code adapted from: FaceTrackingUsingKLTExample.m provided by MATLAB 
% Computer Vision Tool Box

    disp('Running Face Detection Using Viola Jones Algorithm');
    % create cascade detector object.
    faceDetector = vision.CascadeObjectDetector();
    % read video
    videoFileReader = vision.VideoFileReader(filePath);
    videoFrame = step(videoFileReader);
    bbox = step(faceDetector, videoFrame);
    
    % draw and display returned bounding box around a detected face.
    videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
    figure; imshow(videoFrame); title('Detected Face in Video');
    
    % get image of detected face for report.
    detectedFace = videoFrame;
    
    % convert bbox into list of 4 points for rotation of face object, for facial tracking.
    bboxPoints = bbox2points(bbox(1, :));
    
    % Detect feature points in the face region.
    points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);

    % Display the detected points.
    figure, imshow(videoFrame), hold on, title('Detected features');
    plot(points);
    
    % start report generation.
    % face with bounding box passed with video frame for recognzed face 
    % and the bounding box.
    report = generateReport(detectedFace, bbox);
    
    % Options to perform further operations. Track Face, Track Figure,
    % Search for textual clues.
    choice = menu('Options', 'Exit', 'Track Face', 'Track Figure', 'Search For Text');
    while choice ~=1
            % track face
            if choice == 2
                
            % track figure   
            elseif choice == 3
                
            % perform text search    
            elseif choice == 4
                
            end     
    end
    
    
    
    
    
end