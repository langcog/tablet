###############################################################################
############################### TIMECOURSE DATA ###############################
###############################################################################
library(zoo)
TEST_TIMECOURSE_END <-4
TRAIN_TIMECOURSE_END <- 14.9

# Subset to test
timecourse.data <- data %>%
  filter(trial.type != "Learning",
         time.step <= TEST_TIMECOURSE_END)

# Subset to train
timecourse.train <- left_join(filter(data, trial.type == "Learning",
         time.step <= TRAIN_TIMECOURSE_END),train.annotations) %>%
  mutate(age.grp = factor(age.grp)) %>%
  group_by(age.grp,trial.type,clip.type,learn.type,trial.num,
           look,name2,reach,contact,end,time.step,trial.num,aoi) %>%
  summarise(n = n()) %>%
  filter(aoi != "NA") %>%
  mutate(n = n / sum(n)) %>%
  group_by(age.grp,trial.type,clip.type,learn.type,trial.num,
           look,name2,reach,contact,end,time.step,aoi,add=FALSE) %>%
  filter(aoi == "Target" | aoi == "Competitor" | aoi== "Face") %>%
  # | aoi == "Hand" | aoi == "Other Face"
  summarise_each(funs(na.mean,sem),n) %>%
  rename(prop = na.mean) %>% #na.mean causes problem with rollapply
  group_by(trial.type,clip.type,learn.type,trial.num,
           look,name2,reach,contact,end,time.step,age.grp,aoi) %>%
  mutate(roll.mean = rollapply(prop,6,FUN=na.mean, partial=TRUE),
         roll.sem = rollapply(sem,6,FUN=na.mean, partial=TRUE)) %>%
  rename(na.mean = prop)


# Compute timecourse for standard analysis
timecourse.test <- timecourse.data %>%
  group_by(age.grp,trial.type,time.step,trial.num) %>%
  summarise(prop = sum(aoi=="Target")/
              (sum(aoi=="Target")+sum(aoi=="Competitor"))) %>%
  summarise_each(funs(na.mean,sem),prop) %>%
  rename(prop = na.mean) %>% #cause problems with rollapply
  mutate(roll.mean = rollapply(prop,6,FUN=na.mean, partial=TRUE),
         roll.sem = rollapply(sem,6,FUN=na.mean, partial=TRUE)) %>%
  rename(na.mean = prop)

# Compute side of the screen Ps were on for each test trial
split.type <- timecourse.data %>%
  filter(time.step == 0) %>%
  mutate(split.type = aoi) %>%
  select(subj,trial.type,trial.num,split.type)

# Subset test data to just for split analysis
split.data <- left_join(timecourse.data,split.type) %>%
  filter(split.type == "Target" | split.type == "Competitor",
         time.step >= 0)

# Compute timecourses for split analysis
split.timecourse <- split.data %>%
  group_by(age.grp,trial.type,split.type,time.step,trial.num) %>%
  summarise(prop = sum(aoi=="Target")/
              (sum(aoi=="Target")+sum(aoi=="Competitor"))) %>%
  summarise_each(funs(na.mean,sem),prop) %>%
  rename(prop = na.mean)

split.timecourse[split.timecourse$split.type=="Target",]$prop <- 
  1 - split.timecourse[split.timecourse$split.type=="Target",]$prop 

split.timecourse %<>%
  mutate(roll.mean = rollapply(prop,6,FUN=na.mean,partial=TRUE)) %>%
  group_by(age.grp,trial.type,time.step) %>%
  mutate(max = max(roll.mean),min = min(roll.mean))

split.timecourse[with(split.timecourse,
                             split.type=="Target" & min != roll.mean),
                    c("min","max")]<- 0
split.timecourse[with(split.timecourse,
                         split.type=="Competitor" & max != roll.mean),
                    c("min","max")]<- 0




