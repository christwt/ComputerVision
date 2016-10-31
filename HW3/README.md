## Stereo Vision With Dynamic Programming

Learn Stereo Segmentation techniques by implementing functions from a stereo pipeline example from matlab. 

## Submission Contents:
1. DepthEstimationFromStereoVideoExample.m
      
   Example program provided by matlab and adjusted to use my own disparity map functions and other functions as described below. 

2. calcDisparity.m

    Function that takes as inputs left and right rectified grayscale stereo images and creates the disparity map between the 2 images using user specified window sizes and SSD calculations.  

3. calcNCC3.m

     Function that takes as inputs left and right rectified grayscale stereo images and creates the disparity map between the 2 images using user specified window sizes and NCC calculations.

4. consistencyCheck.m

    Function that performs LR consistency check between LR and RL disparity maps in order to determine occluded pixels and generate an outliers map. 

5. reconstruct.m
      
    Function to take in a disparity map and utilizes given camera parameters to return a matrix of depth values for each pixel in the left image.
    
6. .fig files show individual results obtained from utilizing the functions above as compared with functions provided by the stereo pipeline example. 

## To run:
1. Ensure all files are in the same folder in the matlab directory.

2. Run DepthEstimationFromStereoVideoExample.m to begin application.

