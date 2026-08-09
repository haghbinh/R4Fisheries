set.seed(123)

shrimp <- data.frame(
  treatment = rep(c("Control", "Probiotic", "Prebiotic"), each = 10),
  weight_gain = c(
    4.2, 4.7, 4.8, 5.0, 4.5, 4.9, 5.1, 4.6, 4.4, 4.8,
    5.4, 5.8, 5.7, 6.0, 5.3, 5.9, 6.1, 5.6, 5.5, 5.8,
    5.0, 5.2, 5.3, 5.5, 5.1, 5.4, 5.6, 5.2, 5.3, 5.5
  )
)

boxplot(weight_gain ~ treatment, data = shrimp,
        xlab = "Treatment", ylab = "Weight gain",
        col = c("gray80", "lightblue", "lightgreen"))

#===============================================================
#by(data, group, function)
by(shrimp$weight_gain, shrimp$treatment, shapiro.test)
#===============================================================
bartlett.test(weight_gain ~ treatment, data = shrimp)
#===============================================================
probiotic <- subset(shrimp, treatment == "Probiotic")$weight_gain
t.test(probiotic, mu = 5)
#===============================================================
wilcox.test(probiotic, mu = 5)
#===============================================================
two_groups <- subset(shrimp, treatment %in% c("Control", "Probiotic"))

t.test(weight_gain ~ treatment, data = two_groups, var.equal = TRUE)
#===============================================================

wilcox.test(weight_gain ~ treatment, data = two_groups)
#===============================================================

fish_paired <- data.frame(
  before = c(18.2, 19.1, 17.8, 20.0, 18.7, 19.5, 18.9, 20.3),
  after  = c(20.1, 21.0, 19.4, 22.2, 20.3, 21.1, 20.4, 22.0)
)

boxplot(fish_paired$before, fish_paired$after,
        names = c("Before", "After"),
        ylab = "Weight", col = c("gray80", "lightgreen"))
#===============================================================

t.test(fish_paired$after, fish_paired$before, paired = TRUE)
#===============================================================

wilcox.test(fish_paired$after, fish_paired$before, paired = TRUE)
#===============================================================

model_aov <- aov(weight_gain ~ treatment, data = shrimp)
summary(model_aov)
#===============================================================

TukeyHSD(model_aov)
#===============================================================

kruskal.test(weight_gain ~ treatment, data = shrimp)
#===============================================================


fish_time <- data.frame(
  fish_id = factor(1:8),
  week0 = c(12.1, 11.8, 12.5, 13.0, 12.4, 11.9, 12.8, 12.2),
  week4 = c(14.0, 13.6, 14.3, 15.1, 14.2, 13.8, 14.8, 14.1),
  week8 = c(16.2, 15.7, 16.5, 17.4, 16.3, 15.9, 17.0, 16.1)
)

boxplot(fish_time[, c("week0", "week4", "week8")],
        names = c("Week 0", "Week 4", "Week 8"),
        ylab = "Weight", col = c("gray80", "lightblue", "lightgreen"))
#===============================================================

fish_long <- reshape(
  fish_time,
  varying = c("week0", "week4", "week8"),
  v.names = "weight",
  timevar = "week",
  times = c("week0", "week4", "week8"),
  direction = "long"
)

model_rm <- aov(weight ~ week + Error(fish_id/week), data = fish_long)
summary(model_rm)
#===============================================================

friedman.test(as.matrix(fish_time[, c("week0", "week4", "week8")]))
#===============================================================

trout <- data.frame(
  diet = rep(c("Diet_A", "Diet_B", "Diet_C"), each = 8),
  gain = c(
    21.8, 22.5, 23.1, 22.0, 21.5, 22.7, 23.0, 22.4,
    25.1, 25.8, 26.2, 24.9, 25.5, 26.0, 25.7, 26.3,
    23.8, 24.2, 24.6, 23.9, 24.4, 24.8, 24.1, 24.5
  )
)

by(trout$gain, trout$diet, shapiro.test)
bartlett.test(gain ~ diet, data = trout)

model_trout <- aov(gain ~ diet, data = trout)
summary(model_trout)
TukeyHSD(model_trout)

kruskal.test(gain ~ diet, data = trout)
#===============================================================

