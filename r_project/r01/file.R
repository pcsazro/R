insa <- c('hello','hi','smile')
insa

result1 <- paste(insa, collapse = ', ')
result1

install.packages("ggplot2")
library(ggplot2)

x <- c('a','b','c','d','d','c','e','c')
x
sort(x)

qplot(x)

qplot(data = mpg, x=hwy)
mpg

View(mpg)

manufacturer <- mpg[1]
x <- unique(manufacturer)
mpg$manufacturer

qplot(data=mpg, x = manufacturer, y=hwy)
qplot(data=mpg, x = trans, y=hwy, geom = "line")
qplot(data=mpg, x = manufacturer, y=cty, geom = "boxplot")
qplot(data=mpg, x = class, y=cty, geom = "boxplot")

