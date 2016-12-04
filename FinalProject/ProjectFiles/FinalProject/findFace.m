% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: findFace.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [report] = findFace(filePath, identifier, dept)
% This function takes as inputs a given filePath for a image/video file then uses
% functions from the Computer Vision Tool Box to: 
% 1. Detect Faces in a Video or Image Frame (Viola Jones Algorithm).
% 2. Allow User to Select The Face of Interest.
% 3. Generate Framed 'Mugshot' for report purposes. 
% Utilizes functions from the Computer Vision Toolbox:
% -Facial Recognition portion of algorithm adapted from: FaceTrackingUsingKLTExample.m provided by MATLAB 
%       -https://www.mathworks.com/help/vision/examples/face-detection-and-tracking-using-the-klt-algorithm.html    
% For additional information view MATLAB documentation:
%       - vision.CascadeObjectDetector System object
%       https://www.mathworks.com/help/vision/ref/vision.cascadeobjectdetector-class.html


    % usage statement for user.
    usage2();
    
    % Cascade Detector Object: From Computer Vision Toolbox %
    faceDetector = vision.CascadeObjectDetector();
    % Read File as Video %
    if strcmp(identifier, 'v')
        % Create video file reader object
        videoFileReader = vision.VideoFileReader(filePath);
        % Step to first frame of video file reader. 
        frame = step(videoFileReader);
    % Read File as Image %
    elseif strcmp(identifier, 'i')
        frame = imread(filePath);
        % Resize image in to attempt to obtain better resolution for
        % reportPicture.
        frame = imresize(frame, 2);
    else 
        % Usupported argument error checking.
        msg = 'Error: unsupported file type';
        error(msg);
    end
    
    % From Matlab Vision Toolbox: returns a matrix of bounding box
    % coordinates around any and all detected faces in the image frame.
    bboxes = step(faceDetector, frame);
    
    % Unannotated Frame for Report Extraction
    detectedFace = frame;
    
    % Annotate Image With Indexed Bounding Boxes for Selection by User
    [rows, ~] = size(bboxes);
    for i = 1:rows
       title = strcat('Face ',num2str(i)); 
       frame = insertObjectAnnotation(frame, 'Rectangle', bboxes(i,:), title);  
    end
    
    % Display Annotated Frame for User Selection of Face
    figure; imshow(frame);
    prompt = {sprintf('Select Identified Face by Entering a Number\nIf no faces have been detected enter 0.')};
    dlg_title = 'Facial Identification';
    numlines = 1;
    defaultans = {'1'};
    answer = inputdlg(prompt, dlg_title, numlines, defaultans);
    answer = str2num(answer{1});
    
    % If no face detected and user inputs '0'
    if answer == 0
        close;
        % Choice to continue report without image or Exit.
        choice = menu('Failure in face detection','Exit','Generate Report without Extracted Face');
        % Return empty report to user interface if exit.
        report = 0;
        while choice ~=1
            switch choice
                case 0
                    disp('Error: you did not select an option');
                    choice = menu('Failure in face detection','Exit','Generate Report without Extracted Face');
                case 2
                    % Continue with original image as picture for report
                    reportPicture = detectedFace;
                    report = generateReport(reportPicture);
            end
        end
  
    % User has selected face for report generation
    else
        close;
        % Error checking for out of index selection
        while answer < 1 || answer > rows
            prompt = {'Error: Please Select a Face by Entering its Number'};
            dlg_title = 'Facial Identification';
            numlines = 1;
            answer = inputdlg(prompt, dlg_title, numlines, defaultans);
            answer = str2num(answer{1});
        end
    
        % Convert selected bbox into 4 corner points for face extraction
        bboxPoints = bbox2points(bboxes(answer, :));

        % Extract face from video frame for report generation
        reportPicture = formatFace(detectedFace, bboxPoints);

        % Start Report Generation
        report = generateReport(reportPicture, dept);
        close;
    end
    
%     % Unimplemented as yet: Facial Tracking Support for Video Files.
%     % Provide tracking support for video files 
%     if strcmp(identifier, 'v')
%         % Detect feature points in the selected face region for tracking
%         points = detectMinEigenFeatures(rgb2gray(frame), 'ROI', bboxes(answer, :));
% 
%         % Display the detected points
%         figure, imshow(frame), hold on,
%         plot(points);
%     end
    %close;

end