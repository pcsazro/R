library(ggplot2)

mpg <-as.data.frame(ggplot2::mpg)
str(mpg)

library(dplyr)

mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)

mpg_test <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv")) %>% 
  group_by(class)

mpg_test

t.test(data = mpg_diff, cty~class, var.eqal = T)


