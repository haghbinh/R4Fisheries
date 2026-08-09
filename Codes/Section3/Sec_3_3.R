shrimp_growth <- data.frame(
  temperature = c(27.1, 28.0, 28.5, 29.2, 30.0, 30.5, 31.0, 31.5, 32.0, 32.5,
                  27.8, 28.6, 29.4, 30.2, 31.1, 31.8, 32.3, 29.8, 30.7, 28.9),
  salinity = c(22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
               23, 24, 25, 26, 27, 28, 29, 25, 27, 24),
  dissolved_oxygen = c(6.8, 6.7, 6.5, 6.4, 6.2, 6.1, 5.9, 5.8, 5.7, 5.5,
                       6.6, 6.5, 6.3, 6.1, 5.9, 5.8, 5.6, 6.2, 6.0, 6.4),
  length = c(8.1, 8.4, 8.7, 9.0, 9.2, 9.5, 9.7, 9.9, 10.0, 10.2,
             8.3, 8.6, 8.9, 9.3, 9.6, 9.8, 10.1, 9.1, 9.4, 8.8),
  weight = c(9.8, 10.5, 11.2, 12.1, 12.8, 13.4, 14.0, 14.5, 14.9, 15.3,
             10.3, 11.0, 11.9, 12.9, 13.8, 14.4, 15.1, 12.4, 13.2, 11.5)
)

head(shrimp_growth)

#===============================================================

plot(shrimp_growth$length, shrimp_growth$weight,
     xlab = "Length",
     ylab = "Weight",
     pch = 19,
     col = "blue")

abline(lm(weight ~ length, data = shrimp_growth),
       col = "red",
       lwd = 2)

#===============================================================


cor.test(shrimp_growth$length, shrimp_growth$weight,
         method = "pearson")
#===============================================================

plot(shrimp_growth$salinity, shrimp_growth$weight,
     xlab = "Salinity",
     ylab = "Weight",
     pch = 19,
     col = "darkgreen")

#===============================================================

cor.test(shrimp_growth$salinity, shrimp_growth$weight, method = "spearman")
#===============================================================

cor(shrimp_growth)
round(cor(shrimp_growth), 2)
#===============================================================

pairs(shrimp_growth,
      pch = 19,
      col = "blue")
#===============================================================

model_simple <- lm(weight ~ length, data = shrimp_growth)

summary(model_simple)

#===============================================================

plot(shrimp_growth$length, shrimp_growth$weight,
     xlab = "Length",
     ylab = "Weight",
     pch = 19,
     col = "blue")

abline(model_simple,
       col = "red",
       lwd = 2)
#===============================================================

par(mfrow = c(2, 2))
plot(model_simple)
par(mfrow = c(1, 1))
#===============================================================

shapiro.test(residuals(model_simple))
#===============================================================

hist(residuals(model_simple),
     xlab = "Residuals",
     main = "Histogram of residuals",
     col = "gray80")
#===============================================================

qqnorm(residuals(model_simple))
qqline(residuals(model_simple), col = "red", lwd = 2)
#===============================================================

#===============================================================
model_multiple <- lm(weight ~ temperature + salinity + dissolved_oxygen,
                     data = shrimp_growth)

summary(model_multiple)
#===============================================================

new_shrimp <- data.frame(
  length = c(9.5)
)

predict(model_simple, newdata = new_shrimp)
#===============================================================

predict(model_simple, newdata = new_shrimp,
        interval = "confidence")
#===============================================================

predict(model_simple, newdata = new_shrimp,
        interval = "prediction")
#===============================================================

model_temp <- lm(weight ~ temperature, data = shrimp_growth)

model_temp_sal <- lm(weight ~ temperature + salinity, data = shrimp_growth)

anova(model_temp, model_temp_sal)

#===============================================================
#===============================================================
#===============================================================
#===============================================================
#===============================================================
#===============================================================
