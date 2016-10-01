%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: vision_hwk2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create Driver program

clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose Option', 'Exit Program', 'Load Images', 'Image Warp and Mosaic', 'Image Frame');

while choice ~= 1
    switch choice
        case 0
            disp('Error - please choose one of the options.')
            %menu
            choice = menu('Choose Options', 'Exit Program', 'Load Images', 'Image Warp and Mosaic', 'Image Frame');
        case 2
            % loading images to mosaic
            % load image1
            image1_choice = menu('Choose image: ', 'uttower', 'condo', 'billboard');
            switch image1_choice
                case 1
                    filename = 'uttower1.JPG';
                case 2
                    filename = 'condo1.jpg';
                case 3
                    filename = 'billboard1.jpg';
            end
            image = imread(filename);
            % convert to double. 
            reference = im2double(image);
            
            % resize image if image size too large. Prevent calculations
            % taking > 10 mins.
            if size(image,1) > 1000 || size(image,2) > 2000
                reference = imresize(reference, 0.25);
            end
            
            %load image2
            image2_choice = menu('Choose second image: must have same name', 'uttower', 'condo', 'billboard');
            switch image2_choice
                case 1
                    filename = 'uttower2.JPG';
                case 2
                    filename = 'condo2.jpg';
                case 3
                    filename = 'billboard2.jpg';
            end
            image = imread(filename);
            % convert to double
            image = im2double(image);
            if size(image,1) > 1000 || size(image,2) > 2000
                image = imresize(image, 0.25);
            end
            
        case 3
%-----------Task 1: Getting Correspondence:-----------------------------
            % manually identify coordinates from two view results are sensitive to the accurace of the corresponding points. 
            % attempt to choose distinctive points in the image that appear in both views. 
            
            % prompt to select number of corresponding points to select.
            prompt={'Enter a positive integer greater than or equal to 4 to select that number of points.'};
            title='Number of Corresponding Points Selection';
            answer=inputdlg(prompt,title);
            n = str2num(answer{1});
            
            % call coresponding function to determine points.
            reference_coords = detPoints(reference, n);
            %fprintf('coords1 = %d\n', coords1);
            image_coords = detPoints(image, n);
            %fprintf('coords2 = %d\n', coords2);

%-----------Task2: Computing Homography Parameters:-----------
            % write a function that takes a set of corresponding image points and
            % determines 3x3 homography matrix H. Useful functions include: '\'
            % operator(help mldivide), reshape. Verify homography matrix by mapping
            % clicked image points from one view to the other, display them on
            % respective image. 
            % Handle homogenous and non-homogenous coordinates correctly. 
            
            % compute homography matrix
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%% method using eig/SVD to compute homography points.
            H = computeHomography(image_coords, reference_coords);
            %fprintf('H = %d\n', H)
            
            % compute transform on chosen coordinates1 to see if they match
            % coordinates 2, plot results. 
            b_check = homographyTransform(image_coords, H);
            b_check = double(b_check.');
            f_check = homographyTransformR(reference_coords, H);
            f_check = double(f_check.');
            
            %plot points to show homography is working.
            plotHomographyPoints(reference_coords, f_check, reference, image, 0);
            plotHomographyPoints(image_coords, b_check, image, reference, 1);
                
%-----------Task3: Warping between image planes:-----------
            % write a function which takes recovered homography matrix and an image and
            % return a new image that is the warp of the image using H. Useful matlab
            % functions include: round, interp2, meshgrid, isnan
            
            % call appropriate warp function.
            % warp image into frame of reference.
            warp = warpImg3(image, H);
            
            % display figure of warped image. 
            figure ('Name','Warped Image','NumberTitle','off'), imshow(warp);

%-----------Task4: Create output mosaic:-----------
            % create a new image large enough to hold both registered
            % views; overlay view onto the other leaving black where no data is available. 
            
            % call appropriate mosaic function
            mosaic = mosaicImg(reference, image, H);
            
            % display figure of mosaiced images. 
            figure('Name', 'Image Mosaic', 'NumberTitle', 'off'), imshow(mosaic);
            
            % write image mosaic to file for submission.
            imwrite(mosaic, 'mosaic.JPG');
            
%-----------Task5:-----------
            % 1. apply system to provided images and display outpit. 
            % 2. show two additional mosiac examples using images that you have taken. 
            % 3. warp one image into a "frame" region in the second image.
            
        case 4
            % warp one image into a "frame" region in the second image. 
            
            
            % for this section I decided to warp my dog Kobalt into a blank
            % billboard sign.
            
            % process followed from: http://126kr.com/article/7i3ustctkkt
            % which describes the steps to transform an image into the
            % reference frame of another image. 
            
            % read in images.
            destination = imread('billboard.jpg');
            source = imread('Kobalt.jpg');
            
            % convert to double precision to allow imshow
            dest = im2double(destination);
            src = im2double(source);
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uncomment line below to resize image to increase speed of calculations.
            %src = imresize(source, 0.25);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % determine dest and image coords. 
            dest_coords = detPoints(dest, 4);
            
            %maxes = max(dest_coords);
            %mins = min(dest_coords);
            
            %min_row = mins(1);
            %max_row = maxes(1);
            %min_col = mins(2);
            %max_col = maxes(2);

            %col_dist = max(1)-min(1);
            %row_dist = max(2)-min(2);
            
            % compute size destinatio image for further use.
            [hd,wd,~] = size(dest);

            % our source coordinates will be the corners of the source
            % image.
            [h,w,~] = size(src);
            src_coords = [0 0; w 0; w h; 0 h];
            
            % compute homgraphy to transform source coords to dest coords. 
            H = computeHomography(src_coords, dest_coords);
            
            %apply warp function from mosaicing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uncomment below to see bounded warp of source image as in warpImg3.m from
% mosaic section
            %warp = warpImg3(source,H);
            %display image. 
            %figure('Name', 'warped image', 'NumberTitle', 'off'), imshow(warp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % allocate outImg.
            frame = zeros(hd, wd, 3);
            
            % add destination to outImg
            frame = frame + dest;
            
            % loop through outImg and place pixels from source if they are
            % in range.
            % backwards homography coordinates in order to place image into
            % billboard.
            % loop through output image
            % takes a long time due to size of Kobalt image.
            for i = 1:h
                for j = 1:w
                    % convert to homogenous points
                    coords = [i; j; 1];
                    % transform coordinates using homography matrix
                    coords = inv(H) * coords;
                    % normalize coordinates back
                    coords(1) = coords(1)/coords(3);
                    coords(2) = coords(2)/coords(3);
                    
                    x = coords(1);
                    y = coords(2);
                    % ensure we are in range of destination image.
                    if (x>=1 && x<=w) && (y>=1 && y<=h)
                        % nearest sample coordinates to fill billboard
                        frame(j,i,:) = src(round(y),round(x),:);
                    end
                end
            end
            
            % display completed image.
            figure('Name', 'warped image', 'NumberTitle', 'off'), imshow(frame);
            
            % write image to file for submission.
            imwrite(frame, 'Frame.JPG');        
          
    end
    % reload menu.
    choice = menu('Choose Option', 'Exit Program', 'Load Images', 'Image Warp and Mosaic', 'Image Frame');
end



 




