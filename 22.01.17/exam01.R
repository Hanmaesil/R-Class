id <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
grade <- c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5)
mid <- c(20,23,26,11,22,29,34,37,15,14,26,15,24,24,33,19,11,27,34,21)
fin <- c(33,39,21,11,16,12,30,29,26,25,27,25,11,10,33,25,18,33,21,34)

install.packages("dplyr")
library(dplyr)

score <- data.frame(id, grade, mid, fin)
score

#데이터를 그룹별로 묶어주기기
# 각 반별로 묶어주는 방법 -> group_by(묶고 싶은 컬럼 명명)
# 단순히 group_by()만 사용하지는 않는다.
# -> summarise() 함수와 같이 사용한다.
# summarise() -> 요약 통계량을 볼 수 있는 함수이다.
score %>% group_by(grade) %>% mean(mid) #-> 그룹화하면 일반 함수는 쓸수 없다.
score %>% group_by(grade) %>% summarise(m_mid = mean(mid)) # 미리 컬럼명을 지정해주지 않으면 mean(mid)가 컬럼명이 된다.

score %>% group_by(grade) %>% summarise(m_mid = max(mid))


#dataframe 합치기 
#-> join을 통해서 합친다(열 병합합)
mid <- data.frame(id=c(101,102,103,104,105),mid=c(60,80,70,90,85))
fin <- data.frame(id=c(103,104,105,106,107),fin=c(70,83,65,50,75))

#inner_Join(첫번째 데이터프레임, 두번째 데이터 프레임, by ="기준이되는 컬럼 명") -> 내부 공통으로 가지고 있는 행만 결합
inner_join(mid, fin, by = "id")

#full_join(첫번째 데이터프레임, 두번째 데이터 프레임, by ="기준이되는 컬럼 명") -> 두개의 데이터 프레임을 합친다. ->> 누락된 부분은 결측치(NA)로 채워진다
full_join(mid, fin, by ="id")

#left_join -> 왼쪽을 기준으로 병합 -> 누락된 부부은 결측치치
left_join(min, fin, by = "id")

#right_join -> 오른쪽을 기준으로 병합
right_join(mid, fin, by= "id")

#데이터 합치기(행 병합) -> bind_rows()
# -> 컬럼 이름과 데이터 갯수가 같이야한다!
mid2 <- data.frame(id=c(106,107), mid=c(85,77))
mid
mid2

bind_rows(mid,mid2)


#실습! 항공데이터 분석하기!!
install.packages("hflights")
library(hflights)
dim(hflights)
View(hflights)

#비행기 번호판별 가장 오래걸린 출발시간을 출력하시오.
#na.rm = T ->> na를 지워달라! 는 명령어이다.
hflights %>% group_by(TailNum) %>% summarise(Deptime = max(DepTime, na.rm = T))

# 결항건수가 가장 많았던 날 알아내기!
# 결항사유별 건수를 출력하시오!
hflights %>% group_by(CancellationCode) %>% select(CancellationCode) %>% summarise(n())
hflights %>% group_by(CancellationCode) %>% summarise(n())

#결항사유가 날씨(B)나 기류상황(C)인 데이터만 출력하시오! -> 그 다음 월별 건수 출력!
hflights %>% filter(CancellationCode == "B" | CancellationCode == "C") %>% group_by(Month) %>% summarise(n = n()) %>% arrange(desc(n))
# - > 분석결과 2월이 압도적으로 많다!
# 2월중 어떤 날이 많은지 찾아보자!
hflights %>% filter(CancellationCode == "B" | CancellationCode == "C") %>% group_by(Month, DayofMonth) %>% summarise(n= n()) %>% 
  arrange(desc(n))

#실습!
list.files()
library(readxl)

score <- read_excel("score.xlsx")
score

#결측치(na)를 파악하는 함수
# -> is.na(변수) ->> is가 붙어있으면 불리언 형태로 나온다!(프로그래머끼리의 약속)
is.na(score) #-> na가 있으면 True, 없으면 false로 나온다다

#True와 False의 개수를 출력하시오
table(is.na(score))
#속성(컬럼)별 na의 개수 출력
summary(score)
#filter를 활용하여 mid안에 결측치가 없는 행만 출력
score %>% filter(!is.na(mid)) #! -> not(반대를 의미한다) ->> is.na하면 na가 있는 행만 나오기 때문에 not으로 조건을 바꾼다!
#filter를 활용하여 전체 결측치가 있는 행을 제거
score %>% filter(!is.na(mid) & !is.na(fin) & !is.na(assign) & !is.na(att))
score %>% na.omit() # -> na를 생략한다!
#na를 없애지 말고 na자리에 중간값을 넣어주는게 데이터 분석에 좋다!
median(score$mid, na.rm = T)
#문제! mid안에 결측치가 있다면 중앙값으로 대체해주세요
score$mid <- ifelse(is.na(score$mid), median(score$mid, na.rm = T), score$mid)
score$mid
#문제! mid안에 값이 100점 초과라면 중앙값으로 대체해주세요
boxplot(score$mid) # ->> 이상값은 boxplot를 통해 알수있다.
score$mid <- ifelse(score$mid > 100, median(score$mid, na.rm = T), score$mid)
score$mid
