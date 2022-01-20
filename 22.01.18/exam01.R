# 시각화하기!
#ggplot2 패키지 설치
install.packages("ggplot2")
library(ggplot2)
#ggplot2 패키지는 시각화를 손쉽게 해주는 전용 패키지
library(dplyr)

#연습용 데이터
# mpg (1999~2008년 사이 미국에서 출시된 자동차 234종의 연비관련 정보) -> 기본 탑재된 데이터!
mpg
View(mpg)
str(mpg)
#tibble형태의 데이터를 dataframe구조로 변경하는 방법
mpg <- data.frame(mpg)
str(mpg)
#ggplot 3단계 구조
# 1. 축설정 2. 그래프설정 3. 추가설정
# 1단계 축 설정! : ggplot(원본데이터, aes(x = 컬럼명, y = 컬럼명명 ))
# 2단계 그래프 설정! : ggplot(원본데이터, aes(x = 컬럼명, y = 컬럼명명 )) + 설정할 함수
# 3단계 추가설정! : ggplot(원본데이터, aes(x = 컬럼명, y = 컬럼명명 )) + 그래프 설정 + 추가설정
# 실습! : x축은 배기량, y축은 고속도로 연비를 각 위치에 데이터를 산점도로 표현
# geom_point(속성) : 산점도
#xlim(), ylim() : x축의 범위를 설정
#labs(x = "바꾸고싶은 이름", y = "바꾸고 싶은 이름") : 축이름 변경
#theme() : 테마설정
#-> (axis.title.x = element_text(size = 30) : x축의 이름 크기 변경
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(size = 1, color ="purple") + xlim(3,6) + ylim(10,30) + labs(x = "배기량", y = "연비") + 
  theme(axis.title.x = element_text(size = 30), axis.title.y = element_text(size = 30))

#실습! :구동방식(drv) 배기량에 따른 고속도로 연비를 시각화
#color안의 기준점이 범주형인 경우 -> 각각 전혀 다른 색상으로 표현이 된다. 
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point()

#color안의 기준점이 수치형인 경우 -> 각은 색상이지만 명암 정도가 다르다.
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point()

#추세선 그리기!(평균값들의 흐름을 나타낸다.)
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point() + geom_smooth()

#막대그래프 그리기!
#문제! ->> 제조회사별 평균연비 출력 후 막대그래프 출력!
#제조회사별 평균연비 출력
manu_hwy <- mpg %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(hwy))
manu_hwy
#막대그래프!
#reorder() : 축에대한 설정을 다시해준다.
#reorder(원하는 축이 될 컬럼명, 기준이 되는 컬럼) -> 오름차순된다.(기준이 되는 컬럼을 기준으로 정렬된다.)
#reorder(원하는 축이 될 컬럼명, -기준이 되는 컬럼) -> 내림림차순된다.(기준이 되는 컬럼을 기준으로 정렬된다.)
ggplot(manu_hwy, aes(x = reorder(manufacturer, mean_hwy), y = mean_hwy)) + geom_col()
ggplot(manu_hwy, aes(x = reorder(manufacturer, -mean_hwy), y = mean_hwy)) + geom_col()

#문제! >> 제조회사별 구동방식별 구동방식별 평균 고속도로 연비 평균출력력
mdh <-mpg %>% group_by(manufacturer,drv) %>% summarise(mean_hwy = mean(hwy))
mdh
#시각화!
#geom_col(aes(fill = 기준컬럼명)) ->>> 기준컬럼명을 기준삼아 축을 다시한번 생성한다.
ggplot(mdh, aes(x = manufacturer, y = mean_hwy))+ geom_col(aes(fill= drv), position = 'dodge')


#문제! >> 구동방식(drv)별 빈도수 그래프
#geom_bar() -> 빈도수 그래프
# 빈도그래프를 그릴 때 y축이 빈도수로 결정되기 때문에 y축을 지정하지 않는다!!!!!!
ggplot(mpg, aes(x = drv)) + geom_bar()

#문제! >> 제조회사별 차종별 빈도그래프
ggplot(mpg, aes(x=manufacturer)) + geom_bar(aes(fill = class))
ggplot(mpg, aes(x=manufacturer)) + geom_bar(aes(fill = class), position = 'dodge')


#최종실습!!!! 타이타닉!!!!!
list.files()
titanic <- read.csv("titanic_2.csv", stringsAsFactors = T)

#행렬 출력
dim(titanic)
#속성 출력
str(titanic)
#요약 통계량
summary(titanic)
#컬럼명
names(titanic)

#특정 컬럼을 범주형 데이터로 변환
#facotr(범주형으로 바꿀 데이터)
titanic$Survived <- factor(titanic$Survived)
summary(titanic)
#나머지 범주형 데이터 변환하기!
titanic$Pclass <- factor(titanic$Pclass)
titanic$Sex <- factor(titanic$Sex)
titanic$Embarked <- factor(titanic$Embarked)

#실행시키지 말것! 먼가 이상하다 ㅠㅠㅠ
titanic$SibSp <- factor(titanic$SibSp)
titanic$Parch <- factor(titanic$Parch)
titanic$Ticket <- factor(titanic$Ticket)
titanic$Cabin <- factor(titanic$Cabin)
#여기까지 실행 ㄴㄴ


summary(titanic)
#결측치 확인
table(is.na(titanic$Name))
table(is.na(titanic$Cabin)) #빈공간은 들어가 있다!

#빈공간 결측치 처리 해주기!
titanic$Name <- ifelse(titanic$Name=="",NA,titanic$Name)
titanic$Cabin <- ifelse(titanic$Cabin=="",NA,titanic$Cabin)
#나이에 결측치가 있다면 중앙값 넣어주기
table(is.na(titanic$Age))
titanic$Age <- ifelse(is.na(titanic$Age), mean(titanic$Age, na.rm = T), titanic$Age)
#금액에 0원이 있다면 평균 금액 넣어주기기
titanic$Fare <- ifelse(titanic$Fare == 0, mean(titanic$Fare, na.rm = T), titanic$Fare)
#Embarked가 없는 행은 걸러주기
titanic <-titanic %>% filter(Embarked != "")
table(titanic$Embarked)

#Cabin에서 숫자 빼고 알파벳만 가져오기!(아래 알파벳일 수록 아래층 선실이다.)
table(titanic$Cabin)
titanic$Cabin <- ifelse(titanic$Cabin=="","Z",titanic$Cabin)
#substr() -> 문자열만 잘라오는 기능! -> 찾아볼것것
titanic$Cabin <- substr(titanic$Cabin,1,1)
table(titanic$Cabin)

titanic <-  titanic %>% mutate(FamilySize = SibSp + Parch + 1)
titanic <- titanic %>%  mutate(FamilyLevel = ifelse(FamilySize == 1, "Single", ifelse(FamilySize <=4, "Small", "Large")))

titanic <- titanic %>% filter(Cabin != "Z")
ggplot(data = titanic, aes(x=Cabin)) + geom_bar(aes(fill = Survived), position = 'dodge')

#titanic$Cabin <- as.character(titanic$Cabin) 이렇게 하면 카빈에 숫자가 안생기고 영어로 나온다!!! 승훈아 고마워!!!! ㅋㅋㅋㅋㅋ

# 민서형 코드
titanic<-read.csv("titanic_2.csv",stringsAsFactors = T)
titanic$Survived <- factor(titanic$Survived)
summary(titanic)
titanic$Pclass <- factor(titanic$Pclass)
summary(titanic)
titanic$Embarked <-factor(titanic$Embarked)
titanic$Sex <- factor(titanic$Sex)
titanic$Cabin <- as.character(titanic$Cabin)
titanic$Cabin <- substr(titanic$Cabin,1,1) 
titanic$Cabin <- ifelse(titanic$Cabin=="","Z",titanic$Cabin)
titanic <- titanic %>% mutate(FamilySize=SibSp+Parch+1)

titanic <- titanic %>% mutate(FamilyLevel = ifelse(FamilySize == 1, "Single", ifelse(FamilySize <= 4, "Small", "Large")))

titanic <- titanic %>%  filter(Cabin !="Z")
ggplot(data=titanic, aes(x=Cabin))+geom_bar(aes(fill=Survived), position = "dodge")
