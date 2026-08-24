# جلسه ۳ - بخش 2: آزمون‌های مقایسه میانگین

🎯 **هدف بخش:** در این بخش پژوهشگر یاد می‌گیرد برای مقایسه میانگین یا مقدار مرکزی داده‌ها، بر اساس تعداد گروه‌ها، مستقل یا وابسته بودن مشاهدات، و برقرار بودن مفروضات، آزمون مناسب را انتخاب کند و نتیجه را فقط با تکیه بر `p-value` گزارش دهد.

---

## نقشه انتخاب آزمون

| وضعیت پژوهش | آزمون پارامتری | معادل ناپارامتری |
|---|---|---|
| یک گروه با مقدار مرجع | One-sample t-test | One-sample Wilcoxon signed-rank |
| دو گروه مستقل | Independent samples t-test | Mann-Whitney / Wilcoxon rank-sum |
| دو اندازه‌گیری وابسته | Paired t-test | Paired Wilcoxon signed-rank |
| بیش از دو گروه مستقل | One-way ANOVA | Kruskal-Wallis |
| بیش از دو اندازه‌گیری وابسته | Repeated measures ANOVA | Friedman test |
| دو عامل یا بیشتر | Factorial ANOVA | روش‌های رتبه‌ای یا permutation در تحلیل‌های پیشرفته |

📌 **قاعده تصمیم:** اگر `p-value < 0.05` باشد، فرض صفر رد می‌شود و تفاوت معنی‌دار گزارش می‌شود. اگر `p-value >= 0.05` باشد، شواهد کافی برای تفاوت معنی‌دار وجود ندارد.

---

## داده‌های نمونه برای بخش

```r
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
```

<img src="img/Pasted image 20260809161444.png"  width="600" >

📊 **کاربرد نمودار:** نمودار جعبه‌ای کمک می‌کند تفاوت مرکز داده‌ها، پراکندگی، و داده‌های پرت بین تیمارها قبل از اجرای آزمون‌ها بررسی شود.

---

## بررسی مفروضات عمومی
#### بررسی نرمال بودن با آزمون شاپیرو-ویلک

```r
# by(data, group, function)
by(shrimp$weight_gain, shrimp$treatment, shapiro.test)
```

```
shrimp$treatment: Control

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.97948, p-value = 0.9623

------------------------------------------------- 
shrimp$treatment: Prebiotic

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.96919, p-value = 0.8832

------------------------------------------------- 
shrimp$treatment: Probiotic

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.97523, p-value = 0.9347
Shapiro-Wilk normality test
p-value > 0.05

Bartlett test of homogeneity of variances
p-value > 0.05
```

📌 **نتیجه‌گیری:** چون در این مثال `p-value` آزمون‌های مفروضات بزرگ‌تر از ۰.۰۵ است، شواهد جدی علیه نرمال بودن  وجود ندارد.

#### بررسی همگنی واریانس ها با آزمون بارتلت:
```r
bartlett.test(weight_gain ~ treatment, data = shrimp)
```

```
			Bartlett test of homogeneity of variances

data:  weight_gain by treatment
Bartlett's K-squared = 1.277, df = 2, p-value = 0.5281
```

📌 **نتیجه‌گیری:** چون در این مثال `p-value` آزمون‌های مفروضات بزرگ‌تر از ۰.۰۵ است، شواهد جدی علیه همگنی واریانس‌ها وجود ندارد؛ بنابراین استفاده از آزمون‌های پارامتری قابل قبول است.

---

## آزمون یک میانگین با مقدار مرجع

📍 **مثال:** آیا میانگین افزایش وزن میگو در تیمار پروبیوتیک با مقدار هدف ۵ گرم، تفاوت دارد؟

### فرض‌ها

- مشاهدات مستقل باشند.
- متغیر پاسخ کمی باشد.
- داده‌ها در گروه مورد بررسی تقریباً نرمال باشند.

### فرض صفر و فرض مقابل

$$H_0: \mu = 5$$

$$H_1: \mu \ne 5$$

### آزمون پارامتری

```r
probiotic <- subset(shrimp, treatment == "Probiotic")$weight_gain
t.test(probiotic, mu = 5)
```

```
One Sample t-test

data:  probiotic
t = 8.6312, df = 9, p-value = 1.201e-05
alternative hypothesis: true mean is not equal to 5
95 percent confidence interval:
 5.523916 5.896084
sample estimates:
mean of x 
     5.71
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، فرض صفر رد می‌شود. میانگین افزایش وزن در تیمار پروبیوتیک با ۵ گرم تفاوت معنی‌دار دارد.

### معادل ناپارامتری

زمانی استفاده می‌شود که نرمال بودن داده‌ها قابل قبول نباشد.

```r
wilcox.test(probiotic, mu = 5)
```

```
Wilcoxon signed rank exact test

data:  probiotic
V = 55, p-value = 0.001953
alternative hypothesis: true location is not equal to 5
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، مرکز توزیع افزایش وزن در تیمار پروبیوتیک با مقدار ۵ گرم تفاوت معنی‌دار دارد.

---

## آزمون دو گروه مستقل

📍 **مثال:** آیا افزایش وزن میگو بین گروه شاهد و پروبیوتیک متفاوت است؟

### فرض‌ها

- دو گروه مستقل باشند.
- متغیر پاسخ کمی باشد.
- داده‌ها در هر گروه تقریباً نرمال باشند.
- واریانس‌ها در دو گروه تقریباً برابر باشند؛ در صورت نابرابری، از Welch t-test استفاده می‌شود.

### فرض صفر و فرض مقابل

$$H_0: \mu_1 = \mu_2$$

$$H_1: \mu_1 \ne \mu_2$$

### آزمون پارامتری

```r
two_groups <- subset(shrimp, treatment %in% c("Control", "Probiotic"))
t.test(weight_gain ~ treatment, data = two_groups, var.equal = TRUE)
```

```
Two Sample t-test

data:  weight_gain by treatment
t = -8.3748, df = 18, p-value = 1.269e-07
alternative hypothesis: true difference in means between group Control and group Probiotic is not equal to 0
95 percent confidence interval:
 -1.2633719 -0.7566281
sample estimates:
  mean in group Control mean in group Probiotic 
                   4.70                    5.71
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، بین گروه شاهد و پروبیوتیک از نظر افزایش وزن تفاوت معنی‌دار وجود دارد.

### معادل ناپارامتری

آزمون ویلکاک

```r
wilcox.test(weight_gain ~ treatment, data = two_groups)
```

**خروجی خلاصه:**

```
Wilcoxon rank sum exact test

data:  weight_gain by treatment
W = 0, p-value = 1.083e-05
alternative hypothesis: true location shift is not equal to 0
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، توزیع افزایش وزن در دو گروه تفاوت معنی‌دار دارد.

---

## آزمون دو اندازه‌گیری وابسته

📍 **مثال:** وزن ماهی قبل و بعد از دوره تغذیه آزمایشی مقایسه می‌شود.

```r
fish_paired <- data.frame(
  before = c(18.2, 19.1, 17.8, 20.0, 18.7, 19.5, 18.9, 20.3),
  after  = c(20.1, 21.0, 19.4, 22.2, 20.3, 21.1, 20.4, 22.0)
)

boxplot(fish_paired$before, fish_paired$after,
        names = c("Before", "After"),
        ylab = "Weight", col = c("gray80", "lightgreen"))
```

<img src="img/Pasted image 20260809163927.png"  width="600" >

### فرض‌ها

- دو مشاهده مربوط به یک واحد آزمایشی باشند.
- اختلاف‌های `after - before` تقریباً نرمال باشند.
- متغیر پاسخ کمی باشد.

### فرض صفر و فرض مقابل

$$H_0: \mu_d = 0$$

$$H_1: \mu_d \ne 0$$

### آزمون پارامتری

```r
t.test(fish_paired$after, fish_paired$before, paired = TRUE)
```

```
Paired t-test

data:  fish_paired$after and fish_paired$before
t = 21.244, df = 7, p-value = 1.289e-07
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 1.555213 1.944787
sample estimates:
mean difference 
           1.75
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، وزن ماهی بعد از دوره تغذیه نسبت به قبل تفاوت معنی‌دار دارد.

### معادل ناپارامتری

زمانی استفاده می‌شود که اختلاف‌ها نرمال نباشند.

```r
wilcox.test(fish_paired$after, fish_paired$before, paired = TRUE)
```

```
				Wilcoxon signed rank exact test

data:  fish_paired$after and fish_paired$before
V = 36, p-value = 0.007812
alternative hypothesis: true location shift is not equal to 0
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، وزن قبل و بعد تفاوت معنی‌دار دارد.

---

## آزمون بیش از دو گروه مستقل

📍 **مثال:** مقایسه افزایش وزن میگو در سه تیمار شاهد، پروبیوتیک و پری‌بیوتیک.

### فرض‌ها

- گروه‌ها مستقل باشند.
- متغیر پاسخ کمی باشد.
- داده‌ها در هر گروه تقریباً نرمال باشند.
- واریانس گروه‌ها تقریباً همگن باشد.

### فرض صفر و فرض مقابل

$$H_0: \mu_1 = \mu_2 = \mu_3$$

$$H_1: \text{حداقل یک میانگین با بقیه متفاوت است}$$

### آزمون پارامتری: ANOVA یک‌طرفه

```r
model_aov <- aov(weight_gain ~ treatment, data = shrimp)
summary(model_aov)
```

```
            Df Sum Sq Mean Sq F value   Pr(>F)    
treatment    2  5.174  2.5870   42.64 4.41e-09 ***
Residuals   27  1.638  0.0607                     

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، حداقل بین دو تیمار از نظر افزایش وزن تفاوت معنی‌دار وجود دارد.

### مقایسه‌های پس از آزمون

```r
TukeyHSD(model_aov)
```

```
		  Tukey multiple comparisons of means
		    95% family-wise confidence level

Fit: aov(formula = weight_gain ~ treatment, data = shrimp)

$treatment
                    diff       lwr       upr     p adj
Prebiotic-Control   0.61 0.3368886 0.8831114 0.0000210
Probiotic-Control   1.01 0.7368886 1.2831114 0.0000000
Probiotic-Prebiotic 0.40 0.1268886 0.6731114 0.0032305
```

📌 **نتیجه‌گیری:** هر سه مقایسه دو‌به‌دو معنی‌دار هستند؛ بیشترین افزایش وزن مربوط به تیمار پروبیوتیک است.

### معادل ناپارامتری

زمانی استفاده می‌شود که مفروضات ANOVA برقرار نباشد.

```r
kruskal.test(weight_gain ~ treatment, data = shrimp)
```

```
				Kruskal-Wallis rank sum test

data:  weight_gain by treatment
Kruskal-Wallis chi-squared = 22.793, df = 2, p-value =
1.123e-05
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، توزیع افزایش وزن در حداقل دو تیمار تفاوت معنی‌دار دارد.

---

## آزمون بیش از دو اندازه‌گیری وابسته

📍 **مثال:** وزن یک گروه ماهی در سه زمان مختلف ثبت شده است.

```r
fish_time <- data.frame(
  fish_id = factor(1:8),
  week0 = c(12.1, 11.8, 12.5, 13.0, 12.4, 11.9, 12.8, 12.2),
  week4 = c(14.0, 13.6, 14.3, 15.1, 14.2, 13.8, 14.8, 14.1),
  week8 = c(16.2, 15.7, 16.5, 17.4, 16.3, 15.9, 17.0, 16.1)
)

boxplot(fish_time[, c("week0", "week4", "week8")],
        names = c("Week 0", "Week 4", "Week 8"),
        ylab = "Weight", col = c("gray80", "lightblue", "lightgreen"))
```

<img src="img/Pasted image 20260809165144.png"  width="600" >

### فرض‌ها

- اندازه‌گیری‌ها روی واحدهای آزمایشی یکسان انجام شده باشند.
- متغیر پاسخ کمی باشد.
- باقی‌مانده‌ها تقریباً نرمال باشند.
- در تحلیل دقیق‌تر، فرض کرویت نیز باید بررسی شود.

### فرض صفر و فرض مقابل

$$H_0: \mu_{week0} = \mu_{week4} = \mu_{week8}$$

$$H_1: \mu_i \neq \mu_j $$

### آزمون پارامتری: ANOVA با اندازه‌گیری‌های تکراری

```r
fish_long <- reshape(
  fish_time,
  varying = c("week0", "week4", "week8"),
  v.names = "weight",
  timevar = "week",
  times = c("week0", "week4", "week8"),
  direction = "long"
)
```

```
> fish_long
        fish_id  week  weight id
1.week0       1 week0   12.1  1
2.week0       2 week0   11.8  2
3.week0       3 week0   12.5  3
4.week0       4 week0   13.0  4
5.week0       5 week0   12.4  5
6.week0       6 week0   11.9  6
7.week0       7 week0   12.8  7
8.week0       8 week0   12.2  8
1.week4       1 week4   14.0  1
2.week4       2 week4   13.6  2
3.week4       3 week4   14.3  3
4.week4       4 week4   15.1  4
5.week4       5 week4   14.2  5
6.week4       6 week4   13.8  6
7.week4       7 week4   14.8  7
8.week4       8 week4   14.1  8
1.week8       1 week8   16.2  1
2.week8       2 week8   15.7  2
3.week8       3 week8   16.5  3
4.week8       4 week8   17.4  4
5.week8       5 week8   16.3  5
6.week8       6 week8   15.9  6
7.week8       7 week8   17.0  7
8.week8       8 week8   16.1  8
```

```r
model_rm <- aov(weight ~ week + Error(fish_id/week), data = fish_long)
summary(model_rm)
```

```
Error: fish_id
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals  7  5.106  0.7295               

Error: fish_id:week
          Df Sum Sq Mean Sq F value Pr(>F)    
week       2  65.69   32.85    3832 <2e-16 ***
Residuals 14   0.12    0.01                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، وزن ماهی در زمان‌های مختلف تفاوت معنی‌دار دارد.

### معادل ناپارامتری

زمانی استفاده می‌شود که مفروضات اندازه‌گیری تکراری برقرار نباشد.

```r
friedman.test(as.matrix(fish_time[, c("week0", "week4", "week8")]))
```

```
Friedman rank sum test

data:  as.matrix(fish_time[, c("week0", "week4", "week8")])
Friedman chi-squared = 16, df = 2, p-value = 0.0003355
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، حداقل یک زمان از نظر وزن با زمان‌های دیگر تفاوت معنی‌دار دارد.

---


## مثال پایان بخش

🔬 **سناریو:** پژوهشگری اثر سه جیره غذایی را بر افزایش وزن بچه‌ماهی قزل‌آلا بررسی کرده است. برای هر جیره، ۸ ماهی انتخاب شده و افزایش وزن پس از ۸ هفته ثبت شده است.

```r
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
```

**خروجی :**

```
> by(trout$gain, trout$diet, shapiro.test)
trout$diet: Diet_A

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.95747, p-value = 0.7857

------------------------------------------------- 
trout$diet: Diet_B

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.94897, p-value = 0.7009

------------------------------------------------- 
trout$diet: Diet_C

	Shapiro-Wilk normality test

data:  dd[x, ]
W = 0.97099, p-value = 0.9056

> bartlett.test(gain ~ diet, data = trout)
	Bartlett test of homogeneity of variances

data:  gain by diet
Bartlett's K-squared = 1.5672, df = 2, p-value = 0.4568

> model_trout <- aov(gain ~ diet, data = trout)
> summary(model_trout)
            Df Sum Sq Mean Sq F value   Pr(>F)    
diet         2  44.24  22.120   95.34 2.91e-11 ***
Residuals   21   4.87   0.232                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> TukeyHSD(model_trout)
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = gain ~ diet, data = trout)

$diet
                 diff       lwr        upr   p adj
Diet_B-Diet_A  3.3125  2.705435  3.9195648 0.0e+00
Diet_C-Diet_A  1.9125  1.305435  2.5195648 3.0e-07
Diet_C-Diet_B -1.4000 -2.007065 -0.7929352 2.6e-05

> kruskal.test(gain ~ diet, data = trout)
	Kruskal-Wallis rank sum test

data:  gain by diet
Kruskal-Wallis chi-squared = 20.48, df = 2, p-value =
3.571e-05
```

📌 **نتیجه‌گیری:** چون `p-value < 0.05` است، نوع جیره بر افزایش وزن بچه‌ماهی قزل‌آلا اثر معنی‌دار دارد. نتایج مقایسه دو‌به‌دو نشان می‌دهد هر سه جیره از نظر افزایش وزن با یکدیگر تفاوت معنی‌دار دارند و بیشترین افزایش وزن مربوط به `Diet_B` است.

