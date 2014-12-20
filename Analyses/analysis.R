library(ggplot2)
library(plyr)
library(reshape2)
source("~/Dropbox/Work/Grad_school/Research/Utilities/summarySE.R")

style <- read.csv("~/Dropbox/Work/Grad_school/Research/Computational poetics/Data/allFeatures.csv")
style$Type <- factor(style$Type, levels=c("19th", "Poet", "Amateur"),
                          labels=c("19th century professional", "Contemporary professional", "Contemporary amateur"))
style$imagist <- factor(style$imagist, levels=c(0, 1), labels=c("no", "yes"))
items <- style[,1:6]
measures <- scale(style[,7:ncol(style)])
style.z <- cbind(items, measures)

#############
# Subset into categories
#############

style.19 <- subset(style, Type=="19th century professional")
style.21 <- subset(style, Type=="Contemporary professional")
style.21a <- subset(style, Type=="Contemporary amateur")

#############
# Poem length
#############

mean(style.19$numWords)
min(style.19$numWords)
max(style.19$numWords)

mean(style.21$numWords)
min(style.21$numWords)
max(style.21$numWords)

mean(style.21a$numWords)
min(style.21a$numWords)
max(style.21a$numWords)

################
# Z score
################
items <- style[,1:6]
measures <- scale(style[,7:ncol(style)])
style.z <- cbind(items, measures)
style <- style.z

#############
# Subset into categories
#############

style.19 <- subset(style, Type=="19th century professional")
style.21 <- subset(style, Type=="Contemporary professional")
style.21a <- subset(style, Type=="Contemporary amateur")


##############
# Compare 19th century imagists to non
##############
ggplot(style.19, aes(x=year, y=perfectEndRhymeFreq, color=imagist)) +
  geom_point() +
  theme_bw()

with(style.19, cor.test(year, concreteness))
with(style.19, cor.test(year, perfectEndRhymeFreq))
with(style, cor.test(year, concreteness))

style.19.non <- subset(style.19, imagist=="no")
style.19.imagist <- subset(style.19, imagist=="yes")

style.19.non.sample <- style.19.non[sample(nrow(style.19.non), nrow(style.19.imagist)),]
style.19.non.imagist <- rbind(style.19.non.sample, style.19.imagist)

style.19.summary <- summarySE(style.19.non.imagist, measurevar="concreteness", groupvars=c("imagist"))
colnames(style.19.summary)[3] <- "measure"

ggplot(style.19.summary, aes(x=imagist, y=measure, fill=imagist)) +
  geom_bar(color="black", stat="identity") +
  geom_errorbar(aes(ymin=measure-se, ymax=measure+se), width=0.2) +
  theme_bw()

t.test(style.19.non$concreteness, style.19.imagist$concreteness)

###################
# Compare professionals
###################
style.prof <- rbind(style.19, style.21)

style.prof.long <- melt(data=style.prof, id.vars=c("Type", "Poem.poet", "year", "imagist", "time", "expertise"),
                   measure.vars=c(#"wordLength", 
                                  #"wordFreq",
                                  "alliterationFreq", 
                                  "assonanceFreq", 
                                  #"consonanceFreq",
                                  "slantEndRhymeFreq", 
                                  "perfectEndRhymeFreq" 
                                  #"identityEndRhymeFreq"
                                  #"emotWords",
                                  #"valence", 
                                  #"arousal", 
                                  #"typeTokenRatio",
                                  #"concreteness", 
                                  #"imageability" 
                                  #"objectWords", 
                                  #"abstractWords",
                                  ))

ggplot(style.prof.long, aes(x=year, y=value, color=Type, shape=imagist)) +
  geom_point(size=3) +
  facet_grid(variable ~.) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("Concreteness (z-scored)")

t.test(style.19.non$concreteness, style.19.imagist$concreteness)
t.test(style.19$concreteness, style.21$concreteness)
t.test(style.19.imagist$concreteness, style.21$concreteness)
with(style.prof, cor.test(year, concreteness))
with(style.19, cor.test(year, concreteness))
with(style.21, cor.test(year, concreteness))

ggplot(style.prof, aes(x=year, y=imageability, color=Type, shape=imagist)) +
  geom_point(size=3) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("End rhyme frequency (z-scored)")

t.test(style.19.non$imageability, style.19.imagist$imageability)
t.test(style.19$imageability, style.21$imageability)
t.test(style.19.imagist$imageability, style.21$imageability)
with(style.prof, cor.test(year, imageability))
with(style.19, cor.test(year, imageability))
with(style.21, cor.test(year, imageability))

ggplot(style.prof, aes(x=year, y=objectWords, color=Type, shape=imagist)) +
  geom_point(size=3) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("End rhyme frequency (z-scored)")

t.test(style.19.non$objectWords, style.19.imagist$objectWords)
t.test(style.19$objectWords, style.21$objectWords)
t.test(style.19.imagist$objectWords, style.21$objectWords)
with(style.prof, cor.test(year, objectWords))
with(style.19, cor.test(year, objectWords))
with(style.21, cor.test(year, objectWords))

ggplot(style.prof, aes(x=year, y=perfectEndRhymeFreq, color=Type, shape=imagist)) +
  geom_point(size=3) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("End rhyme frequency (z-scored)")

t.test(style.19.non$perfectEndRhymeFreq, style.19.imagist$perfectEndRhymeFreq)
t.test(style.19$perfectEndRhymeFreq, style.21$perfectEndRhymeFreq)
t.test(style.19.imagist$perfectEndRhymeFreq, style.21$perfectEndRhymeFreq)
with(style.prof, cor.test(year, perfectEndRhymeFreq))
with(style.19, cor.test(year, perfectEndRhymeFreq))
with(style.21, cor.test(year, perfectEndRhymeFreq))

ggplot(style.prof, aes(x=year, y=slantEndRhymeFreq, color=Type, shape=imagist)) +
  geom_point(size=3) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("End rhyme frequency (z-scored)")

t.test(style.19.non$slantEndRhymeFreq, style.19.imagist$slantEndRhymeFreq)
t.test(style.19$slantEndRhymeFreq, style.21$slantEndRhymeFreq)
t.test(style.19.imagist$slantEndRhymeFreq, style.21$slantEndRhymeFreq)
with(style.prof, cor.test(year, slantEndRhymeFreq))
with(style.19, cor.test(year, slantEndRhymeFreq))
with(style.21, cor.test(year, slantEndRhymeFreq))

ggplot(style.prof, aes(x=year, y=arousal, color=Type, shape=imagist)) +
  geom_point(size=3) +
  theme_bw() +
  scale_shape_manual(values=c(1, 17), labels=c("Other", "Imagist"), name="") +
  scale_color_manual(values=c("#023858", "#fb9a99"), labels=c("19th", "Contemporary"), name="") +
  xlab("Year born") +
  ylab("End rhyme frequency (z-scored)")

t.test(style.19.non$arousal, style.19.imagist$arousal)
t.test(style.19$arousal, style.21$arousal)
t.test(style.19.imagist$arousal, style.21$arousal)
with(style.prof, cor.test(year, arousal))
with(style.19, cor.test(year, arousal))
with(style.21, cor.test(year, arousal))

########################################
# Compare 19th to modern professionals and amateurs
########################################

measure.summary <- summarySE(style, measurevar="perfectEndRhymeFreq", groupvars=c("time", "expertise"))
colnames(measure.summary)[4] <- "measure"
# for plotting purposes
dummy <- measure.summary[1,]
dummy$expertise <- "amateur"
measure.summary <- rbind(measure.summary, dummy)

ggplot(measure.summary, aes(x=time, y=measure, shape=expertise, color=time)) +
  geom_line(aes(group=expertise, linetype=expertise), color="gray", size=1) +
  geom_point(size=6) +
  geom_errorbar(aes(ymin=measure-se, ymax=measure+se), width=0.05) +
  theme_bw() +
  ylab("Slant end rhyme (z-scored)") +
  xlab("Time period") +
  scale_shape_manual(values=c(10, 19), name="Expertise") +
  scale_linetype_manual(values=c(3, 2), guide=FALSE) +
  scale_color_manual(values=c("#023858", "#fb9a99"), guide=FALSE)


###########################
# Remove amateur
###########################
style.noAmateur <- subset(style, Type!="Contemporary amateur")
items <- style.noAmateur[,1:4]
#measures.norm <- apply(measures, 2, function(x) (x - min(x))/(max(x) - min(x)))

measures <- scale(style.noAmateur[,5:ncol(style.noAmateur)])
###########################
# Keep amateur
###########################
items <- style[,1:2]
measures <- scale(style[,3:ncol(style)])

############################
# Create z scored data frame
############################
style.z <- cbind(items, measures)

#style.z <- style

style.z$complexSound <- style.z$assonanceFreq + style.z$consonanceFreq + style.z$slantEndRhymeFreq
style.z$simpleSound <- style.z$alliterationFreq + style.z$perfectEndRhymeFreq + style.z$identityEndRhymeFreq


style.long <- melt(data=style.z, id.vars=c("Type", "Poem.poet"),
                   measure.vars=c("wordLength", 
                                  #"wordFreq",
                                              "alliterationFreq", "assonanceFreq", "consonanceFreq",
                                  "slantEndRhymeFreq", "perfectEndRhymeFreq", 
                                  #"identityEndRhymeFreq",
                                              "valence", "arousal", "typeTokenRatio",
                                              "concreteness", "imageability", "objectWords", 
                                  "abstractWords", "emotWords"))

style.long$featureType <- ifelse(
                               style.long$variable=="typeTokenRatio"|style.long$variable=="wordFreq"|
                                 style.long$variable=="wordLength"|style.long$variable=="wordFreqInc",
                             "Diction", 
                             ifelse(style.long$variable=="objectWords"|style.long$variable=="abstractWords"|
                                      style.long$variable=="concreteness"|style.long$variable=="imageability", "Concrete imagery", 
                                    ifelse(style.long$variable=="valence"|style.long$variable=="arousal"|style.long$variable=="emotWords",
                                           "Emotional language", "Sound devices")))

style.long$featureType <- factor(style.long$featureType, levels=c("Concrete imagery",
                                                                  "Emotional language",
                                                                  "Sound devices",
                                                                  "Diction"))

style.long$variable <- factor(style.long$variable, levels=c("objectWords",
                                                            "abstractWords",
                                                            "imageability",
                                                            "concreteness",
                                                            "emotWords",
                                                            "valence",
                                                            "arousal",
                                                            #"identityEndRhymeFreq",
                                                            "perfectEndRhymeFreq",
                                                            "alliterationFreq",
                                                            "slantEndRhymeFreq",
                                                            "consonanceFreq",
                                                            "assonanceFreq",
                                                            "wordLength",
                                                            
                                                            #"wordFreq",
                                                            "typeTokenRatio"
                                                            ),
                              labels=c("Object", "Abstract", "Imageability", "Concreteness",
                                       "Emotion", "Valence", "Arousal",
                                       #"IdentityEndRhyme", 
                                       "PerfectEndRhyme", "Alliteration",
                                       "SlantEndRhyme", "Consonance", "Assonance",
                                       "WordLength", 
                                       #"WordFreq", 
                                       "TypeTokenRatio"))

my.colors <- c("#756bb1", "#9ebcda", "#e7e1ef")

################
# Box plot
################
ggplot(style.long, aes(x=variable, y=value, color=Type)) +
  #geom_jitter(size=2) +
  geom_boxplot() +
  facet_grid(.~featureType, scales="free", space="free") +
  theme_bw() +
  #scale_x_discrete(limits=c("objectWords", "abstractWords", "imageability", "concreteness")) +
  xlab("") +
  ylab("Score") +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank(),
        axis.text.x  = element_text(angle=90, vjust=0.5, hjust=1, size=16),
        axis.text.y = element_text(size=14), axis.title.y = element_text(size=16),
        strip.text.x = element_text(size=16),
        legend.title = element_text(size=0), legend.text = element_text(size=14),
        legend.position = "top") +
  #scale_color_manual(name="Poet", values=my.colors)


style.long.summary <- summarySE(style.long, groupvars=c("Type", "variable", "featureType"),
                                measurevar="value")

#style.long.summary.sound <- subset(style.long.summary, featureType=="sound")
#style.long.summary.image <- subset(style.long.summary, featureType=="image")
#style.long.summary.readability <-subset(style.long.summary, featureType=="readability")
#style.long.summary.emotion <- subset(style.long.summary, featureType=="emotion")


style.long.summary$valueBoost <- style.long.summary$value + 1

ggplot(style.long.summary, aes(x=variable, y=valueBoost, fill=Type)) +
  geom_bar(stat="identity", color="black", position="dodge") +
  geom_errorbar(aes(ymin=valueBoost-se, ymax=valueBoost+se), width=0.2, position=position_dodge(0.9)) +
  facet_grid(.~featureType, scales="free", space="free") +
  theme_bw() +
  #scale_x_discrete(limits=c("objectWords", "abstractWords", "imageability", "concreteness")) +
  xlab("") +
  ylab("Score") +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank(),
        axis.text.x  = element_text(angle=90, vjust=0.5, hjust=1, size=16),
        axis.text.y = element_text(size=14), axis.title.y = element_text(size=16),
        strip.text.x = element_text(size=16),
        legend.title = element_text(size=0), legend.text = element_text(size=14),
        legend.position = "top") +
  scale_fill_manual(name="Poet", values=my.colors)

# ggplot(style.long.summary.image, aes(x=Type, y=value, fill=Type)) +
#   geom_bar(stat="identity", color="black") +
#   geom_errorbar(aes(ymin=value-se, ymax=value+se), width=0.2) +
#   facet_grid(.~variable, scales="free_y") +
#   theme_bw() +
#   xlab("") +
#   ylab("Score") +
#   scale_x_discrete(labels="", breaks=NULL) +
#   theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
#   scale_fill_manual(name="Poet", values=my.colors)
# 
# ggplot(style.long.summary.image, aes(x=variable, y=value, fill=Type)) +
#   geom_bar(stat="identity", color="black", position="dodge") +
#   geom_errorbar(aes(ymin=value-se, ymax=value+se), width=0.2, position=position_dodge(0.9)) +
#   #facet_grid(.~variable, scales="free_y") +
#   theme_bw() +
#   scale_x_discrete(limits=c("objectWords", "abstractWords", "imageability", "concreteness")) +
#   xlab("") +
#   ylab("Score") +
#   theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
#   scale_fill_manual(name="Poet", values=my.colors)
# 
# ggplot(style.long.summary.sound, aes(x=Type, y=value, fill=Type)) +
#   geom_bar(stat="identity", color="black") +
#   geom_errorbar(aes(ymin=value-se, ymax=value+se), width=0.2) +
#   facet_grid(.~variable, scales="free_y") +
#   theme_bw() +
#   xlab("") +
#   ylab("Measure (z-scored)") +
#   scale_x_discrete(labels="", breaks=NULL) +
#   theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
#   scale_fill_manual(name="Poet", values=my.colors)
# 
# ggplot(style.long.summary.emotion, aes(x=Type, y=value, fill=Type)) +
#   geom_bar(stat="identity", color="black") +
#   geom_errorbar(aes(ymin=value-se, ymax=value+se), width=0.2) +
#   facet_grid(.~variable, scales="free_y") +
#   theme_bw() +
#   xlab("") +
#   ylab("Measure (z-scored)") +
#   scale_x_discrete(labels="", breaks=NULL) +
#   theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
#   scale_fill_manual(name="Poet", values=my.colors)
# 
# ggplot(style.long.summary.readability, aes(x=Type, y=value, fill=Type)) +
#   geom_bar(stat="identity", color="black") +
#   geom_errorbar(aes(ymin=value-se, ymax=value+se), width=0.2) +
#   facet_grid(.~variable, scales="free_y") +
#   theme_bw()  +
#   xlab("") +
#   ylab("Measure (z-scored)") +
#   scale_x_discrete(labels="", breaks=NULL) +
#   theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
#   scale_fill_manual(name="Poet", values=my.colors)

style.image <- subset(style.long, featureType=="image")
style.sound <- subset(style.long, featureType=="sound")
style.emotion <- subset(style.long, featureType=="emotion")
style.readability <- subset(style.long, featureType=="readability")

with(subset(style.long, variable=="concreteness"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="imageability"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="objectWords"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="abstractWords"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="simpleSound"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="complexSound"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="valence"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="arousal"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="wordCount"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="avgWordLength"), pairwise.t.test(value, Type, p.adj = "none"))
with(subset(style.long, variable=="typeTokenRatio"), pacfirwise.t.test(value, Type, p.adj = "none"))

################
# compare concreteness and imageability
################

concrete.d <- read.csv("../Materials/Concreteness_ratings_Brysbaert_et_al_BRM.csv")

image.d <- read.delim("../Materials/imageability_mrc2.txt", header=FALSE, sep="\t")
colnames(image.d) <- c("Word", "Imageability")
image.d$Word <- tolower(image.d$Word)

concrete.image.join <- join(concrete.d, image.d, by=c("Word"))
concrete.image.join.noNA <- concrete.image.join[complete.cases(concrete.image.join),]

concrete.image.lm <- lm(data=concrete.image.join.noNA, Conc.M ~ Imageability)
concrete.image.join.noNA$resid <- residuals(concrete.image.lm)
concrete.image.join.noNA <- concrete.image.join.noNA[with(concrete.image.join.noNA, 
                                                          order(-abs(resid))), ]

words <- read.csv("../Data/wordOccurrences.csv")

words.merge <- merge(words, concrete.image.join, by="Word", all.x=TRUE)

words.none <- words.merge[(is.na(words.merge$Conc.M) & is.na(words.merge$Imageability)),]
words.noImage <- words.merge[(!is.na(words.merge$Conc.M) & is.na(words.merge$Imageability)),]
words.noConcrete <- words.merge[(is.na(words.merge$Conc.M) & (!is.na(words.merge$Imageability))),]
words.both <- words.merge[(!is.na(words.merge$Conc.M) & (!is.na(words.merge$Imageability))),]

words.poet <- subset(words.both, contempPoet > 0)
with(words.poet, cor.test(Conc.M, Imageability))
words.19th <- subset(words.both, X19th > 0)
with(words.19th, cor.test(Conc.M, Imageability))
words.amateur <- subset(words.both, contempAmateur > 0)
with(words.amateur, cor.test(Conc.M, Imageability))

sum(words.noImage$contempPoet) / sum(words.merge$contempPoet)
sum(words.noImage$X19th) / sum(words.merge$X19th)
sum(words.noImage$contempAmateur) / sum(words.merge$contempAmateur)

sum(words.noConcrete$contempPoet) / sum(words.merge$contempPoet)
sum(words.noConcrete$X19th) / sum(words.merge$X19th)
sum(words.noImage$contempAmateur) / sum(words.merge$contempAmateur)

#####
# z score measures
####

m.concreteness <- read.csv("../Materials/Concreteness_ratings_Brysbaert_et_al_BRM.csv")
i.concreteness <- data.frame(Word=m.concreteness[,1])
z.concreteness <- scale(m.concreteness[,2:4])
m.concreteness.z <- cbind(i.concreteness, z.concreteness)
write.csv(m.concreteness.z, "../Materials/Concreteness_ratings_Brysbaert_et_al_BRM_zscored.csv", row.names=FALSE)

m.imageability <- read.delim("../Materials/imageability_mrc2.txt", sep="\t", header=FALSE)
i.imageability <- data.frame(Word=m.imageability[,1])
z.imageability <- data.frame(Score=scale(m.imageability[,2]))
m.imageability.z <- cbind(i.imageability, z.imageability)
write.table(m.imageability.z, "../Materials/imageability_mrc2_zscored.txt", sep="\t", col.names=FALSE, row.names=FALSE)

m.valenceArousal <- read.csv("../Materials/Warriner_et_al emot ratings.csv")
i.valenceArousal <- m.valenceArousal[,1:2]
z.valenceArousal <- scale(m.valenceArousal[,3:8])
m.valenceArousal.z <- cbind(i.valenceArousal, z.valenceArousal)
write.csv(m.valenceArousal.z, "../Materials/Warriner_et_al emot ratings_zscored.csv", row.names=FALSE)
