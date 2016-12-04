% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: testFacialRecog.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [count] = testFacialRecog(string)
% This function tests the facial recognition portion of the applications,
% by running a modified version of findFace.m on 4 directories of images
% from http://cswww.essex.ac.uk/mv/allfaces/index.html designed and
% maintained by Dr. Libor Spacek.

% Option string to pass to program: 
%   1. 'test': run testFacialRecog on entered directory (line 22 to change) with statistics
%      on identified faces in directory.
%   2. 'images': run testFacialRecog on entered directory (line 67 to
%      change) mosaicing images together of selected faces. Runs every 5th
%      image in directory (line 78 to change)
%   3. 'vid': run testFacialRecog on entered video file (line 102 to change)
%      and extracts identified faces from video frame.
%   4. 'im': run testFacialRecog on entered image file (line 115 to change)
%      and extracts identified faces from image file.

    % just run for test results
    if strcmp(string, 'test')
        % change directory path for images to test, must be jpg format.
        cd testImages/faces94/faces94/male/9326871;
        imagefiles = dir('*.jpg');
        % test all images in directory.
        len = length(imagefiles);
        count = 0;
        for i = 1:len  
            currentfilename = imagefiles(i).name;
            % Run Algorithm from findFace.
            frame = imread(currentfilename);
            faceDetector = vision.CascadeObjectDetector();
            bboxes = step(faceDetector, frame);
            [rows, ~] = size(bboxes);
            for j = 1:rows
               title = strcat('Face ',num2str(j)); 
               frame = insertObjectAnnotation(frame, 'Rectangle', bboxes(j,:), title);  
            end
    %        figure; imshow(frame);    
            % if failure, no bounding box around any faces.
            if size(bboxes,1) == 0
                count = count + 1;
            end
            % Visual confirmation of correctly identified face. Uncomment below
            % for this method
    %         choice = menu('Correct?','Yes','No');
    %         if choice == 1
    %            count = count + 1;
    %         end
            close;
        end
        % Uncomment below to user visual print statement.
        %fprintf('Num Images: %d, Successes: %d Percent\n',len, count/20*100);
        fprintf('Num Images: %d, Successes: %d Percent\n', len, 100-(count/20*100));
        cd ../../../..
    % generate images for report
    elseif strcmp(string,'images')
        % allocate output image
        outputImage = zeros(90,400,3);
        % change directory path for images to test, must be jpg format.
        cd testImages/;
        imagefiles = dir('*.jpg');
        % test all images in directory.
        len = length(imagefiles);
        count = 0;
        xmin = 1;
        xmax = 90;
        ymin = 1;
        ymax = 100;
        for i = 1:5:len  
            currentfilename = imagefiles(i).name;
            % Run Algorithm from findFace.
            frame = imread(currentfilename);
            frame = im2double(frame);
            faceDetector = vision.CascadeObjectDetector();
            bboxes = step(faceDetector, frame);
            [rows, ~] = size(bboxes);
            for j = 1:rows
               title = strcat('Face ',num2str(j)); 
               frame = insertObjectAnnotation(frame, 'Rectangle', bboxes(j,:), title);  
            end
            frame = imresize(frame, [90,100]);
            outputImage(xmin:xmax,ymin:ymax,:) = frame;
            ymin = ymin+100;
            ymax = ymax+100;
        end
        imshow(outputImage);
        imwrite(outputImage, 'ReportImage.jpg');
        cd ../../../..
    % video extraction example for report
    elseif strcmp(string,'vid');
        faceDetector = vision.CascadeObjectDetector();        
        videoFileReader = vision.VideoFileReader('tilted_face.avi');
        frame = step(videoFileReader);
        bboxes = step(faceDetector, frame);
        [rows, ~] = size(bboxes);
        for i = 1:rows
           title = strcat('Face ',num2str(i)); 
           frame = insertObjectAnnotation(frame, 'Rectangle', bboxes(i,:), title);  
        end
        imwrite(frame, 'videoExample.jpg');
    % generate and display image.
    elseif strcmp(string,'im');
        faceDetector = vision.CascadeObjectDetector();
        frame = imread('maskedIntruder.jpeg');
        bboxes = step(faceDetector, frame);
        [rows, ~] = size(bboxes);
        for i = 1:rows
           title = strcat('Face ',num2str(i)); 
           frame = insertObjectAnnotation(frame, 'Rectangle', bboxes(i,:), title);  
        end
        imwrite(frame, 'multipleFace.jpg');
    % error handling and usage statement.
    else
        msg = ['Usage: testFacialRecog("test")\n',...
               '       testFacialRecog("images")\n',...
               '       testFacialRecog("vid")\n',...
               '       testFacialRecog("im")\n'];
        error(sprintf(msg));
    end
end

