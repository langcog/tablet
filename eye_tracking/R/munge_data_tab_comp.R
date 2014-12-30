trial.codes <- read.csv("trial.codes.csv",header=TRUE,
                        stringsAsFactor = FALSE)

RT.MIN = .3
PROP.MIN = .5

#summarize across individual trials
data <- left_join(data,trial.codes) %>% 
  filter(time.step >= TEST_START,
         time.step <= TEST_END) %>%
  group_by(list.num,word.type,age,age.grp,gender,sid,whole.trial.num,word,
           trial.num,trial.type,
           time.step)%>%
  mutate(aoi = if(is.na(aoi) | is.na(target) | aoi == "NA") "NA"
         else if(aoi== target) "Target"
         else "Competitor")

test.data <- data %>%
  filter(time.step >= RT.MIN) %>%
  group_by(list.num,word.type,age,age.grp,gender,sid,trial.num,whole.trial.num,word)

test.rts <- test.data %>%
  filter(aoi == "Target") %>%
  summarise(rt = min(time.step)) %>%
  filter(rt > RT.MIN)

test.props <- test.data %>%
  filter(time.step >= PROP.MIN) %>%
  summarise(prop = sum(aoi=="Target")/(sum(aoi=="Target")+sum(aoi=="Competitor")))

test.data <- left_join(test.rts,test.props)


write.csv(test.data,'eye.tracking.csv')

# 
# #summarize by subject
# test.data.subj <- test.data %>%
#   summarise(kept = sum(!is.na(prop))/length(prop),
#             prop=na.mean(prop),
#             rt = na.mean(rt)) %>%
#   filter(kept >= .5) %>% # Throw out participants who don't have enough data
#   select(-kept) %>%
#   ungroup() %>%
#   mutate(word.type = factor(word.type),
#     trial.type = factor(ifelse(word.type=="Novel-Familiar","Novel","Familiar")))
# 
# #summarize by trial.type
# test.data.trial <- test.data.subj %>%
#   group_by(age.grp,trial.type,word.type,add=FALSE) %>%
#   summarise_each(funs(na.mean,ci.low,ci.high),c(prop,rt))
# 
# ###############################################################################
# ######################## SUBSET DATA FOR ANALYSES BELOW #######################
# ###############################################################################
# #Demographic data
# demo.data <- test.data.subj %>%
#   group_by(age.grp,word.type) %>%
#   summarise(n = n(),
#             num.girls = sum(gender=="Female")) %>%
#   filter(word.type=="Familiar-Familiar") %>%
#   select(-word.type)
