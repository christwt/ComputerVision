%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: gaussFilter
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ outImg ] = gaussFilter( inImg, sigma)

    % display error should user enter negative sigma
    while sigma < 0
        prompt={'Error: Please enter a positive value.'};
        title='Sigma Selection';
        answer=inputdlg(prompt,title);
        sigma = str2double(answer{1});
    end
    
    % calculate kernel size.
    kernel_size = 2 * ceil(2 * sigma) + 1;
    
    % generate gaussian kernel.
    % code adapted from https://www.codementor.io/tips/2742988831/how-to-create-and-apply-a-gaussian-filter-in-matlab-without-using-fspecial-or-imfilter
    index = -floor(kernel_size/2):floor(kernel_size/2);
    [a, b] = meshgrid(index, index);
    kernel = exp(-(a.^2 + b.^2) / (2*sigma*sigma));
    kernel = kernel / sum(kernel(:));
    
    [l,m,n] = size(inImg);
    
    % pad inImg based on kernel size. Same as in meanFilter.m 
    paddedImg = padImg2(inImg, kernel_size);
    
    % determing size of padded image. 
    [x,y,z] = size(paddedImg);
    
    % allocate outImg
    pad = floor(kernel_size/2);
    outImg = zeros(l,m,n);
    
    % code adapted from:
    % https://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
    % loop through image data plane by plane, starting at image edge.
    for color = 1:z
        for row = 1 + pad:x - pad
            for column = 1 + pad:y - pad
                % index through comparable pixels inImg and multiply by
                % kernel value using .*
                accum = paddedImg(row-pad:row+pad,column-pad:column+pad,color) .* kernel;
                % sum our adjusted values and place in output.  
                outImg(row-pad,column-pad,color) = sum(accum(:));
            end
        end
    end
    
end