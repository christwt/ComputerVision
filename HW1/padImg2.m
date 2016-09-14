function [paddedImg] = padImg2(inImg, kernel_size)
    % tested using padarray first
    % paddedImg = padarray(inImg, [p p], 0, 'both');
    
    % set pad size.
    pad = floor(kernel_size/2);
    % determine size of image. 
    [x,y,z] = size(inImg);
    % create padded img via vector concatenations of zeros on all sides. 
    % side pads
    side = zeros(x,pad,z);
    paddedImg = horzcat(inImg, side);
    paddedImg = horzcat(side, paddedImg);
    % top and bottom pad
    top = zeros(pad, y+(2*pad), z);
    paddedImg = vertcat(paddedImg, top);
    paddedImg = vertcat(top, paddedImg);
end