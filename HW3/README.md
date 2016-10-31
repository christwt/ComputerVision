mage Mosaics

Implement an image stitcher that uses image warping and homographies to automatically create an image mosaic.  Assignment focused on the case where we had 2 images to stitch together. Practice with manipulating homogenous coordinates, computing homography matrices, and performing image warps.  Corresponding points collected with mouse clicks.

## Submission Contents:
1. vision_hwk2.m
      
    Driver program to create a menu driven application. Users may select from a pool of images and stitch them together. Users may also view an example of warping an image into a "frame" of another image. In this case an image of my dog Kobalt is warped into a billboard frame. Users select the frame of the billboard in which to warp the source image. Note that different sequences of corner clicks will rotate the source image in different ways. Users may modify this code to warp other images into the billboard. 

2. detPoints.m

    Function by which user selects 4 pairs of correspondence points from the 2 images to be mosaiced.  

3. computeHomography.m

     Function to build the homography matrix based on the 4 set of correspondence points. Uses SVD to solve coefficient matrix to obtain homography.

4. homographyTransformR.m, homographyTransform.m

    Functions for checking that calculated homography warps corresponding points in images correctly.

5. plotHomographyPoints.m

    Function which uses homographyTransformR/homographyTransform.m to plot corresponding points in the images for visual confirmation that the homography matrix warps corresponding points correctly. 

6. warpImg.m

    Simplistic function to warp a source image into the plane of a refernce image based on a homography matrix H. Places the image in a bounding box of the size of the image. 

7. warpImg3.m

    Function to warp a source image into the plane of a reference image based on a homography matrix H. This function calculates its bounding box based on forward mapping of the source image corners with the homography matrix.

8. warpImage.m

    Function to warp a source image into the plane of a reference image based on a given homography matrix, given points to establish a bounding box, and a translation matrix to translate the warped image to its proper place in the mosaic.

9. mosaicImg.m

    Function which utilizes warpImage.m to warp a source image into the plane of a reference image and stitch the two images together. This method also calculates a bounding box based on the corners of the 2 images and utilizes the max() function to somewhat smooth the boundary between the stitched images.

## To run:
1. Ensure all files are in the same folder in the matlab directory.

2. Run vision_hwk2.m to begin application.

