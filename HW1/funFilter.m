%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Homework 1: funFilter
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ outImg ] = funFilter(inImg, swirl)
    % will implement swirl filter on chosen image. 
    % allow user to select amount of swirl to place on the image. 
    % code adapted from: http://angeljohnsy.blogspot.com/2011/06/swirl-effect-in-matlab.html
    % idea to convert Cartesian to Polar coordinates espacially helpful in calculating angle and radius. 
    
    % pre allocate outImg. Size will not change. 
    outImg = zeros(size(inImg));
    
    % Determine the mid point of inImg (x0,y0)
    x0=ceil((size(inImg,1)+1)/2);
    y0=ceil((size(inImg,2)+1)/2);

    % amount of 'swirl' in image. 
    swirl_len=swirl;
    
    % allocate matrix to hold transformed coords of inImg. 
    xt=zeros([size(inImg,1) size(inImg,2)]);
    yt=zeros([size(inImg,1) size(inImg,2)]);
    
    % loop through inImg, transforming pixels and storing in new locations
    % in xt and yt. 
    for row=1:size(inImg,1)
        x=row-x0-swirl_len;
        for col=1:size(inImg,2)
           % Cartesian to Polar coordinates. Makes it much easier to
           % calculate angle and radius. Utilizes matlab inbuilt
           % cart2pol().
           [theta,rho]=cart2pol(x,col-y0+swirl_len);
           
           % formula to calculate transformed radius and angle. 
           % new[theta, rho] = old[theta + rho/K, rho]
           new_theta=theta+(rho/swirl_len);
       
           % Polar to Cartesian conversion. New coords to be stored in xt and yt.
           % uses matlab inbuilt pol2cart().
           % adjust coords to account for distance from center.
           [l,m]=pol2cart(new_theta,rho);
           xt(row,col)=ceil(l)+x0;
           yt(row,col)=ceil(m)+y0;
       
       end
   end
   
   % ensure that we do not go out of bounds of outImg, negative indices to 1, indices > #cols/#rows changed to 
   % size(inImg).
   xt=max(xt,1);
   xt=min(xt,size(inImg,1));
   yt=max(yt,1);
   yt=min(yt,size(inImg,2));
    
   % Loop through image, updating outImg pixels with transformed pixels
   % given by location (xt(row,col), yt(row,col)).
   for row=1:size(inImg,1)
       for col=1:size(inImg,2)
           outImg(row,col,:)=inImg(xt(row,col),yt(row,col),:);
       end
   end
end
