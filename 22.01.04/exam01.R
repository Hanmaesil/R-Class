#벡터 : 동일한 자료가 일차원으로 나열된 것
vec1 <- c(10,20,30,40,50)
vec1
vec2 <- c("사과",100,TRUE) #다른 자료형으로 넣었을시
vec2 #전부다 우선순위가 높은은 문자형태로 바뀌어서 출력된다.
vec3 <- c(100.3,33,TRUE,FALSE) #숫자형태가 우선순위가 더 높아서
vec3 # 숫자형태로 바뀌어서 출력된다.

#DataFrame : 행으로 봤을 때는 데이터프레임 형태지만 열로 봤을때는 vector이다
# -> 데이터프레임은 벡터로 이루어져있다.

#DataFrame 만들기 실습
v_no <- seq(1,7)
v_no
v_name <-c("Apple", "Peach", "Banana", "Grape", "Kiwi", "Orange", "Mango")
v_name
v_price <- c(500,200,100,300,150,250,450)
v_price
v_stock <- c(5,2,4,7,5,3,8)
v_stock

#데이터프레임 만드는 방법
#data.frame(순서대로 넣기)
sales <- data.frame(v_no, v_name, v_price, v_stock)
sales

#자료구조를 좀더 정갈하게 보는 방법
View(sales) #컬럼 옆에 화살표 누르면 오름,내림 차순도 됨! 완전 편함!

View(v_no) #데이터를 출력할 때 맨 앞에 대괄호가 있으면 벡터, 없으면 데이터프레임이다!

#데이터프레임에서 원하는 데이터만 조회하기
#sales 데이터 프레임에서 v_name 값만 뽑아서 보기(데이터프레임'$'컬럼명명 )
sales$v_name #원하는 데이터만 뽑으면 벡터 형태로 출력된다(데이터프레임의 컬럼은 벡터로 이루어져있기때문이다.)
#원하는 값 하나만 뽑아오기
sales[3,2]#[행,열]  #이차원배열에서 가져오는것 처럼 가져오면 된다.
sales[3,] #행의 자리에만 쓰면 데이터 프레임을 가져온다.
sales[,2] #열의 자리에만 쓰면 $랑 기능 같다

#데이터프레임에서 컬럼의 개수를 알 수 있는 방법
#ncol(데이터프레임)
ncol(sales)
sales[1,3:ncol(sales)]
#데이터프레임에서 행의 개수를 알 수 있는 방법
nrow(sales)
#데이터프레임에서 컬럼의 이름들만 추출하는 방법
names(sales)
#다양한 함수를 데이터프레임에 적용하기
sum(sales$v_price) #합계
mean(sales$v_price)#평균
round(mean(sales$v_price),digits = 2)#소숫점 2자리 까지 출력
min(sales$v_price)#최솟값
max(sales$v_price)#최댓값
range(sales$v_price)#최솟값과 최대값의 범위위


#실습
No <- seq(1,10)
No
Name <- c("이은비", "김서아", "장하윤", "유이서", "나서윤", "이지안", "박나은", "황유나", "김하율", "윤시아")
Name
Kor <- c(80,76,26,61,44,19,53,81,26,64)
Kor
Eng <- c(8,76,69,18,82,56,48,14,73,83)
Eng
Math <- c(65,27,100,76,37,77,73,19,74,60)
Math
#데이터프레임 만들기
Score = data.frame(No,Name,Kor,Eng,Math)
Score
View(Score)
#Kor열 데이터 출력
Score$Kor
Score[,3]
#Eng열 데이터 출력
Score$Eng
Score[,4]
#컬럼 개수를 출력
ncol(Score)
#행 개수를 출력
nrow(Score)
#컬럼명을 출력
names(Score)
#Kor의 평균점수를 소수 첫째자리까지 출력
round(mean(Score$Kor),digits = 1)
mean(Score$Kor)
#Eng중 가장 큰 점수를 출력
max(Score$Eng)
#Math중 가장 작은 점수를 출력
min(Score$Math)
#첫번째 행의 점수중 가장 작은수부터 큰 수 까지의 범위 출력
range(Score[1,3:ncol(Score)])
#첫번째 행의 점수의 평균
mean(Score[1,3:5]) #벡테에서만 적용된다.
round(mean(Score[1,3:5]), digits = 1)
Score[1,3:5]
apply(Score[1,3:5],1,sum) #데이터프레임에서의 함수!

#엑셀 파일 불러오기
#1. 프로젝트 파일 경로와 동일한 경로에 파일 넣기
#2. 내가 작업하는 공간에 파일들의 목록보기(Working directory)
list.files()
#3. 엑셀 데이터파일을 읽을 수 있는 함수들이 모여있는 패키지 다운로드하기.
install.packages("readxl")
#4. 패키지를 로딩하여 사용하기
library(readxl) #패키지를 사용하고싶을 때 마다 추가해서 사용해야한다.
#5, 함수를 사용하여 파일 불러오기
score <- read_excel("score.xlsx")
score
View(score)
#5-1 sheet가 여러개일때!
#sheet = '원하는시트' 를 속성값으로 넣어준다!
read_excel("score.xlsx", sheet = "February")

#csv 파일을 읽어와서 데이터프레임 형태로 저장하기
titanic <- read.csv('titanic.csv')
titanic
#기본적인 데이터의 종류(다시 찾아볼것!)
#범주형 -> 명목형, 순서형
#수치형 -> 이산형, 연속형

#타이타닉 실습!
list.files()
#stringsAsFactors = -> 문자열 데이터를 범주형으로 읽어들이는 옵션
titanic_2 <- read.csv("titanic_2.csv", stringsAsFactors = T)
#의료 실습!
list.files()
heart <- read.csv("heart_failure_clinical_records_dataset.csv", stringsAsFactors = T)
#통계에서는 컬럼(열)을 변수라고 칭한다! 중요!!!! -> variables 라고 한다다
#통계에서는 행을 관측치라고 칭한다! 중요!!!! -> obs라고 한다


