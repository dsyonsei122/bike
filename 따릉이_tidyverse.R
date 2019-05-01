#데이터를 불러옵니다
bike <- read.csv("C:\\Users\\cwjen_000\\Desktop\\ds프로젝트\\서울특별시 공공자전거 이용정보(시간대별)_2017년_1.csv")


#변수의 이름을 깔끔하게 정리해줍니다
library(tidyverse)

names(bike)<-names(bike) %>% str_remove_all(pattern='X.')
names(bike)<-names(bike)%>% str_replace_all(".$",replacement = "")
names(bike)[11] <- names(bike)[11] %>% str_replace_all(".M.","(M)")
names(bike)[12] <- names(bike)[12] %>% str_replace_all(".분.","(분)")

head(bike)
Sys.setlocale("LC_ALL", "Korean")




#1회 이용자를 셉니다
use1<-bike %>% filter(이용건수==1) %>% nrow()

#1회 이상 이용자를 셉니다
usemore<-bike %>% filter(이용건수>1) %>% nrow()

#전체 사용자 대비 1회 이용자의 비율은 다음과 같습니다
print(x=use1/(use1+usemore)*100)

#새 변수 평균이동거리를 생성해 이를 포함한 새로운 데이터프레임을 bike_df에 저장해줍니다. 
bike_df<-bike %>% 
  mutate(평균이동거리 = `이동거리(M)` / `이용건수` )
head(bike_df)


