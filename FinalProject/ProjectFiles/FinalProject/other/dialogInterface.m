% %%%%%%%%%%%%%%%%%%%%%%%%%%
%
% William Christie
% SID: 810915676
% CSCI 4830/5722
% Instructor: Fleming
% Final Project: dialogInterface.m
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This simple script creates a menu driven application to locate and track
% a face through a series of video frames. Uses functions from the Computer
% Vision Toolbox and follows the algorithm described by
% FaceTrackingUsingKLTExample.

% usage statement to console. 
usage();

% open application.
choice = menuDialog();

fprintf('%s\n', choice');