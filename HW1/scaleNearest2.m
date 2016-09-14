%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: scaleNearest
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ outImg ] = scaleNearest2 ( inImg, factor1, factor2)

   % display error is user inputs negative factor. 
   while factor1 < 0 || factor2 < 0
        if factor1 < 0
            prompt={'Error: Please enter a positive value.'};
            title='Factor Selection';
            answer=inputdlg(prompt,title);
            factor1 = str2double(answer{1});
        elseif factor2 < 0
            prompt={'Error: Please enter a positive value.'};
            title='Factor Selection';
            answer=inputdlg(prompt,title);
            factor2 = str2double(answer{1});
        end
   end
    
    % determine size of input image. 
    [r,c,a] = size(inImg);
    scale = [factor1 factor2];
    
    % allocate output image. 
    outImg = zeros(scale(1)*r,scale(2)*c, a);
    
    % loop through outImg, mapping each pixel to nearest pixel in inImg
    % nearest point calculation adapted from:
    % http://stackoverflow.com/questions/1550878/nearest-neighbor-interpolation-algorithm-in-matlab
    for row = 1:scale(1)*r
        for col = 1:scale(2)*c
            x = round((row-1)*(r-1)/(scale(1)*r-1)+1);
            y = round((col-1)*(c-1)/(scale(2)*c-1)+1);
            % map outImg pixel with that of indexed inImg. 
            outImg(row,col,:) = inImg(x,y,:);
        end      
    end
    
    
end
