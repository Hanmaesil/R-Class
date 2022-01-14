# **** 데이터 전처리 하기(아주 중요하다!!!!!) ****
#데이터 전처리 할 때 주로 사용하는 패키지 dplyr
install.packages("dplyr")
library(dplyr)
#엑섹파일 불러오기
library(readxl)

list.files()
score <- read_excel("score_10차시.xlsx")
score

#%>%(파이프연산자) -> 단축키 : ctrl + shift + m
#DataFrame의 컬럼명을 바꾸는 함수
#-> rename() ->> 원본데이터 %>%  rename(바꾸고 싶은 새로운 컬럼명 = 바꿀 컬럼 명) ->>>>>> 저장안됨! 변수에 담을 것!
score <- score %>% rename(id = 학번, grade = 학년, mid = 중간고사, final = 기말고사, assign = 과제제출, att = 출석점수)
score

# **** 조건에 맞는 행만 추출하기 ****
#-> filter() ->> 원본데이터 %>% filter(조건)
# 조건의 결과가 TRUE인 행만 추출한다.
score
#grade가 1인 행만 출력하기
score %>% filter(grade == 1)
#grade 가 1이고 mid점수가 25점 이상인 학생의 행만 출력하기 ->> and 기호 : & 
score %>% filter(grade == 1 & mid >= 25) #이 방식 위주로 사용하자!
score %>% filter(grade ==1 , mid >= 25)
score %>% filter(grade == 1) %>% filter(mid >=25)

#원하는 컬럼만 추출하는 함수
# -> select() ->> 원본데이터 %>%  select(원하는 컬럼명)
names(score) #->컬럼명만 추출
score %>% select(grade)
score %>% select(grade, mid) #두개 이상을 보고 싶을 때 , 를 사용한다.

#문제!
# 1학년 학생들의 중간점수와 기말점수만 출력하시오
score %>% filter(grade == 1) %>% select(mid,final)

# 정렬할 때 사용하는 함수
# -> arrange() ->> 원본데이터 %>% arrange(정렬하고 싶은 기준의 컬럼 명)
score %>% arrange(mid) # -> 오름차순
score %>% arrange(desc(mid)) # - > 내림차순
score %>% arrange(mid, final) #두개 이상 정렬 가능 ->>>> 앞에 먼저 적은 컬럼명을 기준으로 그룹화

# 문제!
# 4학년 학생들의 기말고사 점수만 내림차순으로 출력하세요
score %>% filter(grade == 4) %>% select(final) %>% arrange(desc(final)) #select 와 arrange의 순서는 상관 없음!

# 새로운 속성(파생변수) 생성하는 함수(ex 행의 모든 값을 더한 값을 담을 컬럼!)
# -> mutate() ->> 원본데이터 %>% mutate(만들고 싶은 컬럼명 = 추가할 값)
score <- score %>% mutate(total = mid + final + assign + att)
score
#조건을 통해 파생변수 만들고 값 넣기
score <- score %>% mutate(fp = ifelse(total >= 60, "pass", "fail"))
#삼항연산자랑 비슷! ->> ifelse(조건식 , "true일때 출력될것.", "false일때 출력될것")
score
