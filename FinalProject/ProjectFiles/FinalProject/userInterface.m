% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: UserInterface.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This simple script creates a menu driven application perform facial
% detection on an image or video frame and generate a report based on a
% selected, recognized face. 

clear all;close all;clc;

% Usage Statement %
usage();
                
% Starting Menu %
choice = menu('Starting Menu', 'Exit Program', 'Select Dept Info', 'Upload Video', ... 
              'Upload Image', 'Detect Face');
          
while choice ~= 1
    switch choice
        % Error Handling %
        case 0
            disp('Error: You did not select one of the options please choose again.');
            choice = menu('Welcome to Facial Recognition and Tracking', 'Exit Program', ...
                          'Select Dept Info', 'Upload Video', 'Upload Image', 'Detect Face');
                      
        % Select Department Information %
        case 2
            % Cell array to store fake department info for report formatting. Can be
            % replaced with whatever data structure deemed necessary. 
            deptInfo = {{'Fake Dept1', 'Fake address', '555-NUM-FAKE', 'fake1_fake.com'}, ...
                       {'Fake Dept2', 'Fake address', '555-NUM-FAKE', 'fake2_fake.com'}};
            selection = menu('Dept Information Selection', 'Fake Dept1', 'Fake Dept2');
            if strcmp(selection, 'Fake Dept1')
                dept = deptInfo{1};
            elseif strcmp(selection, 'Fake Dept2')
                dept = deptInfo{2};
            else 
                % default.
                dept = deptInfo{1};
            end
        % Upload Video File % 
        case 3
            prompt = {'Enter the name of the video'};
            dlg_title = 'Video Selection';
            num_lines = 1;
            defaultans = {'tilted_face.avi'};
            filePath = inputdlg(prompt, dlg_title, num_lines, defaultans);
            filePath = char(filePath);
            identifier = 'v';

        % Upload Image File %
        case 4
            prompt = {'Enter the name of the image file'};
            dlg_title = 'Image Selection';
            num_lines = 1;
            defaultans = {'visionteam.jpg'};
            filePath = inputdlg(prompt, dlg_title, num_lines, defaultans);
            filePath = char(filePath);
            identifier = 'i';   

        % Face Detection and Report Generation %
        case 5
            report = findFace(filePath, identifier, dept); 
    end

    % Continuation Menu %
    choice = menu('Welcome to Facial Recognition and Tracking', 'Exit Program', ...
                  'Select Dept Info', 'Upload Video File', 'Upload Image', 'Detect Face');    
end