%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 2: plotHomographyPoints
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotHomographyPoints(coords1, check, image1, image2, indicator)
% this function will take corresponding points from one image and correlate
% them to what is computed using a homography transformation.
% then displays images with corresponding points shown for confirmation.

% forward mapping
if indicator == 0
    figure('Name','FM: original image','NumberTitle','off'), imshow(image1);
        hold on
        [x,~] = size(coords1);
        for i = 1:x
                plot(coords1(i,1), coords1(i,2), '.r', 'MarkerSize', 20);
                text(coords1(i,1), coords1(i,2), sprintf('    P%d', i), 'color', 'red');
        end
        hold off
    figure('Name','FM: translated points','NumberTitle','off'), imshow(image2);
        hold on
        [x,~] = size(check);
        for i = 1:x
                plot(check(i,1), check(i,2), '.r', 'MarkerSize', 20);
                text(check(i,1), check(i,2), sprintf('    P%d', i), 'color', 'red');
        end
        hold off
% backward mapping
elseif indicator == 1 
     figure('Name','BM: original image','NumberTitle','off'), imshow(image1);
        hold on
        [x,~] = size(coords1);
        for i = 1:x
                plot(coords1(i,1), coords1(i,2), '.r', 'MarkerSize', 20);
                text(coords1(i,1), coords1(i,2), sprintf('    P%d', i), 'color', 'red');
        end
        hold off
    figure('Name','BM: translated points','NumberTitle','off'), imshow(image2);
        hold on
        [x,~] = size(check);
        for i = 1:x
                plot(check(i,1), check(i,2), '.r', 'MarkerSize', 20);
                text(check(i,1), check(i,2), sprintf('    P%d', i), 'color', 'red');
        end
        hold off
end
end
