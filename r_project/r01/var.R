a <- 100
b <- 200
# 실행 : ctrl + enter
a
b

name <- '홍길동'
name

a+b

print(a+b)

c <- a+b
c

a == b
a != b
a > b
a < b

d <- 222
e <- 34

d
e

d / e # 실수까지
d | e 
d %% e # 나머지
d %/% e # 몫

names = c('홍길동','김길동','박길동','송길동')
names
typeof(names) #
str(names)
str(name)
names[1]
length(names)
nchar(names[1])

ages = c(1,3,5,7,11)
ages
typeof(ages)
str(ages)
ages[1]
length(ages[1]) # 2차원 배열의 경우 1번 인덱스에 해당하는 개수 확인 가능

# broad casting #
numbers = c(1:10)
numbers

result1 <- numbers*2
result1

class1 <- c(1:10)
class2 <- c(11:20)
result2 <- class1+class2
result2

max1 <- max(class1)
max2 <- max(class2)
max1 < max2
max1 + max2

slice1 <- class1[1:3]
slice1


addr1 <- c('서울','대구','부산','군산','제주')
addr1

addr1[2] <- '경기'
addr1

addr2 <- addr1
addr2
addr2[3:4]

korean <- c(50:55)
korean

math <- c(60:65)
math

mean(korean)
mean(math)
sum(korean)
sum(math)

korean[1] > math[2]
korean2 <- korean+5
korean2

total <- korean2+math
total
min(total)
max(total)

temp <- 100
temp

