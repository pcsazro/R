#필요 라이브러리 부착(설치가 없다면 install.package로 설치)
library(dplyr)
library(readxl)

day_care <- read.csv('day_care_center.csv')

#데이터 프레임으로 만들어 가공하여 사용할 예정
df_day_care <- as.data.frame(day_care, stringsAsFactors = F)

#데이터 확인
View(day_care)

#데이터 구조확인
str(day_care)
str(df_day_care)

#각 구에 따른 어린이집 평균 어린이 수 / 내림차순 정렬
df_mean_child <- df_day_care %>% group_by(gu) %>% 
  summarise(mean_children = mean(day_care_baby_num)) %>%
  arrange(desc(mean_children))

#각 구에 따른 어린이집 평균 선생님 수
df_mean_teacher <- df_day_care %>% group_by(gu) %>% 
  summarise(mean_teacher = mean(teacher_num))

#각 구에 따른 평균을 구해 합치기
df_mean <- df_mean_child
df_mean <- left_join(df_mean,df_mean_teacher,by="gu")

#계산을 위해서 NA값을 계산될 값(아이들의 평균수)으로 대체
df_mean$mean_teacher <- ifelse(is.na(df_mean$mean_teacher),df_mean$mean_children,df_mean$mean_teacher)
df_mean <- df_mean %>% mutate(per = df_mean$mean_children%/%df_mean$mean_teacher)

#보기 편하게 이름 변경
df_mean <- rename(df_mean, chidren = mean_children,
                  teacher = mean_teacher)

#누락된 값으로 확인된 값을 제외
df_mean <- df_mean %>% filter(df_mean$per != 1)



#데이터 중 은평구를 뽑아 사용
df_day_care_ep <- day_care %>% filter(gu == '은평구')

#데이터 프레임 구조, 요약
str(df_day_care_ep)
dim(df_day_care_ep)
summary(df_day_care_ep)

#한 구에 어린이집을 다니는 평균 인원수 계산
summarise(df_day_care_ep, mean_child = mean(df_day_care_ep$day_care_baby_num))

#어린이집을 다니는 아이들 수에 따라 정렬
df_day_care_ep <- df_day_care_ep %>% arrange(desc(day_care_baby_num))
# 어린이 수를 많은 순서대로 10개를 뽑아 확인
top_cnum <- head(df_day_care_ep,10)

#선생님 수에 따라 정렬
df_day_care_ep <- df_day_care_ep %>% arrange(desc(teacher_num))
#선생님 수가 많은 순서로 10개를 뽑아 확인
top_tnum <- head(df_day_care_ep,10)

# 그래프를 만들기 위한 라이브러리 부착착
library(ggplot2)

# 구별 어린이집 선생님 1명당 할당된 최소 아이들 수 그래프 out.png
ggplot(data = df_mean,aes(x=reorder(df_mean$gu,df_mean$teacher),
                          y=df_mean$per))+geom_col()+coord_flip()

# 은평구 내 어린이집 중에서 선생님 수가 많은 순서로 반의 개수를 그래프로 표현 out2.png
ggplot(data = top_tnum, 
       aes(x=reorder(top_tnum$day_care_name,top_tnum$teacher_num),
                                  y=top_tnum$nursing_room_num))+geom_col()+coord_flip()
