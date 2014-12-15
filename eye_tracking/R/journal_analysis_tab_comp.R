# clear all previous variables
rm(list=ls())

#get lab version of useful R functions
source('~/Projects/Other/Ranalysis/useful_dplyr.R')

#load libraries for data manipulation and graphing
library(directlabels)
library(xtable)
library(magrittr)

#splits ages into half-years
split.ages <-function(x) {floor(x)}

#Constants for window-of-interest analysis
TEST_START <- 0
TEST_END <- 4.5

#Use color-brewer colors for graphing
man_cols <- c("#e41a1c","#377eb8","#4daf4a",
              "#984ea3","#ff7f00","#a65628",
              "#f781bf","#999999")

###############################################################################
################################ LOADING DATA #################################
###############################################################################
#read looking data
raw.data <- read.csv("../MATLAB/tab_comp_r.csv",header=TRUE)

data <- raw.data %>%
  #pre-process data values to be more English-readable
  mutate(
    trial.type = factor(trial.type,
                        labels=c("Familiar", "Novel")),
    aoi = as.character(factor(aoi, labels=c("Left", "Right","NA"))),
    time.step = time.step/60 - 2,
    gender = factor(gender,labels=c("Male","Female")),
    age.grp = factor(split.ages(age))) %>%
  filter(age >= 1)

# Reshape data for subsequent analyses 
source('munge_data_tab_comp.R')

# Create window-of-analysis graphs
source('dot_graphs.R')

# Compute statistical models for paper
source('statistical_models.R')

# Reshape timecourse data for subequent analyses
source('timecourse_data_tab_comp.R')

# Create timecourse graphs for paper
source('timecourse_graphs.R')