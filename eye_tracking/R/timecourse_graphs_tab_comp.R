###############################################################################
################### FIGURE 3: TEST TRIAL TIMECOURSE IN EXP 1 ##################
###############################################################################
quartz(width=10,height=3,title = "Test Looking")
ggplot(filter(timecourse.test,time.step==round(time.step,2)),
       aes(x=time.step, y=roll.mean, 
           colour=age.grp, fill = age.grp))+
  facet_grid(~ word.type) +
  geom_ribbon(aes(ymin = roll.mean-roll.sem,
                  ymax = roll.mean+roll.sem),
              alpha = .3, linetype = 0) +
  geom_line(size=.8) +
  geom_vline(aes(xintercept=0),lty=2) +
  geom_hline(aes(yintercept=.5),lty=2)  +
  scale_x_continuous(limits = c(-1.5,4.5),breaks=seq(-2,4.5,1),
                     name = "Time(s)") + 
  scale_y_continuous(limits = c(.25,1), breaks=seq(.25,1,.25),
                     name = "Prop. Looks to Target") +
  theme_bw(base_size=14) +
  guides(color = guide_legend(reverse = TRUE),
         fill = guide_legend(reverse = TRUE)) +
  scale_color_manual(name="Age Group",
                     values=man_cols) +
  scale_fill_manual(name="Age Group",
                    values=man_cols)

###############################################################################
################## FIGURE 4: ONSET-CONTINGENT PLOT FOR EXP 1 ##################
###############################################################################
quartz(width=12,height=6,title = "Test Looking")
ggplot(split.timecourse, aes(x=time.step, y=roll.mean, 
                               colour=word.type, fill = word.type,
                               linetype=split.type,))+
  facet_grid(word.type ~ age.grp) +
  geom_line(size=.8) +
  geom_hline(aes(yintercept=.5),lty=2)+
  geom_ribbon(aes(ymin=min,ymax=max),fill="gray",alpha=.2, 
              colour=NA) +
  scale_x_continuous(limits = c(0,TEST_TIMECOURSE_END),
                     breaks=seq(-1,TEST_TIMECOURSE_END),
                     name = "Time(s)") + 
  scale_y_continuous(limits = c(0,1), breaks=c(0,.25,.5,.75,1),
                     name = "Prop. Looks to Switch") +
  theme_bw(base_size=14) + theme(legend.position=c(.055,.932)) +
  guides(colour=FALSE,linetype=guide_legend(title=NULL)) +
  scale_color_manual(values=man_cols[1:4]) +
  scale_fill_manual(values=man_cols[1:4]) +
  scale_linetype_discrete(name="Split Type")

