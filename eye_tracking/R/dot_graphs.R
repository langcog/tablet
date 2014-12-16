###############################################################################
################# FIGURE 6: LEARNING AND TEST PROPS. IN EXP 1 #################
###############################################################################
quartz(width=6.5,height=4.5,title = "Test Data")
ggplot(test.data.trial, 
       aes(x=as.numeric(age.grp), y=prop_na.mean,colour=word.type))+
  facet_wrap( ~ word.type) +
  geom_pointrange(aes(ymin = prop_na.mean-prop_ci.high,
                      ymax = prop_na.mean+prop_ci.low),
                  position = position_dodge(.3),
                  size=.8)+
  geom_hline(aes(yintercept=.5),lty=2)  +
  geom_line(aes(group=word.type)) +
  scale_x_continuous(breaks=seq(1,4,1),
                     name = "Age(years)")+ 
  scale_y_continuous(limits = c(.2,1), breaks=seq(.2,1,.1),
                     name = "Prop. Looks to Target vs. Competitor") +
  theme_bw(base_size=18) + 
  theme(legend.position="none")+#c(.95,.6),legend.title=element_blank()) +
  scale_color_manual(values=man_cols)


quartz(width=6.5,height=4.5,title = "Test Data")
ggplot(test.data.trial, 
       aes(x=as.numeric(age.grp), y=rt_na.mean,colour=word.type))+
  facet_wrap( ~ word.type) +
  geom_pointrange(aes(ymin = rt_na.mean-rt_ci.high,
                      ymax = rt_na.mean+rt_ci.low),
                  position = position_dodge(.3),
                  size=.8)+
  geom_line(aes(group=word.type)) +
  scale_x_continuous(breaks=seq(1,4,1),
                     name = "Age(years)")+ 
  scale_y_continuous(limits = c(.2,1), breaks=seq(.2,1,.1),
                    name = "Reaction Time (sec)") +
  theme_bw(base_size=18) + 
  theme(legend.position="none")+#c(.95,.6),legend.title=element_blank()) +
  scale_color_manual(values=man_cols)
