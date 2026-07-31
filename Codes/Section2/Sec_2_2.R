# url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
url <- "dataset/abalone.data"
abalone <- read.csv(
  url,
  header = FALSE,
  col.names = c(
    "Sex",
    "Length",
    "Diameter",
    "Height",
    "Whole_weight",
    "Shucked_weight",
    "Viscera_weight",
    "Shell_weight",
    "Rings"
  )
)


abalone$Sex <- factor(abalone$Sex, levels = c("M", "F", "I"), labels = c("Male", "Female", "Infant"))
abalone$Age <- abalone$Rings + 1.5

# install.packages("corrplot","ggplot2","plotly")
library(corrplot)
library(ggplot2)
library(plotly)


sex_table <- table(abalone$Sex)

barplot(
  sex_table,
  main = "Frequency of Abalone by Sex",
  xlab = "Sex Group",
  ylab = "Count",
  col = c("royalblue", "hotpink", "chartreuse4"),
  border = "black",
  ylim = c(0, 1800)
)


boxplot(
  Whole_weight ~ Sex,
  data = abalone,
  main = "Abalone Whole Weight by Sex",
  xlab = "Sex Category",
  ylab = "Whole Weight (g)",
  col = c("skyblue", "pink", "lightgreen"),
  border = "darkgray",
  notch = TRUE
)


plot(
  x = abalone$Length,
  y = abalone$Whole_weight,
  main = "Shell Length vs. Whole Weight in Abalone",
  xlab = "Length (mm)",
  ylab = "Whole Weight (g)",
  col = adjustcolor("darkblue", alpha.f = 0.3),
  pch = 19,
  cex = 0.8
)

abline(
  lm(Whole_weight ~ Length, data = abalone),
  col = "red",
  lwd = 2
)


sex_percent <- round(100 * prop.table(sex_table), 1)
labels_pie <- paste(names(sex_table), "-", sex_percent, "%", sep = "")

pie(
  sex_table,
  labels = labels_pie,
  col = c("deepskyblue", "magenta", "orange"),
  main = "Proportion of Sex Groups in Abalone Dataset"
)


hist(
  abalone$Rings,
  prob = TRUE,
  breaks = 20,
  main = "Distribution of Abalone Rings with Normal Curve",
  xlab = "Number of Rings",
  col = "lightgray",
  border = "white",
  xlim = c(0, 30)
)

x_seq <- seq(min(abalone$Rings), max(abalone$Rings), length = 100)
y_normal <- dnorm(x_seq, mean = mean(abalone$Rings), sd = sd(abalone$Rings))

lines(x_seq, y_normal, col = "red", lwd = 2.5)

biometric_data <- abalone[, c("Length", "Diameter", "Height", "Whole_weight", "Rings")]

pairs(
  biometric_data,
  col = adjustcolor("darkcyan", alpha.f = 0.2),
  pch = 19,
  main = "Scatter Plot Matrix of Biometric Variables"
)

cor_matrix <- cor(biometric_data)

corrplot(
  cor_matrix,
  method = "ellipse",
  type = "upper",
  order = "hclust",
  tl.col = "black",
  tl.srt = 45,
  addCoef.col = "black"
)


age_trend <- aggregate(Whole_weight ~ Rings, data = abalone, mean)

plot(
  age_trend$Rings,
  age_trend$Whole_weight,
  type = "o",
  pch = 16,
  col = "darkred",
  lwd = 2,
  main = "Mean Whole Weight Trend by Abalone Age Group (Rings)",
  xlab = "Rings (Indicator of Age)",
  ylab = "Mean Whole Weight (g)"
)


agg_data <- aggregate(Whole_weight ~ Sex, data = abalone, function(x) c(mean = mean(x), sd = sd(x)))
agg_df <- data.frame(Sex = agg_data$Sex, Mean = agg_data$Whole_weight[, 1], SD = agg_data$Whole_weight[, 2])

bp <- barplot(
  agg_df$Mean,
  names.arg = agg_df$Sex,
  col = c("lightblue", "lightpink", "lightyellow"),
  ylim = c(0, 1.8),
  main = "Mean Whole Weight (±SD) by Sex",
  xlab = "Sex Group",
  ylab = "Mean Weight (g)"
)

arrows(
  x0 = bp,
  y0 = agg_df$Mean - agg_df$SD,
  x1 = bp,
  y1 = agg_df$Mean + agg_df$SD,
  angle = 90,
  code = 3,
  length = 0.1,
  lwd = 1.5
)


ggplot(abalone, aes(x = Length, y = Whole_weight, color = Sex)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE, lwd = 1.2) +
  theme_classic() +
  labs(
    title = "Abalone Growth: Length vs. Whole Weight",
    x = "Length (mm)",
    y = "Whole Weight (g)"
  )
