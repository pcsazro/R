library(dplyr)
exam <- read.csv('exam_csv.csv')
exam
View(exam)

exam %>% filter(class == 1)
exam %>% filter(class != 1)

exam %>% filter(math >50)
exam %>% filter(english >80)

exam %>% filter(english >80 &  class == 2)
exam %>% filter(math >= 50 & english >50 &  class == 3)

exam %>% filter(math >90 | english >90)
exam %>% filter(math >90 | english >90 | science>90)

exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5))

class1 <- exam %>% filter(class == 1)
class1
class2 <- exam %>% filter(class == 2)
class2
mean(class2$math)

str(mpg)

head(mpg)

displ_low <- mpg %>% filter(mpg$displ < 5)
head(displ_low)
displ_high <- mpg %>% filter(mpg$displ >= 5)
head(displ_high)
mean(displ_low$highway)
mean(displ_high$highway)

audi <- mpg %>% filter(mpg$manufacturer == "audi")
head(audi)
toyota <- mpg %>% filter(mpg$manufacturer == "toyota")
head(toyota)
mean(audi$cty)
mean(toyota$cty)

che.for.hon <- mpg %>% filter(mpg$manufacturer %in% c("chevrolet","ford","honda"))
head(che.for.hon)
mean(che.for.hon$highway)

exam %>% filter(class == 1) %>% 
  select(math, english)

exam %>% filter(class == 1) %>% 
  select(-math, -id)

exam %>% select(math)

exam %>% arrange(math)

exam %>% arrange(desc(math))

exam %>% arrange(class, desc(math))

audi %>%
  select(manufacturer, highway) %>% 
  arrange(desc(highway)) %>% 
  head(5)

mpg %>% filter(manufacturer == "audi") %>% 
  select(manufacturer, highway) %>% 
  arrange(desc(highway)) %>% 
  head(5)

exam %>% mutate(total = math + english + science) %>%
  head() %>% arrange(desc(total))

exam %>% mutate(total = math + english + science,
                mean = (math+english+science)/3) %>%arrange(desc(total))
exam %>% mutate(total = math + english + science,
                mean = (math+english+science)/3) %>%
  arrange(desc(total)) %>% head(5)


exam %>% mutate(test2 = ifelse(science > 60,'pass','fail'))


mpg <- as.data.frame(ggplot2::mpg)

mpg <- mpg %>% mutate(EFC = cty+hwy)
head(mpg)

mpg <- mpg %>% mutate(AFC = (cty+hwy)/2)
head(mpg)

mpg %>% select(model, AFC) %>% arrange(desc(AFC)) %>% head()


mpg2 <- mpg %>%
  mutate(EFC = cty+hwy, AFC = (cty+hwy)/2) %>% 
  select(model, EFC, AFC) %>% 
  arrange(desc(AFC)) %>% 
  head(3)
mpg2


mpg %>% group_by(class) %>% 
  summarise(mean_fuel = mean(cty))

mpg %>% group_by(class) %>% 
  summarise(mean_fuel = mean(cty)) %>% 
  arrange(desc(mean_fuel))
  
mpg %>% group_by(manufacturer) %>% 
  summarise(mean_fuel_hwy = mean(hwy)) %>% 
  arrange(desc(mean_fuel_hwy)) %>% 
  head(3)

mpg %>% filter(class == 'compact') %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))


# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

test_total <- left_join(test1, test2, by="id")
test_total


name <- data.frame(id = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
test_total <- left_join(test_total, name, by="id")
test_total

test3 <- data.frame(id = c(6, 7, 8, 9, 10),
                    final = c(71, 82, 64, 96, 100))

new_data2 <- bind_rows(test_total, test3)
new_data2

naTure <- new_data2 %>% filter(is.na(midterm))
naFalse <- new_data2 %>% filter(!is.na(midterm))
mean(naTure$midterm)
mean(naFalse$midterm)

no_na <- na.omit(new_data2)
no_na

mean(new_data2$midterm, na.rm = T) #remove

member <- data.frame(name=c("park","kim","song"), age=c(100,1000,50), score=c(80,90,70))
member$age <-  ifelse(member$age>130,NA,member$age)
member$age <-  ifelse(is.na(member$age),80,member$age)
member

str(member)
