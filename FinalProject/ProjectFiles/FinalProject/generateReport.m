% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: generateReport.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [report] = generateReport(reportPicture, dept)
% This function takes as inputs the video frame with a detected face and
% the department info and collects report information from user prior to
% generating the PDF suspect report.
  
    % usage statment for user.
    usage3();
    
    % initialize empty report.
    report = 0;

    % Menu to add content to report. 
    choice = menu('Suspect Report Generation', 'Exit', 'Add Content');
        while choice ~= 1
            switch choice
                case 0
                    disp('Error: Please select a menu option.');
                    choice = menu('Suspect Report Generation', 'Exit', 'Add Content');
                case 2
                    % prompt to add content to report. Collect user input.
                    prompt = {'Suspect Name', 'Suspect ID', 'Date', 'Investigation Number', 'Investigation Status', 'Observations'};
                    dlg_title = 'Add Report Information';
                    d = char(datetime('today'));
                    defaultans = {'Suspect', '00001', d, '1011', 'Ongoing', 'Nothing to Note'}; 
                    numlines = 1;
                    suspectInfo = inputdlg(prompt, dlg_title, numlines, defaultans);
                    
                    % set output document type.
                    doctype = 'pdf';
                    
                    % Generate Report
                    report = reportBuilder(reportPicture, dept, suspectInfo, doctype);
            end
            choice = menu('Complete Report', 'Save and Exit');
        end

end