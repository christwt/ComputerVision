function check = homographyTransform(coords1,H)
    % This function used to check whether homography matrix correctly
    % transforms corresponding points. 
    coords1 = coords1';
    
    % forward mapping function 
    % compute H * [x,y,z]'
    % need to convert cartensian coords to homogenous.
    q = H * [coords1; ones(1, size(coords1,2))];
    p = q(3,:);
    
    % normalize back to x,y coords
    check = [q(1,:)./p; q(2,:)./p];
end