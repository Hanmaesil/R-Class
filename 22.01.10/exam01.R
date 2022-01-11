#파일 목록 보기기
list.files()
#파일 불러오기
titanic <- read.csv("titanic_2.csv")
titanic

# 데이터의 앞부분을 확인하는 함수 - > head(변수명, 보고싶은 갯수) -> 기본값으로 6개를 보여준다.
head(titanic)
# 데이터의 뒷부분을 확인하는 함수 - > tail(변수명, 보고싶은 갯수) -> 기본값으로 6개를 보여준다.
tail(titanic,3)
# 데이터 속성(컬럼)별 자료형태가 무엇인지 출력 -> str(변수명)
str(titanic)
### 데이터의 크기는 행 * 열 !!

# 데이터 속성별 통계량 출력 - > summary(변수명)
summary(titanic)
### 사분위수 : 데이터를 4등분(1사분(1st Qu..), .....) ->5가지 숫자를 알려준다(최솟값,최대값,중위값,1분위값,3분위값) -> r은 평균까지 알려준다.
#사분위수를 시각화한 그래프 -> boxplot()
boxplot(titanic$Fare)
#데이터 개수 알아보기 -> table(변수$원하는컬럼) -> 표형태로 출력된다.
table(titanic$Embarked)
#데이터의 차원 출력 -> dim()
dim(titanic)


#wordcloud2 패키지 설치 및 적용
install.packages("devtools")

library(devtools)
devtools::install_github("lchiffon/wordcloud2")

library(wordcloud2)

#wordcloud2를 그리는 방법
#단어와 해당되는 빈도수를 데이터프레임으로 만들면 끝!

word <- c("참치회","방어회","송어회","고등어회","순대국밥") # 같은 위치에 넣어줘야 한다.
fre <- c(100,95,80,100,10)
food <- data.frame(word,fre)
food

# 시각화 하기!
wordcloud2(food)
#패키지 안에 있는 함수의 속성을 알 수 있는 방법. -> 앞에 ? 두개 붙이고 실행
??wordcloud2
#크기조절
wordcloud2(food,size = 0.5)
#폰트설정
wordcloud2(food,fontFamily = "궁서체")
#색상설정
wordcloud2(food,color = "random-light") #random-light -> 랜덤색상상
# -> 16진수로 갯수별로 넣으면 각각 지정해줄 수 있다.
#wordcloud 저장하기 -> export에서 세이브하면 됨(html로도 저장가능!)
# -> 프로젝트에 써먹자!!!!!!!!!!!


#실습!
list.files()
baseball <- read.csv("baseball.csv")
#구단과 승 컬럼만 꺼내오기기
#데이터프레임을 만들때 원하는 컬럼명이 있으면 미리 적어주면 된다.
#데이터의 크기를 시각적으로 극대화 하기 위해 제곱시키자!
bb <- data.frame(구단 = baseball$구단, 승 = (baseball$승)^4)
wordcloud2(bb, size = 0.5, fontFamily = "바탕체", color = "random-dark")

#실습!
list.files()
stu <- read.csv("대학 계열별 학과수 및 학년별 재적학생수.csv")

col1 <- data.frame(학과별 = stu$소계열, 학과수 = stu$학과수)
wordcloud2(col1, size = 0.5)

col2 <- data.frame(학과별 = stu$소계열, 재적학생수 = stu$재적학생수)
wordcloud2(col2, color = "random-light", size = 0.5, fontFamily = "나눔바른고딕")
col3 <- letterCloud(data = col2, word = "R", wordSize = 1)
col3

#비정형 데이터 추출 및 사용 실습
#TextMining -> 집단에서 자주 쓰이는 유의미한 데이터를 추출해내는 기술!

#java, rjava 설치
install.packages("remotes")
remotes::install_github("mrchypark/multilinguer")
> install.packages("multilinguer")
library(multilinguer)
install_jdk()

#의존성 패키지 설치
> install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")
