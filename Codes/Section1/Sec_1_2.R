final_weight <- 18.6
species <- "Litopenaeus vannamei"
survived <- TRUE


ls()
rm(final_weight)


shrimp_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
shrimp_weight



fish_length <- c(12.5, 14.3, 13.8, 15.1, 16.0)
fish_length
class(fish_length)


species <- c("Cyprinus carpio", "Oreochromis niloticus", "Oncorhynchus mykiss")
species
class(species)


survival_status <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
survival_status
class(survival_status)


diet <- factor(c("Control", "Probiotic", "Control", "Probiotic", "Synbiotic"))
diet
levels(diet)


protein_level <- factor(c("Low", "Medium", "High", "Medium", "Low"),
                        levels = c("Low", "Medium", "High"))
protein_level



mixed_vector <- c(12.5, "Control", 15.8)
mixed_vector
class(mixed_vector)



days <- seq(0, 60, by = 15)
days

salinity_gradient <- seq(10, 30, length.out = 5)
salinity_gradient

temperature_levels <- seq(32, 24, by = -2)
temperature_levels

rep("Control", 5)

treatment <- rep(c("Control", "Probiotic", "Synbiotic"), times = 3)
treatment

treatment <- rep(c("Control", "Probiotic", "Synbiotic"), each = 3)
treatment

replicate_id <- rep(1:3, times = 3)
replicate_id

treatment <- factor(rep(c("Control", "Probiotic", "Synbiotic"), each = 3))
replicate_id <- rep(1:3, times = 3)

treatment
replicate_id

weights <- scan()  #12.4 13.1 14.8 15.0 13.9
weights

sites <- scan(what = character()) # Station_A Station_B Station_C

Station <- scan("Station.txt", what = character())
Station

weights <- scan("weights.txt")
weights


species <- scan("species.txt", what = character())
species


shrimp_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
shrimp_weight[1]
shrimp_weight[3]
shrimp_weight[c(1, 3, 5)]
shrimp_weight[2:4]
shrimp_weight[-1]
shrimp_weight[-c(2, 4)]

shrimp_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
shrimp_weight > 16
shrimp_weight[shrimp_weight > 16]


temperature <- c(27.5, 28.1, 31.2, 29.4, 32.0, 26.8)
high_temperature <- temperature[temperature > 30]
high_temperature



salinity <- c(12, 18, 25, 30, 8, 15)
low_salinity <- salinity[salinity < 10]
low_salinity


fish_weight <- c(85, 92, 110, 76, 98, 120)
selected_weight <- fish_weight[fish_weight >= 90 & fish_weight <= 110]
selected_weight


dissolved_oxygen <- c(5.8, 4.9, 6.2, 5.1)
names(dissolved_oxygen) <- c("Station_A", "Station_B", "Station_C", "Station_D")
dissolved_oxygen
dissolved_oxygen["Station_B"]


shrimp_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
length(shrimp_weight)
sum(shrimp_weight)
mean(shrimp_weight)
median(shrimp_weight)
min(shrimp_weight)
max(shrimp_weight)
range(shrimp_weight)
var(shrimp_weight)
sd(shrimp_weight)
summary(shrimp_weight)

shrimp_weight <- c(15.2, 16.8, NA, 17.1, 16.3)
shrimp_weight
mean(shrimp_weight)
mean(shrimp_weight, na.rm = TRUE)
sum(shrimp_weight, na.rm = TRUE)
min(shrimp_weight, na.rm = TRUE)
max(shrimp_weight, na.rm = TRUE)
sd(shrimp_weight, na.rm = TRUE)

is.na(shrimp_weight)
shrimp_weight[!is.na(shrimp_weight)]

initial_weight <- c(2.1, 2.3, 2.0, 2.4, 2.2)
final_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)

weight_gain <- final_weight - initial_weight
weight_gain


days <- 60
sgr <- (log(final_weight) - log(initial_weight)) / days * 100
sgr


weight_gain_percent <- (final_weight - initial_weight) / initial_weight * 100
weight_gain_percent

dissolved_oxygen <- c(5.8, 4.9, 6.2, 5.1, 3.8)
oxygen_ok <- dissolved_oxygen >= 5
oxygen_ok

sum(oxygen_ok)

mean(oxygen_ok) * 100

mean_weight <- 16.06
cat("Mean final weight:", mean_weight, "g\n")

mean_weight <- 16.06
sd_weight <- 0.91

cat("Mean final weight:", mean_weight, "g\n",
    "Standard deviation:", sd_weight, "g\n",
    file = "growth_summary.txt")

survival_rate <- 94

cat("Survival rate:", survival_rate, "%\n",
    file = "growth_summary.txt",
    append = TRUE)

initial_weight <- c(2.1, 2.3, 2.0, 2.4, 2.2)
final_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
days <- 60

weight_gain <- final_weight - initial_weight
sgr <- (log(final_weight) - log(initial_weight)) / days * 100

cat("Mean initial weight:", mean(initial_weight), "g\n",
    "Mean final weight:", mean(final_weight), "g\n",
    "Mean weight gain:", mean(weight_gain), "g\n",
    "Mean SGR:", mean(sgr), "% per day\n",
    file = "shrimp_growth_summary.txt")



experiment <- list(
  species = "Litopenaeus vannamei",
  treatment = "Probiotic",
  initial_weight = c(2.1, 2.3, 2.0, 2.4, 2.2),
  final_weight = c(15.2, 16.8, 14.9, 17.1, 16.3),
  days = 60,
  survival_rate = 94
)

experiment

water_quality <- list(
  station = c("Station_A", "Station_B", "Station_C"),
  temperature = c(28.5, 29.1, 27.8),
  salinity = c(18, 22, 20),
  dissolved_oxygen = c(5.8, 4.9, 6.2)
)

water_quality


sample_info <- list("Pond_A", 25, 5.6)
names(sample_info) <- c("pond_id", "salinity", "dissolved_oxygen")
sample_info
names(sample_info)
experiment$species
experiment$final_weight

experiment[["days"]]
experiment[[1]]
experiment$fcr <- 1.45
experiment

feed_intake <- 21.5
weight_gain <- 14.0
experiment$fcr <- feed_intake / weight_gain
experiment$fcr

study <- list(
  metadata = list(
    species = "Litopenaeus vannamei",
    location = "Shrimp farm",
    duration_days = 60
  ),
  growth = list(
    initial_weight = c(2.1, 2.3, 2.0, 2.4, 2.2),
    final_weight = c(15.2, 16.8, 14.9, 17.1, 16.3)
  ),
  water_quality = list(
    temperature = c(28.5, 29.1, 27.8),
    salinity = c(18, 22, 20),
    dissolved_oxygen = c(5.8, 4.9, 6.2)
  )
)

study
study$metadata$species


species <- "Litopenaeus vannamei"
treatment <- "Probiotic"
days <- 60

replicate_id <- 1:5
initial_weight <- c(2.1, 2.3, 2.0, 2.4, 2.2)
final_weight <- c(15.2, 16.8, 14.9, 17.1, 16.3)
initial_number <- c(100, 100, 100, 100, 100)
final_number <- c(94, 96, 91, 95, 94)

weight_gain <- final_weight - initial_weight
sgr <- (log(final_weight) - log(initial_weight)) / days * 100
survival_rate <- final_number / initial_number * 100

mean_initial_weight <- mean(initial_weight)
mean_final_weight <- mean(final_weight)
mean_weight_gain <- mean(weight_gain)
mean_sgr <- mean(sgr)
mean_survival_rate <- mean(survival_rate)

shrimp_trial <- list(
  species = species,
  treatment = treatment,
  days = days,
  replicate_id = replicate_id,
  initial_weight = initial_weight,
  final_weight = final_weight,
  initial_number = initial_number,
  final_number = final_number,
  weight_gain = weight_gain,
  sgr = sgr,
  survival_rate = survival_rate
)

str(shrimp_trial)

cat("Species:", shrimp_trial$species, "\n",
    "Treatment:", shrimp_trial$treatment, "\n",
    "Culture days:", shrimp_trial$days, "\n",
    "Mean initial weight:", mean_initial_weight, "g\n",
    "Mean final weight:", mean_final_weight, "g\n",
    "Mean weight gain:", mean_weight_gain, "g\n",
    "Mean SGR:", mean_sgr, "% per day\n",
    "Mean survival rate:", mean_survival_rate, "%\n",
    file = "shrimp_trial_summary.txt")


