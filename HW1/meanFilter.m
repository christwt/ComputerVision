%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: meanFilter
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ outImg ] = meanFilter( inImg, kernel_size)

    % display error and get new prompt if kernel size not positive integer.
    while (kernel_size < 0 || kernel_size <3 || mod(kernel_size,2) == 0) 
        prompt={'Error: Please enter a positive, odd, integer greater than or equal to 3.'};
        title='Kernel Size Selection';
        answer=inputdlg(prompt,title);
        kernel_size = str2num(answer{1});
    end
    
    [l,m,n] = size(inImg);
    
    % pad image based on kernel size. Ex: kernel = 3x3; pad = 1. 
    pad = floor(kernel_size/2);
    paddedImg = padImg2(inImg, kernel_size);
     
    % determine size of padded image
    [x,y,z] = size(paddedImg);
    
    % allocate outImg
    outImg = zeros(l,m,n);
    
    % code adapted from:http://stackoverflow.com/questions/31025506/average-filter-matlab
    % loop through image data plane by plane, starting at edge of image.
    for color = 1:z
        for row = 1 + pad:x - pad
            for column = 1 + pad:y - pad
                    % loop through kernel.
                    accum = 0;
                    for r = row-pad:row+pad
                        for c = column-pad:column+pad
                            % apply kernel adjustment to appropriate pixel
                            % and add to accumulator.
                            accum = accum + paddedImg(r,c,color);
                        end
                    end
                % place averaged pixel value into outImg. 
                outImg(row-pad,column-pad,color) = accum/(kernel_size*kernel_size);
            end
        end
    end
end