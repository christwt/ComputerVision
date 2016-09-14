%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: scaleBilinear
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ outImg ] = scaleBilinear2( inImg, factor)
    % display error for any negative factor input.
   while factor < 0
       prompt={'Error: Please enter a positive value.'};
       title='Row scaletor Selection';
       answer=inputdlg(prompt,title);
       factor = str2double(answer{1});  
   end
   
   % determine size of inImg
   [r, c, a] = size(inImg);
   
   % calculate outImg, allocate space.
   r_out = floor(factor*r);
   c_cout = floor(factor*c);
   scale = factor;
   outImg = zeros(r_out,c_cout,a);
   
   % code for bilinear interpolation adapted from:
   % https://thilinasameera.wordpress.com/2010/12/24/digital-image-zooming-sample-codes-on-matlab/
   % Utilizes Unit square coord system method: https://en.wikipedia.org/wiki/Bilinear_interpolation
   % f(x,y) = f(0,0)(1-x)(1-y)+f(1,0)x(1-y)+f(0,1)(1-x)y+f(1,1)xy
   % loop through outImg
   for row = 1:r_out;
       % x coords interpolation point 
       x1 = floor(row/scale);
       x2 = ceil(row/scale);
       if x1 == 0
           x1 = 1;
       end
       % obtain x distance from outImg pixel to mapped pixels.
       x = rem(row/scale,1);
       for col = 1:c_cout;
           % y coords interpolation point
           y1 = floor(col/scale);
           y2 = ceil(col/scale);
           if y1 == 0
               y1 = 1;
           end
           
           % 4 neighboring pixel values.
           c10 = inImg(x1,y1,:);
           c00 = inImg(x2,y1,:);
           c11 = inImg(x1,y2,:);
           c01 = inImg(x2,y2,:);
           
           % obtain y distance from outImg pixel to mapped pixels.
           y = rem(col/scale,1);
           
           % approximate intesity of pixel in outImg
           % affix pixel value in outImg.
           tr = (c11*y)+(c10*(1-y));
           br = (c01*y)+(c00*(1-y));
           outImg(row,col,:) = (tr*x)+(br*(1-x));
       end
   end
end
