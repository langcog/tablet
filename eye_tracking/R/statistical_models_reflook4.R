###############################################################################
################################# T-STATISTICS ################################
###############################################################################
#Make a table of t, df, and p-vals
ts <- ttest.data %>%
  group_by(age.grp,window.type) %>%
  summarise( t = t.test(prop,mu=.5)$statistic,
             df = t.test(prop,mu=.5)$parameter,
             p.val = t.test(prop,mu=.5)$p.value,
             prop = na.mean(prop))

###############################################################################
############################# MIXED-EFFECTS MODELS ############################
###############################################################################

### EXPERIMENT 1 ###
lm1 <- lm(prop.Novel ~ age,data = lm.data)

#for kids only
lmer.data.typical <- filter(lmer.data,age.grp != "adult", age.grp != "ASD")
lmer.data.adult <- filter(lmer.data,age.grp == "adult")
lmer.data.asd <- filter(lmer.data,age.grp == "ASD")

lm1 <- glmer(Novel ~ age + look.name2 + (1|subj),
      data=lmer.data.typical,family="binomial")

lm2 <- glm(Novel ~ look.name2 ,
             data=lmer.data.adult,family="binomial")

lm3 <- glm(Novel ~ look.name2 + reach.contact ,
           data=lmer.data.asd,family="binomial")

lm3 <- glmer(Novel ~ name.look + (1|subj),
             data=lmer.data.asd,family="binomial")

,
     data=lmer.data.typical)


#Model Reported in Experiment 1
lm2 <- lm(Novel ~  look.name2, data = lmer.data)
lmer.data$wl.pred <- predict(lm2,newdata=lmer.data)

lm3 <- lm(prop.Novel ~ prop.baseline + prop.name.look + prop.look.name2 + 
            prop.name2.reach + prop.reach.contact + prop.contact.end,
          data = lm.data)
lm.data$wl.pred <- predict(lm3,newdata=lm.data)

e1.lm3 <- glmer(prop ~ age * trial.type + (1 | subj), 
                family="binomial", data = lmer.data.e1)
anova(e1.lm2,e1.lm3)

### EXPERIMENTS 1 AND 2 ###
e1and2.lm1 <- glmer(prop ~ age + exp + (1 | subj), 
                    family="binomial", data = lmer.data.e1and2)

e1and2.lm2 <- glmer(prop ~ age + exp + trial.type + (1 | subj),
                    family="binomial", data = lmer.data.e1and2)

anova(e1and2.lm1,e1and2.lm2)

e1and2.lm3 <- glmer(prop ~ age + exp + trial.type + Familiar + (1 | subj),
                    family="binomial", data = lmer.data.e1and2)

anova(e1and2.lm2,e1and2.lm3)

#Model reported in Table 1
e1and2.lm4 <- glmer(prop ~ age + exp*trial.type + Familiar + (1 | subj), 
                    family="binomial", data = lmer.data.e1and2)

anova(e1and2.lm3,e1and2.lm4)

###############################################################################
################################# PAPER TABLES ################################
###############################################################################
#TABLE 1
e1and2.tab <- as.data.frame(summary(e1and2.lm4)$coef)
e1and2.tab$Predictor <- c("Intercept","Age(years)","NonSalient",
                          "Salient","Learning","ME","Familiar",
                          "Non-Salient*Learning","Salient*Learning",
                          "Non-Salient*ME","Salient*ME")
e1and2.tab <- e1and2.tab[c(1,2,7,4,3,5,6,9,8,11,10),]
rownames(e1and2.tab) <- NULL
e1and2.tab <- e1and2.tab[,c(5,1:4)]
e1and2.tab$stars <- sapply(e1and2.tab[,5],getstars)
names(e1and2.tab)[6] <- ""

names(e1and2.tab)[4:5] <- c("$z$ value","$p$ value")

print(xtable(e1and2.tab,
             align = c("l","l","r","r","r","r","l"),
             label = "tab:model_table"),
      include.rownames=FALSE,hline.after=c(0,nrow(e1and2.tab)),
      sanitize.text.function=function(x){x})