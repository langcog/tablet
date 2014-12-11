trial.codes <- read.csv("trial.codes.csv",header=TRUE,
                        stringsAsFactor = FALSE)

#summarize across individual trials
test.data <- left_join(data,trial.codes) %>% 
  filter(time.step >=TEST_START, 
         time.step <= TEST_END) %>%
  group_by(list.num,word.type,age,age.grp,gender,subj,trial.num,word.type,
           time.step)%>%
  mutate(aoi = if(aoi == "NA") "NA"
         else if(aoi== target) "Target"
         else "Competitor") %>%
  group_by(list.num,word.type,age,age.grp,gender,subj,trial.num,word.type) %>%
  summarise(
    prop = sum(aoi=="Target")/(sum(aoi=="Target")+sum(aoi=="Competitor")))

#summarize by subject
test.data.subj <- test.data %>%
  summarise(kept = sum(!is.na(prop))/length(prop),
            prop=na.mean(prop)) %>%
  filter(kept >= .5) %>% # Throw out participants who don't have enough data
  select(-kept) %>%
  ungroup()

#summarize by trial.type
test.data.trial <- test.data.subj %>%
  group_by(age.grp,word.type,add=FALSE) %>%
  summarise_each(funs(na.mean,ci.low,ci.high),prop)

###############################################################################
######################## SUBSET DATA FOR ANALYSES BELOW #######################
###############################################################################
preflook.data <- test.data.trial


ttest.data <- test.data.subj 


#Demographic data
demo.data <- test.data.subj %>%
  group_by(age.grp,word.type) %>%
  summarise(n = n(),
            num.girls = sum(gender=="Female")) %>%
  filter(word.type=="Familiar-Familiar") %>%
  select(-word.type)
