install.packages("ggiraphExtra")
install.packages('stringi')
install.packages('devtools')
install.packages('mapproj')
install.packages("KoNRP")
devtools::install_github("cardiomoon/kormaps2014")

Sys.setenv(LANG = "en_US.UTF-8")
Sys.setlocale("LC_ALL")

library(file)
library(rJava)
library(ggiraphExtra)
library(kormaps2014)
library(dplyr)
library(ggplot2)
library(stringi)
library(devtools)
library(mapproj)

str(changeCode(korpop1))

View(korpop1)

korpop1

df_korpop1 <- rename(df_korpop1,
                  pop=총인구_명,
                  name = 행정구역별_읍면동)


korpop1$name <- iconv(korpop1$name, 'UTF-8', 'CP949')

ggChoropleth(data = korpop1, # 지도에 표현할 데이터
             aes(fill = pop, # 색깔로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터
             interactive = T) # 인터랙티브

df_korpop1 <- rename(df_korpop1,
                  male=남자_명,
                  female=여자_명)

df_korpop1 <- df_korpop1 %>%  mutate(mvsf = male-female)

ggChoropleth(data=korpop1,
             aes(fill=mvsf,
                 map_id=code,
                 tooltip=name),
             map=kormap1,
             interactive = T)


df_korpop1 <- as.data.frame(korpop1)


df_korpop1 <- rename(df_korpop1,
                  localcount = 내국인_계_명,
                  forecount = 외국인_계_명)

df_korpop1 <- rename(df_korpop1,
                  foreM = 외국인_남자_명,
                  foreF = 외국인_여자_명)

df_korpop1$localcount <- as.numeric(df_korpop1$localcount)
df_korpop1$forecount <- as.numeric(df_korpop1$forecount)

df_korpop1$foreM <- as.numeric(df_korpop1$foreM)
df_korpop1$foreF <- as.numeric(df_korpop1$foreF)

df_korpop1 <- df_korpop1 %>% mutate(totalpop = localcount+forecount)
korpop1$totalpop <- as.numeric(korpop1$totalpop)

df_korpop1 <- df_korpop1 %>% mutate(perfore = (forecount/totalpop)*100)


ggChoropleth(data=df_korpop1,
             aes(fill=perfore,
                 map_id=code,
                 tooltip=name),
             map=kormap1,
             interactive = T)

df_korpop1 <- changeCode(df_korpop1)

df_perfore <- df_korpop1 %>% select(name, perfore)

write.table(df_perfore, file = "perfore.txt", sep = "\t",
            row.names = TRUE, col.names = NA)

df_mvsf <- df_korpop1 %>% select(name, mvsf)

write.table(df_mvsf, file = "mvsf.txt", sep = "\t",
             row.names = TRUE, col.names = NA)
