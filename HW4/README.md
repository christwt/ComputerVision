## Stereo Vision with Dynamic Programming

Learn Stereo Segmentation techniques using Dynamic Programming. 

## Submission Contents:
1. findLCS.m
      
   Function to determine the Longest Common Subsequence between 2 strings. 

2. printLCS.m

    Function to return the Longest Common Subsequence between 2 strings.  

3. calculateDisparity.m

     Function that takes as inputs left and right rectified grayscale stereo images and creates the disparity map between the 2 images.

4. getDisparity.m

    Function that creates the cost function table and direction table and fills them based on the 2 epipolar scanlines in the left and right rectified images. 

5. backtrack.m
      
    Function that utilizes the direction table to backtrack and determine the disparity vector for the 2 epipolar scanlines.
    
6. displayDMap.m
     
    Function to display the disparity map, coloring occluded pixels red.
    
7. .fig files show individual disparity maps obtained using the functions above of the provided images. 

## To run:
1. Ensure all files are in the same folder in the matlab directory.

2. Run DepthEstimationFromStereoVideoExample.m to begin application.
