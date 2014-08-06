tablet_norming
==============

Norming experiments for the use of tablets in developmental research

This repository contains all of the code associated with the experiment "Using Tablets to Collect Data from Young Children" presented in the Journal of Cognition and Development. This readme contains information about the contents of each folder for the repository.

analysis: contains R markdown files for analysis of data. analysis.Rmd reads in data both from tabletstudyresults.csv, which contains the data from all trials, and tablet_demographics.csv, which contains demographics information and information about participant exclusion.

audio: contains audio files for the filler trials used in the study. For the audio incorporated into the final version of the experiment in sprite form, please see the "iPad" folder.

data: contains both csv files with final data: tabletstudyresults.csv and tablet_demographics.csv. 

filler_images: the images used for filler trials. 

*----------------------------

final_expt: folder containing all of the files and code that were used for the iPad study. Contains the following folders and files...

dots: images of five different colored dots, a smiley face, and an x. Used at the very beginning of the study in a simple game to engage the child and provide minimal touchscreen training. 

images: stanford logo and background for button, used at starting slide of study.

spriteData.js: contains information about the start time, the length, and the onset of the target word for each of the sound files in the sprite. Everytime a sound is played in the study, spriteData.js is used to index into the mp3 at the appropriate spot.

styecentered.css: basic style sheet for the study.

tablet_sprite_edited.mp3: a sound file which is a concatenation of every sound used in the study (including the filler audio from the folder "audio"). Created using Audacity. Information for where each sound prompt occurs within the mp3 is contained within "spriteData.js."

tabletcentered.html: html for the study. 

tabletcentered.js: controls all the dynamic elements of the study; switching between parts of the study, controlling click sensitivity, initiating sound, etc. Please see comments within code.

tabletobjects: fillers and critical object images used in the study. 

tabletstudysave.php: small php script called at the end of every trial. Takes in a string wort of data and "ships" it to become a row appended onto a csv in the server (creates the csv if no csv with that name yet exists). 

----------------------------*

image_pairs:
image_pairs_white: both of these folders contain jpgs of images paired together for use in eyetracking studies.

images: images used as stimuli, in jpg form. 

stimulus_generation: contains script used to generate the paired images for eyetracking studies. stimulus_pairs.csv specifies which images below paired together, and make_stims.m reads from this file to generate the stimuli. 

writeup: contains files associated with the final write-up of the study. 
