initial_weight <- 2.5
final_weight <- 14.8
weight_gain <- final_weight - initial_weight
weight_gain



salinity <- 25
temperature <- 29
survival <- 87.5


days <- c(0, 15, 30, 45, 60)
weight <- c(2.1, 4.8, 8.6, 12.9, 18.5)

plot(days, weight)


# install.packages("ggplot2")
library(ggplot2)

?mean

??anova



values <- c(12.5, 13.2, NA, 14.1)
mean(values)
mean(values, na.rm = TRUE)

species <- "Litopenaeus vannamei"
initial_weight <- 1.8
final_weight <- 16.4
culture_days <- 60

weight_gain <- final_weight - initial_weight
sgr <- (log(final_weight) - log(initial_weight)) / culture_days * 100

species
weight_gain
sgr


temperature <- 28.5
salinity <- 22
ph <- 7.8
dissolved_oxygen <- 5.6


initial_weight <- 2.4
final_weight <- 15.9
weight_gain <- final_weight - initial_weight
weight_gain

fish_length <- 18.6
fish_weight <- 95.4
water_temperature <- 27.8
salinity <- 18.5
class(fish_length)


species <- "Cyprinus carpio"
pond_id <- "Pond_A"
sampling_site <- "Station_1"
class(species)


sample_code <- "101"
class(sample_code)



diet <- factor("Diet_A")
culture_system <- factor("Biofloc")
class(diet)


treatment <- factor(c("Control", "Probiotic", "Prebiotic", "Synbiotic"))
treatment
levels(treatment)


protein_level <- factor(c("Low", "Medium", "High"),
                        levels = c("Low", "Medium", "High"))
protein_level

survived <- TRUE
disease_detected <- FALSE
class(survived)


dissolved_oxygen <- 5.8
oxygen_ok <- dissolved_oxygen >= 5
oxygen_ok

initial_weight <- 4.1
final_weight <- 3.8
growth_positive <- final_weight > initial_weight
growth_positive


weight <- 12.6
species <- "Oreochromis niloticus"
treatment <- factor("Control")
survived <- TRUE

class(weight)
class(species)
class(treatment)
class(survived)

str(weight)
str(species)
str(treatment)
str(survived)

initial_weight <- 2.2
final_weight <- 18.9
weight_gain <- final_weight - initial_weight
weight_gain


initial_weight <- 2.2
final_weight <- 18.9
days <- 60

sgr <- (log(final_weight) - log(initial_weight)) / days * 100
sgr


initial_number <- 500
final_number <- 438

survival_rate <- final_number / initial_number * 100
survival_rate


dissolved_oxygen <- 4.7
oxygen_status <- dissolved_oxygen >= 5
oxygen_status

diet_treatment <- factor("Probiotic")
class(diet_treatment)

species <- "Litopenaeus vannamei"
treatment <- factor("Probiotic")
initial_weight <- 2.3
final_weight <- 17.6
culture_days <- 60
initial_number <- 800
final_number <- 752
dissolved_oxygen <- 5.4

weight_gain <- final_weight - initial_weight
sgr <- (log(final_weight) - log(initial_weight)) / culture_days * 100
survival_rate <- final_number / initial_number * 100
oxygen_ok <- dissolved_oxygen >= 5



