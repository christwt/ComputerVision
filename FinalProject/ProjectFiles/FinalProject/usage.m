% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: usage.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function usage()
% This function displays opening message to users and usage overview.

    usageNote = ['\n\nWelcome to Suspect Report Generator\n\n'...
            'This menu driven application allows users to:\n'...
            '\n\t1. Detect any and all faces in a video or image frame.'...
            '\n\t2. View and select a single face from the image.'...
            '\n\t3. Generate a Suspect Report including the extracted image.'...
            '\n\t4. Add information to the suspect report as desired.\n\n',...
            '\t   To begin, please select your department\n\n'];
        
    % display
    fprintf(usageNote);  
    
end