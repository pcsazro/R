english <- c(90,80,70,60)
math <- c(50,60,100,20)

typeof(math)
str(math)

df_midterm <- data.frame(english,math)
df_midterm

class <- c(1,1,2,2)
df_midterm <- data.frame(english,math, class)
df_midterm

df_midterm$english[3]
df_midterm$math

mean(df_midterm$math)

df_midterm[1]
df_midterm[1,]

df_midterm[1:3]

df_midterm[2,]
df_midterm[3:4,]
df_midterm[4,]

df_midterm[2,1:2]
df_midterm[4,2:3]

df_midterm[1:3,2:3]

product <- c('apple', 'berry','melon')
price <- c(1800,1500,3000)
sale <- c(24,38,13)
table <- data.frame(product,price,sale)
table2 <- data.frame(product, price,sale)
table
table2

mean(table[,2])
mean(table[,3])

table[2:3,1:3]

table[c(1,3)]
table[2,]
table[c(1,3),]
table[c(1,3),c(1,3)]
