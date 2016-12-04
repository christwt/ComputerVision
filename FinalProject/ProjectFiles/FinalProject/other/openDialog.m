% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: dialogInterface.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [choice] = openDialog()
% This function creates a series of dialogue boxes as a menu driven
% application to perform tasks specified by usage. 

    myicon = imread('lawEnforceIcon.jpg');
    myicon = imresize(myicon, [,200]);
    disp(size(myicon));
    
    d = dialog('Position',[500 500 500 500],'Name', 'Suspect Report Generator');
    
    txt = uicontrol('Parent',d,...
                    'Style','text',...
                    'Position',[100 100 300 250],...
                    'String',{'Welcome to Suspect Report Generator'});
                
    img = uicontrol('Parent',d,...
                    'CData',myicon,...
                    'Position', [100 100 300 250]);
    
    %uiwait(msgbox('Welcome to Suspect Report Generator', 'Welcome', 'custom', myicon));
    
    choice = menuDialog();
                     
end