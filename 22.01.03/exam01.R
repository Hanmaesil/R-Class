# 주석 : 프로그램은 번역하지 않고 넘어가는 부분(#)
# 변수 : 데이터를 저장할 수 있는 임시적인 공간
# 실행 단축키 : ctrl + enter, 동시에 여러줄 하고 싶으면 하고싶은 만큼 드래그하고 단축키!
# num이라는 이름의 변수안에 정수 100을 저장
num <- 100
num
# 함수 : 데이터를 넣으면 특정한 기능을 수행해 데이터를 가공하여 값을 출력
sum(1,2,3,4,5,6,7,8,num)
# 패키지 : 함수들을 모아놓은 묶음

# 변수의 데이터 타입
# 숫자형 : 정수, 실수 등 의 숫자들을 저장할 수 있는 형태
num1 <- 10.3
num1
# 문자형 : 알파벳, 한글 등 문자데이터를 저장할 수 있는 형태
text1 <- "Hello World"
text2 <- 'hello world'
text1
text2
# 논리형 : 참 또는 거짓을 저장할 수 있는 형태
isCheck <- TRUE
isCheck <- FALSE
isCheck <- T #한글자만 써도 된다
isCheck <- F #한글자만 써도 된다
# NA & NULL 형 : 데이터의 상활을 저장할 수 있는 형태
# NA -> 결측치(정의되어있지 않은 데이터!) -> 데이터가 있긴 한데 어디에 써야할지 모르겠다!
# NULL -> 비어있는 값
sum(1,2,3,4,5,NA) # NA 가 하나라도 있으면 NA로 나오기 때문에 처리를 해줘야 한다.
sum(1,2,3,4,5,NULL) # NULL 은 비어있는 값이기 때문에 정상적으로 출력이 된다.

name <- "박병관"
name
name <- "황정민"
name  # 한개의 변수에는 한개의 값만 들어갈 수 있다.

#자료구조 : 대량의 데이터들을 효과적으로 관리할 수 있는 방법.
#벡터(vector) : R에서 가장 기본이 되는 구조, 동일한 유형의 데이터가 1차원으로 구성(배열과 비슷하다!)
#R은 인덱스 시작이 1부터다!!!!!!!

#숫자형 벡터
v_num <-  c(10,15,20) #c() 함수사용 -> 컴바인이라는 함수!
v_num
#v_num <- 10 : 15 혼자 함 해본거
#v_num 10부터 15까지 저장됨

#문자형 벡터
v_text <- c("참외", "수박", "딸기", "귤", "복숭아", "배")
v_text

#논리형 벡터
v_log <- c(T,F,T,T,T,F,F)
v_log

v_text[1]
v_text[1:5] #파이썬처럼 슬라이싱도 가능
num3 <- c(1,2,3,4,5,6,7)
num3[v_log] #블리언 조건식도 가능

#일률적인 벡터 생성 = 순차적으로 진행되는 벡터
v1 <- seq(1,10)
v2 <- 1:10
v1
v2
#seq를 쓰는이유는 속성을 주어서 데이터를 뽑을 수 있다.
v3 <- seq(1,100, by = 4) # 4씩 건너띄면서 데이터를 뽑는다!
v3

v4 <- seq(1,100, length.out = 5) # 1부터 100까지 데이터를 뽑는데 간격이 동일하다.
v4

#벡터의 반복
#rep(반복할 변수, 속성 = 원하는 횟수)
x <- seq(1,3)
rep(x, times =2) #times는 전체반복
rep(x, each = 2) #each는 각각의 요소를 반복복

#실습
foods <- c("간짜장", "족발", "굴보쌈", "참돔", "감자탕", "순대국밥")

#문제 1 : 간짜장 굴보쌈 감자탕을 콘솔에 한번에 출력하시오
#1.
log = c(T,F,T,F,T,F)
foods[log]
#2.
foods[seq(1,5, by = 2)]
#3
num = c(1,3,5)
foods[num]
#4
foods[seq(1,5, length.out = 3)]
#5
c(foods[1], foods[3], foods[5])
#6
foods[c(1,3,5)]
#7
foods[-c(2,4,6)]
#num = c(1,2,3,4,5)
#foods[foods[num%%2 != 0]] #홀짝은 못하나?

#boolean 인덱싱 : TRUE에 해당하는 값만 꺼내기
x = seq(1,20, by =3)
#x의 요소중에서 5보다 큰 값만 꺼내기
x>5
x[x>5]
#x의 요소중에서 7과 같은 값만 꺼내기
x == 7
x[x == 7]



#특정요소를 제거하고 보기
x
x[-c(1,2,3)] #실제로 제거가 되는게 아니라 출력될 때만 제거하고 보는 것이다.

#특정위치의 요소값을 변경
x
#1,2를 바꿔보자!
x[c(1,2)] <- 99
x

#실습!
#1번 : 100에서 300까지 3씩 건너 뛰며 구성퇸 벡터 v1을 생성하고 출력하세요!
v1 = seq(100, 300, by= 3)
v1
#2번 : v1의 20번째 값부터 30번째 값까지 출력하세요!
v1[20:30]
v1[seq(20,30)]
#3번 : v1의 20번째 값부터 30번째 값을 제외한 값을 v2에 저장하고 출력하세요
v1[-(20:30)]
v2 <- v1[-seq(20,30)]
v2
#4번 : v1에서 200보다 큰 수만 출력하세요!
v1[v1 > 200]

#함수를 생성하여 짝수를 판별 -> function() 함수생성
evenOdd <- function(a){
  if(a %% 2 ==0){
    print("even")
  }
}

evenOdd(2)


