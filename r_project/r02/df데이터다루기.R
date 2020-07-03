library(ggplot2)
View(mpg)
str(mpg)

mpg <- as.data.frame(mpg)
mpg
str(mpg)

head(mpg,15)
tail(mpg)
dim(mpg)
summary(mpg)

install.packages("dplyr")
library(dplyr)

df_raw <- data.frame(var1 = c(1,2,1), var2=c(2,3,2))
df_raw

df_new <- df_raw
df_new

df_new <- rename(df_new, v2 = var2)

df_new

mpg <- rename(mpg, highway = hwy)
View(mpg)

df <- df_raw

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- (df$var1 + df$var2)/2

mpg_c <- mpg$cty
mpg_h <- mpg$highway
mpg_effi <- data.frame(mpg_c,mpg_h)
mpg_effi

mpg_total <- mpg_effi$mpg_c + mpg_effi$mpg_h
mpg_mean <- (mpg_effi$mpg_c + mpg_effi$mpg_h)/2

mpg_effi$mpg_total <- mpg_effi$mpg_c + mpg_effi$mpg_h
mpg_effi$mpg_mean <- (mpg_effi$mpg_c + mpg_effi$mpg_h)/2
mpg_effi
head(mpg_effi)

summary(mpg_effi$mpg_total)
summary(mpg_effi$mpg_mean)

hist(mpg_total)
hist(mpg_mean)


# conditional
ifelse(mpg_total >= 40, "pass", "fail")
mpg_total.con <- ifelse(mpg_total >= 40, "pass", "fail")
mpg_total.con

table(mpg_total.con)

library(ggplot2)
qplot(mpg_total.con)

summary(mpg_total)

mpg_effi$mpg_grade <- ifelse(mpg_effi$mpg_total >=45, 'A',
                             ifelse(mpg_effi$mpg_total >=35, 'B','C'))
mpg_grade <- ifelse(mpg_effi$mpg_total >=45, 'A',
                    ifelse(mpg_effi$mpg_total >=35, 'B','C'))
mpg_grade

qplot(mpg_grade)


mpg_effi$mpg_grade2 <- ifelse(mpg_effi$mpg_total >=60,'A',
                              ifelse(mpg_effi$mpg_total>40,'B',
                                     ifelse(mpg_effi$mpg_total >=30,'C','D')))
mpg_grade2 <- ifelse(mpg_effi$mpg_total >=60,'A',
                     ifelse(mpg_effi$mpg_total>40,'B',
                            ifelse(mpg_effi$mpg_total >=30,'C','D')))
mpg_grade2
qplot(mpg_grade2)
table(mpg_grade2)


midwest <- as.data.frame(midwest)
dim(midwest)
str(midwest)
head(midwest)
View(midwest)
summary(midwest)

midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)
str(midwest)

midwest$asian_per_total <- (midwest$asian/midwest$total)*100
head(midwest)
hist(midwest$asian_per_total)

asian_mean <- mean(midwest$asian_per_total)
asian_mean
midwest$asian_means <- ifelse(midwest$asian_per_total>asian_mean,'large','small')
midwest

table(midwest$asian_means)
qplot(midwest$asian_means)
