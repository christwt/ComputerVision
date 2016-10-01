## Early Vision	– One	Image

Create a simple image-processing program,	with functions similar	to those found in	Adobe	Photoshop or The Gimp. The functions you implement for this assignment will take an input image, process the image, and produce an output image. No functions from the Image Processing Toolbox were allowed in this assignment.

## Submission Contents:
1. vision_hwk1.m
      
    Driver program to create a menu driven application. Users may select from a pool of images and apply various filters to transform them.

2. padImg2.m

    Function to pad an image to allow for filtering to occur at image boundaries. 

3. meanFilter.m

    Function to apply an averaging kernel filter of user specified size to an image. The filter will average a single pixel with the others around it to apply a smoothing effect to the image.

4. gaussFilter.m

    Function to apply a gaussian kernel filter based on a user specified sigma value. The filter acts in a similar manner to the mean filter but with smoother results. 

5. scaleNearest.m

    Function to scale an image based on a user specified scaling factor. This method utilizes nearest point sampling to obtain pixel values and return the new image. 

6. scaleBilinear.m

    Function to scale an image based on a user specified scaling factor. This method utilizes bilinear interpolation in order to obtain pixel values. 

7. funFilter.m

    Function to apply non-linear mapping function to an image and create a 'swirl' effect. 

## To run:
1. Ensure all files are in the same folder in the matlab directory.

2. Run vision_hwk1.m to begin application.
