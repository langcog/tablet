###############################################################################
############################### TIMECOURSE DATA ###############################
###############################################################################
library(zoo)

# Compute timecourse for standard analysis
timecourse.test <- data %>%
  group_by(age.grp,word.type,time.step,trial.num) %>%
  summarise(prop = sum(aoi=="Target")/
              (sum(aoi=="Target")+sum(aoi=="Competitor"))) %>%
  summarise_each(funs(na.mean,sem),prop) %>%
  rename(prop = na.mean) %>% #cause problems with rollapply
  mutate(roll.mean = rollapply(prop,6,FUN=na.mean, partial=TRUE),
         roll.sem = rollapply(sem,6,FUN=na.mean, partial=TRUE)) %>%
  rename(na.mean = prop)

# Compute side of the screen Ps were on for each test trial
split.type <- data %>%
  ungroup() %>%
  filter(time.step == 0) %>%
  mutate(split.type = aoi) %>%
  select(subj,trial.type,trial.num,split.type,word.type)

# Subset test data to just for split analysis
split.data <- left_join(data,split.type) %>%
  filter(split.type == "Target" | split.type == "Competitor",
         time.step >= 0)

# Compute timecourses for split analysis
split.timecourse <- split.data %>%
  group_by(age.grp,word.type,trial.type,split.type,time.step,trial.num) %>%
  summarise(prop = sum(aoi=="Target")/
              (sum(aoi=="Target")+sum(aoi=="Competitor"))) %>%
  summarise_each(funs(na.mean,sem),prop) %>%
  rename(prop = na.mean)

split.timecourse[split.timecourse$split.type=="Target",]$prop <- 
  1 - split.timecourse[split.timecourse$split.type=="Target",]$prop 

split.timecourse %<>%
  mutate(roll.mean = rollapply(prop,6,FUN=na.mean,partial=TRUE)) %>%
  group_by(age.grp,word.type,time.step) %>%
  mutate(max = max(roll.mean),min = min(roll.mean))

split.timecourse[with(split.timecourse,
                      split.type=="Target" & min != roll.mean),
                 c("min","max")]<- 0
split.timecourse[with(split.timecourse,
                      split.type=="Competitor" & max != roll.mean),
                 c("min","max")]<- 0




