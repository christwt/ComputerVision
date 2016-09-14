%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: vision_hwk1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this script creates a menu driven application.

clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Scale Nearest', ...
    'Scale Bilinear', 'Fun Filter');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Scale Nearest', ...
    'Scale Bilinear', 'Fun Filter');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'lion', 'husky');
           % I decided to use only jpg images from the homework and added a
           % few of my own.
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'lion.jpg';
               case 4
                   filename = 'husky.jpg';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           % 1. Ask the user for size of kernel
           prompt={'Enter a positive, odd, integer greater than or equal to 3 to select kernel size'};
           title='Kernel Size Selection';
           answer=inputdlg(prompt,title);
           k_size = str2num(answer{1});
           
           % convert image to double precision to prevent pixel saturation.
           % calculation adapted from:
           % https://www.mathworks.com/matlabcentral/answers/14053-what-is-the-formula-to-convert-uint8-image-to-double-format
           current_img = double(current_img)/255;
           
           % 2. Call the appropriate function  
           newImage = meanFilter(current_img, k_size);
           
           % 3. Display the old and the new image using subplot
           figure
           subplot(2,2,1), imagesc(current_img);
           subplot(2,2,2), imagesc(newImage);
           
           % 4. Save resulting image.
           imwrite(newImage, 'Mean_Filter_Result.jpg');
                  
       case 5
           % Gaussian Filter
           % 1. Ask user for positive sigma input. 
           prompt={'Enter a positive sigma value.'};
           title='Sigma Selection';
           answer=inputdlg(prompt,title);
           sigma = str2double(answer{1});
           
           % convert image to double precision to prevent pixel saturation.
           % calculation adapted from:
           % https://www.mathworks.com/matlabcentral/answers/14053-what-is-the-formula-to-convert-uint8-image-to-double-format
           current_img = double(current_img)/255;
           
           % 2. Call gaussFilter function, with current image and sigma as input. 
           newImage = gaussFilter(current_img, sigma);
           
           % 3. Display original image and image returned by function. 
           figure
           subplot(2,2,1), imagesc(current_img);
           subplot(2,2,2), imagesc(newImage);
           
           % 4. Save resulting image. 
           imwrite(newImage, 'Gauss_Filter_Result.jpg');
              
       case 6
           % Scale Nearest
           % 1. Ask user for positive factor input. 
           prompt={'Enter a positive factor value to scale height.',...
                   'Enter a positive factor value to scale width.'};
           title='Factor Selection';
           answer=inputdlg(prompt,title);
           factor1 = str2double(answer{1});
           factor2 = str2double(answer{2});
           current_img = double(current_img)/255;
           
           % 2. Call scale nearest function, with current image and factor
           % as input. 
           newImage = scaleNearest2(current_img, factor1, factor2);
          
           % 3. Display original image and image returned by function.
           % Scaling shown by axes, images the same size visually. 
           figure
           subplot(2,2,1), imagesc(current_img); axis equal;
           subplot(2,2,2), imagesc(newImage); axis equal;
      
           % 4. Save resulting image. 
           imwrite(newImage, 'Scale_Nearest_Filter_Result.jpg');
           
       case 7
           % Scale Bilinear
           % 1. Ask user for positive factor input. 
           prompt={'Enter a positive factor value  for image scaling'};
           title='Factor Selection';
           answer=inputdlg(prompt,title);
           factor = str2double(answer{1});
           current_img = double(current_img)/255;
            
           % 2. Call scale bilinear function, with current image and factor as input. 
           newImage = scaleBilinear2(current_img, factor);
           
           % 3. Display original image and image returned by function.
           % scaling shown by axes, images the same size visually. 
           figure
           subplot(2,2,1), imagesc(current_img); axis equal;
           subplot(2,2,2), imagesc(newImage); axis equal;
           
           % 4. Save resulting image. 
           imwrite(newImage, 'Scale_Bilinear_Filter_Result.jpg');
           
       case 8
           % Fun Filter
           prompt={'This filter will apply the swirl effect to the image. Enter a positive value to adjust amount of swirl. (lower numbers = tighter swirls) Recommend starting with 100.'};
           title='Swirl Selection';
           answer=inputdlg(prompt,title);
           swirl = str2double(answer{1});
           current_img = double(current_img)/255;
           
           % 2. Call funFilter function with current image and swirl amount
           % as input. 
           newImage = funFilter(current_img, swirl);
           
           %3. Display original image and image returned by function
           figure
           subplot(2,2,1), imagesc(current_img);
           subplot(2,2,2), imagesc(newImage);
           
           % 4. Save resulting image. 
           imwrite(newImage, 'Fun_Filter_Result.jpg');
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Scale Nearest', ...
    'Scale Bilinear', 'Fun Filter');  % as you develop functions, add buttons for them here
end