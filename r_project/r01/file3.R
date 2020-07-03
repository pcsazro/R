install.packages('readxl')
library(readxl)

csv.file <- read.csv('score.csv')
csv.file
str(csv.file)

excel.file <- read_xlsx('E:/cjs/r_project/r01/score.xlsx')
excel.file
str(excel.file)


english <- c(90,80,70,60)
math <- c(50,60,100,20)
df_midterm <- data.frame(english,math)
write.csv(df_midterm, file = 'df_midterm.csv')

install.packages('xlsx')
library(xlsx)

write.xlsx(df_midterm,'df_midterm.xlsx')


library(ggplot2)
View(mpg)
str(mpg)

str(df_midterm_input1)

df_midterm_input2

read_excel('df_midterm.xlsx')

air <- read.csv('Measurement_summary.csv')
View(Measurement_summary)

qplot(data = Measurement_summary, x=Address, y=PM10)
