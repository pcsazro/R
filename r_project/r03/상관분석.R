library(ggplot2)

economics <- as.data.frame(ggplot2::economics)
dim(economics)

cor.test(economics$unemploy, economics$pce)

View(economics)

cor.test(economics$psavert, economics$uempmed)

mtcars
car_cor <- cor(mtcars)
round(car_cor, 2)

install.packages('corrplot')
library(corrplot)
corrplot(car_cor)
corrplot(car_cor, method = "number")
corrplot(car_cor, method = "number", type = "lower", tl.srt = 30, order = "hclust")


cor.test(welfare$age, welfare$mincome)
cor.test(welfare$h1009_6aq4, welfare$mincome)


welfare_expense <- welfare %>% select(h10_pid,h1007_9, h1009_9, h1009_6aq4)
welfare_expense

welfare_insurance <- welfare %>% select(h10_pid,h10_soc8,h10_soc9,h10_soc10)
welfare_insurance

cor(welfare_expense, welfare_insurance)
wel <- welfare_expense %>% left_join(welfare_insurance, by="h10_pid")
head(wel)
wel_cor <- cor(wel)
corrplot(wel_cor, method = "number", type = "lower", tl.srt = 30)
