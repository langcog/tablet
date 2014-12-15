###############################################################################
################################# T-STATISTICS ################################
###############################################################################
#Make a table of t, df, and p-vals
  ts <- test.data.subj %>%
  group_by(age.grp,word.type) %>%
  summarise( t = t.test(prop,mu=.5)$statistic,
             df = t.test(prop,mu=.5)$parameter,
             p.val = t.test(prop,mu=.5)$p.value,
             prop = na.mean(prop))

###############################################################################
############################# MIXED-EFFECTS MODELS ############################
###############################################################################

### EXPERIMENT 1 ###
lm1 <- lm(prop.Novel ~ age,data = lm.data)

### EXPERIMENTS 1 AND 2 ###
lm1 <- glmer(prop ~ age + (1 | subj), 
                    family="binomial", data = test.data.subj)

lm2 <- glmer(prop ~ age + word.type + (1 | subj),
                    family="binomial", data = test.data.subj)


lm3 <- glmer(prop ~ age + trial.type + (1 | subj),
             family="binomial", data = test.data.subj)
