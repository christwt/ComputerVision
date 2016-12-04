### Suspect Report Generator

Menu based application that performs frontal face detection using the Viola Jones Algorithm on an image or video file. All detected faces are indexed for extraction to a generated Suspect Report PDF document. Written in MATLAB v2016a using the Computer Vision Tool Box and Report Generation Tool.

## Submission Contents:
1. **userInterface.m** - script to run menu driven application.

2. **findFace.m** - function to perform facial detection.

3. **formatFace.m** - function to extract identified face for suspect report. 

4. **generateReport.m** - function to collect user input for suspect report. 

5. **reportBuilder.m** - function to format and create PDF document. 

6. **testFacialRecog.m** - function used to run a variety of tests on /testImages.

7. **myPDFtemplat2.pdftx** - zip file containing HTML doc part template and styling for report generation.

8. /testImages - folder to hold downloaded test images.

9. /myPDFtemplate - unaltered version of standard doc part template and styling for report generation.

10. /other - folder containing old/unused code. 

11. /suspectReport - folder containing sameple suspect reports and generated object files.

12. .jpg - sample images used to generate suspect reports. 

### To run Suspect Report Generator:
1. Place ProjectFiles folder into MATLAB, ensure any other desired images/videos are in the same folder. 

2. Open ProjectFiles and navigate to userInterface.m

3. Click Run or type userInferface(); in command window.

4. If further help is required view usage statments within command window at each step.

### To run testRecog:
1. Open testFacialRecog.m

2. Change directory path to desired directory/files to run test on.

Usage: 
* testFacialRecog('test') - run on specified directory to get statistics on facial detection.

* testFacialRecog('images') - run on specified directory to obtain mosaic of images in directory with identified faces. 

* testFacialRecog('vid') - run on specified video file to obtain jpg image of identified faces in video frame. 
* testFacialRecog('im') - run on specified image file to obtain jpg image of identified faces in image frame.

