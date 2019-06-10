setwd( "C://Users//cwjen_000//Desktop//ds프로젝트")

#첫번째 데이터- 날씨
Sys.setlocale("LC_ALL", "C")
weather <- read.csv("20186월기상정보.csv")
Sys.setlocale("LC_ALL", "korean")
head(weather)

names(weather)<-c('날짜',	'평균기온(°C)',	'일강수량(mm)',	'평균 풍속(m/s)'	,'평균 상대습도(%)',	'평균 전운량',	'미세먼지농도(㎍/㎥)')
head(weather)

#두번째 데이터-따릉이 사용량
Sys.setlocale("LC_ALL", "C")

#2018년 2분기 3 데이터
bikeuse1 <- read.csv('서울특별시 공공자전거 대여이력 정보_2018년_2분기_3.csv')
Sys.setlocale("LC_ALL", "korean")
head(bikeuse1)

#2018년 2분기 4 데이터
Sys.setlocale("LC_ALL", "C")
bikeuse2 <- read.csv('서울특별시 공공자전거 대여이력 정보_2018년_2분기_4.csv')
Sys.setlocale("LC_ALL", "korean")
head(bikeuse2)

#변수명 제대로 돌려주기
names(bikeuse1)<- c('날짜'	,'대여시',	'대여대여소번호'	,'대여대여소명',	'대여거치대',	'반납일시',	'반납대여소번호',	'반납대여소명'	,'반납거치대',	'이용시간(분)'	,'이용거리(M)'
)
names(bikeuse2)<- c('날짜'	,'대여시',	'대여대여소번호'	,'대여대여소명',	'대여거치대',	'반납일시',	'반납대여소번호',	'반납대여소명'	,'반납거치대',	'이용시간(분)'	,'이용거리(M)'
)



#두 데이터에서 필요한 정보만 bike_6로 합치기
bike_6<-rbind(bikeuse1[,c(1,2)], bikeuse2[,c(1,2)])
bike_6

#날씨정보와 합쳐줍니다.
head(weather)
head(bike_6)              
bike_6<-as.data.frame(lapply(bike_6, gsub, pattern = "\'", replacement = "", fixed = TRUE))




count<-bike_joined %>% group_by(날짜) %>% count()
bike_joined<-inner_join(weather, count)

names(bike_joined)[8]<-c("count")
head(bike_joined)


#일자를 뺀상관관계 분석: 일강수량과 양의 상관관계, 구름량과는 약간의 음의 상관관계
cor_bike_joined<- cor(bike_joined[,-1], use="pairwise.complete.obs")
corrplot.mixed(cor_bike_joined, tl.col="black", tl.pos="lt")

