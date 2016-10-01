%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: detPoints
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [coords] = detPoints(image, n)
    % function to determine points of distinctive features in images using
    % ginput().
    
    % error handling with user input. If number of points <=3, need to
    % reselect.       
    while n<=3
        prompt={'Error: enter a positive integer greater than or equal to 4 to select that number of points in corresponding images.'};
            title='Number of Corresponding Points Selection';
            answer=inputdlg(prompt,title);
            n = str2num(answer{1});
    end
    
    % display image
    figure, imshow(image);
    % number of coordinates
    
    % allocate
    coords = zeros(n,2);
    hold on
    % loop through using ginput to allocate selected points in image. 
    for i = 1:n
        [x,y] = ginput(1);
        coords(i,:) = [x,y];
    end
    hold off
    close(figure);
end