install.packages('foreign')
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = 'Koweps_hpc10_2015_beta1.sav', to.data.frame = T)

welfare <- raw_welfare

head(welfare,1)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare, 
                  gender = h10_g3,
                  birth = h10_g4,
                  marry = h10_g10,
                  religion = h10_g11,
                  job = h10_eco9,
                  mincome = p1002_8aq1,
                  local = h10_reg7)

# 성별은 질적변수 & 명목변수(factor)
class(welfare$gender)
table(welfare$gender)

#이상치(outlier)를 NA(결측치)로 처리
welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)
table(is.na(welfare$gender))

welfare$gender <- ifelse(welfare$gender == 1, "M", "F")
table(welfare$gender)

qplot(welfare$gender)

class(welfare$mincome)
summary(welfare$mincome)
qplot(welfare$mincome) + xlim(0,1000)

income <- welfare %>%
  filter(!is.na(mincome)) %>% 
  group_by(gender) %>%
  summarise(means = mean(mincome))

ggplot(data = income, aes(x=gender, y=means)) + geom_col()


table(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

table(is.na(welfare$birth))

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)

welfare$age <- 2015 - welfare$birth + 1
table(welfare$age)

welfare$age <- ifelse(welfare$age > 100, NA, welfare$age)

table(is.na(welfare$age))

qplot(welfare$age)

age_income <- welfare %>%
  filter(!is.na(mincome)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(mincome))

ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_col()

welfare <- welfare %>%
  mutate(age_group = ifelse(age > 10 & age < 30, 'young',
                            ifelse(age<60, 'middle','old')))
table(welfare$age_group)

qplot(welfare$age_group)

age_group_income <- welfare %>% 
  filter(!is.na(mincome)) %>% 
  group_by(age_group) %>% 
  summarise(means = mean(mincome))

ggplot(data = age_group_income,
       aes(x=age_group, y=means)) + geom_col() + 
       scale_x_discrete(limits = c("young","middle","old"))


age_group_income <- welfare %>% 
  filter(!is.na(mincome)) %>% 
  group_by(age_group, gender) %>% 
  summarise(means = mean(mincome))

ggplot(data = age_group_income,
       aes(x=age_group, y=means, fill=gender)) + geom_col() + 
  scale_x_discrete(limits = c("young","middle","old"))

ggplot(data = age_group_income,
       aes(x=age_group, y=means, fill=gender)) + geom_col(position = "dodge") + 
  scale_x_discrete(limits = c("young","middle","old"))


gen_age_income <- welfare %>%
  filter(!is.na(mincome)) %>% 
  group_by(age, gender) %>%
  summarise(means = mean(mincome))

ggplot(data = gen_age_income, aes(x=age, y=means, col=gender))+geom_line()


list_job <- read_xlsx('Koweps_Codebook.xlsx',col_names = T, sheet = 2)
list_job

welfare <- rename(welfare, code_job = job)

welfare <- left_join(welfare, list_job, id='code_job')


welfare %>% 
  filter(!is.na(job)) %>% 
  select(code_job, job)

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(mincome)) %>% 
  group_by(job) %>% 
  summarise(means = mean(mincome))

job_income <- left_join(job_income, list_job, id="job")

View(job_income)

job_top10 <- job_income %>% 
  arrange(desc(means)) %>% 
  head(10)

View(job_top10)

ggplot(data = job_top10, aes(x=reorder(job, means), y=means))+geom_col()+coord_flip()

