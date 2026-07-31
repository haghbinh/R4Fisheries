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

head(abalone)
str(abalone)
abalone$Sex <- factor(abalone$Sex)

abalone$Sex <- factor(abalone$Sex)
str(abalone$Sex)

abalone$Age <- abalone$Rings + 1.5

head(abalone[, c("Sex", "Rings", "Age")])
summary(abalone)
table(abalone$Sex)
prop.table(table(abalone$Sex)) * 100
sex_freq <- data.frame(
  Sex = names(table(abalone$Sex)),
  Frequency = as.vector(table(abalone$Sex)),
  Percent = round(as.vector(prop.table(table(abalone$Sex)) * 100), 2)
)

sex_freq

numeric_vars <- abalone[, c(
  "Length",
  "Diameter",
  "Height",
  "Whole_weight",
  "Shucked_weight",
  "Viscera_weight",
  "Shell_weight",
  "Rings",
  "Age"
)]

head(numeric_vars)

sapply(numeric_vars, mean)
sapply(numeric_vars, median)
sapply(numeric_vars, sd)
sapply(numeric_vars, min)
sapply(numeric_vars, max)

desc_stats <- data.frame(
  Variable = names(numeric_vars),
  Mean = sapply(numeric_vars, mean),
  Median = sapply(numeric_vars, median),
  SD = sapply(numeric_vars, sd),
  Min = sapply(numeric_vars, min),
  Max = sapply(numeric_vars, max)
)

desc_stats

desc_stats_round <- data.frame(
  Variable = names(numeric_vars),
  Mean = round(sapply(numeric_vars, mean), 3),
  Median = round(sapply(numeric_vars, median), 3),
  SD = round(sapply(numeric_vars, sd), 3),
  Min = round(sapply(numeric_vars, min), 3),
  Max = round(sapply(numeric_vars, max), 3)
)

desc_stats_round

aggregate(Whole_weight ~ Sex, data = abalone, mean)
aggregate(Length ~ Sex, data = abalone, mean)
aggregate(Rings ~ Sex, data = abalone, mean)
aggregate(Age ~ Sex, data = abalone, mean)
aggregate(
  Whole_weight ~ Sex,
  data = abalone,
  FUN = function(x) c(
    mean = mean(x),
    sd = sd(x),
    median = median(x),
    min = min(x),
    max = max(x)
  )
)

aggregate(
  cbind(Length, Diameter, Whole_weight, Shell_weight, Rings, Age) ~ Sex,
  data = abalone,
  mean
)

cor(abalone$Length, abalone$Whole_weight)
cor(abalone$Diameter, abalone$Whole_weight)
cor(abalone$Shell_weight, abalone$Rings)
cor(abalone$Shucked_weight, abalone$Rings)
cor(abalone$Shucked_weight, abalone$Rings)
cor_matrix <- cor(numeric_vars)
round(cor_matrix, 3)
age_cor <- cor(numeric_vars, abalone$Age)

age_cor_sorted <- sort(age_cor[, 1], decreasing = TRUE)

age_cor_sorted
colSums(is.na(abalone))

final_desc <- data.frame(
  Variable = names(numeric_vars),
  N = sapply(numeric_vars, length),
  Mean = round(sapply(numeric_vars, mean), 3),
  SD = round(sapply(numeric_vars, sd), 3),
  Median = round(sapply(numeric_vars, median), 3),
  Min = round(sapply(numeric_vars, min), 3),
  Max = round(sapply(numeric_vars, max), 3)
)

rownames(final_desc) <- NULL

final_desc
