shrimp_data <- data.frame(
  pond_id = c("P1", "P2", "P3", "P4"),
  treatment = c("Control", "Probiotic", "Control", "Probiotic"),
  initial_weight = c(2.1, 2.3, 2.0, 2.2),
  final_weight = c(15.2, 16.8, 14.9, 16.1),
  survival_rate = c(94, 96, 91, 95)
)
shrimp_data



data.frame(
  pond_id = c("P1", "P2", "P3"),
  final_weight = c(15.2, 16.8)
)
class(shrimp_data)
str(shrimp_data)


shrimp_data <- data.frame(
  pond_id = c("P1", "P2", "P3"),
  salinity = c(18, 20, 22),
  temperature = c(28.5, 29.0, 28.2)
)
names(shrimp_data)


shrimp_data <- data.frame(
  x = c("P1", "P2", "P3"),
  y = c(2.1, 2.3, 2.0),
  z = c(15.2, 16.8, 14.9)
)

names(shrimp_data) <- c("pond_id", "initial_weight", "final_weight")
shrimp_data
names(shrimp_data)[2] <- "weight_initial"
names(shrimp_data)[3] <- "weight_final"


pond_data <- data.frame(
  pond_id = c("P1", "P2", "P3", "P4", "P5"),
  treatment = c("Control", "Control", "Probiotic", "Probiotic", "Probiotic"),
  initial_weight = c(2.0, 2.1, 2.2, 2.3, 2.1),
  final_weight = c(14.8, 15.1, 16.4, 16.9, 16.2),
  temperature = c(28.4, 28.7, 29.1, 28.9, 28.6),
  salinity = c(18, 19, 20, 20, 21),
  dissolved_oxygen = c(5.6, 5.4, 5.9, 5.7, 5.8)
)
pond_data

shrimp_data <- read.table("dataset/shrimp_data.txt", header = TRUE)
shrimp_data


shrimp_data <- read.table("dataset/shrimp_data_t.txt", header = TRUE, sep = "\t")
shrimp_data <- read.table("dataset/shrimp_data.csv", header = TRUE, sep = ",")
shrimp_data <- read.table("dataset/shrimp_data_v.txt", header = TRUE, sep = ";")

str(shrimp_data)
names(shrimp_data)

write.table(pond_data, file = "dataset/spond_data_output.txt")
write.table(pond_data,
            file = "pond_data_output.csv",
            sep = ",",
            row.names = FALSE)


# install.packages("readxl")
library(readxl)
shrimp_data <- read_excel("dataset/shrimp_data.xlsx")
shrimp_data <- read_excel("dataset/shrimp_data.xlsx", sheet = "GrowthData")



pond_data <- data.frame(
  pond_id = c("P1", "P2", "P3", "P4", "P5", "P6"),
  treatment = c("Control", "Control", "Probiotic", "Probiotic", "Synbiotic", "Synbiotic"),
  initial_weight = c(2.0, 2.1, 2.2, 2.3, 2.1, 2.2),
  final_weight = c(14.8, 15.1, 16.4, 16.9, 17.2, 17.0),
  temperature = c(28.4, 28.7, 29.1, 28.9, 29.0, 28.8),
  salinity = c(18, 19, 20, 20, 21, 21),
  dissolved_oxygen = c(5.6, 5.4, 5.9, 5.7, 6.0, 5.8)
)

write.table(pond_data,
            file = "dataset/pond_data_session1.txt",
            sep = "\t",
            row.names = FALSE)

