tablet_norming
==============

Norming experiments for the use of tablets in developmental research

This repository contains all of the code associated with the experiment "Using Tablets to Collect Data from Young Children" presented in the Journal of Cognition and Development. This readme contains information about the contents of each folder for the repository.

analysis: contains R markdown folders for analysis of data. analysis.Rmd reads in data both from tabletstudyresults.csv, which contains the data from all trials, and tablet_demographics.csv, which contains demographics information and information about participant exclusion.

audio: contains audio files for the filler trials used in the study. For the audio incorporated into the final version of the experiment in sprite form, please see the "iPad" folder.

data: contains both csv files with final data: tabletstudyresults.csv and tablet_demographics.csv. 

filler_images: the images used for filler trials. 


iPad: folder containing all of the files and code that were used for the iPad study. {TODO}

image_pairs:
image_pairs_white: both of these folders contain jpgs of images paired together for use in eyetracking studies.

images: images used as stimuli, in jpg form. 

stimulus_generation: contains script used to generate the paired images for eyetracking studies. stimulus_pairs.csv specifies which images below paired together, and make_stims.m reads from this file to generate the stimuli. 

writeup: contains files associated with the final write-up of the study. 
