---
layout: page
title: R 파이썬 클라우드
subtitle: R과 데이터 조작(Manipulation)
---
> ## 학습 목표 {.objectives}
>
> * SQL 개념을 이해한다.
> * R 언어를 소개한다.
> * 데이터 조작을 이해한다.

*SQL*에 대한 이해가 데이터 조작(Data Manipulation)의 이해를 돕는다.

### 1. SQL 자료처리

자료를 원하는 방향으로 처리하기 위해서는 다음과 같은 다양한 기본적인 자료 처리 방법을 조합하여 사용한다.

 - 데이터 선택하기
 - 정렬과 중복 제거하기
 - 필터링(filtering)
 - 새로운 값 계산하기
 - 결측 데이터 (Missing Data)
 - 집합 (Aggregation)
 - 데이터 조합하기 (Combining Data)

~~~ {.input}
# 칼럼과 행 선택
SELECT 칼럼명1, 칼럼명2....칼럼명N
FROM   테이블명
WHERE  조건;

# 그룹에 따른 정렬 및 집합(aggregation)
SELECT SUM(칼럼명)
FROM   테이블명
WHERE  조건
ORDER BY 칼럼명 {오름차순|내림차순};
GROUP BY 칼럼명;
~~~

#### 1.1 SQLite 설치

먼저 이론을 이해하는 것과 더블어 예제 데이터베이스를 설치하고 실습을 진행하기 위해서 먼저 명령-라인을 사용하여 어떻게 디렉토리 여기저기 이동하는지와 명령-라인에서 명령문을 어떻게 실행하는지 숙지할 필요가 있다.

이런 주제와 친숙하지 않다면, [유닉스 쉘(Unix Shell)](http://software-carpentry.org/v5/novice/shell/index.html) 학습을 참조한다. `SQLite` 데이터베이스가 어떻게 동작하는지 설명을 할 필요가 있다.

인터랙티브하게 학습을 수행하기 위해서는 [설치 방법](http://software-carpentry.org/v5/setup.html)에 언급된 SQLite 를 참조하여 설치하고, 학습자가 선택한 위치에 "software_carpentry_sql" 디렉토리를 생성한다. 예를 들어,


1. 명령-라인 터미널 윈도우를 연다.
2. 다음과 같이 명령어를 타이핑해서 디렉토리를 생성한다.

~~~ {.input}
$ mkdir ~/swc/sql
~~~

3. 생성한 디렉토리로 현재 작업 디렉토리를 변경한다.

~~~ {.input}
$ cd ~/swc/sql
~~~

#### 1.2. 실습 예제 데이터베이스 다운로드

`깃헙(GitHub)`에서 `gen-survey-database.sql` 파일을 어떻게 다운로드 받을까요?

`~/swc/sql` 디렉토리로 이동한 후에 그 디렉토리에서 GitHub 사이트 [https://github.com/swcarpentry/bc/blob/master/novice/sql/gen-survey-database.sqlSQL](https://github.com/swcarpentry/bc/blob/master/novice/sql/gen-survey-database.sqlSQL) 에 위치한 SQL 파일("gen-survey-database.sql")을 다운로드한다.

파일이 GitHub 저장소 내에 위치하고 있어서, 전체 Git 저장소(git repo)를 복제(cloning)하지 않고 단일 파일만 로컬로 가져온다. 이 목적을 달성하기 위해서,
HTTP, HTTPS, FTP 프로토콜을 지원하는 명령-라인 웹크롤러(web-crawler) 소프트웨어 [GNU Wget](http://en.wikipedia.org/wiki/Wget) 혹은, 다양한 프로토콜을 사용하여 데이터를 전송하는데 사용되는 라이브러리이며 명령-라인 도구인 [cURL](http://en.wikipedia.org/wiki/CURL)을 사용한다.
두가지 도구 모두 크로스 플랫폼(cross platform)으로 다양한 운영체제를 지원한다.

`Wget` 혹은 `cURL`을 로컬에 설치한 후에, 터미널에서 다음 명령어를 실행한다.

**Tip:** 만약 cURL을 선호한다면, 다음 명령문에서 "wget"을 `curl -O`로 대체하세요.

~~~ {.input}
root@hangul:~/swc/sql$ wget https://raw.githubusercontent.com/swcarpentry/bc/master/novice/sql/gen-survey-database.sql
~~~

상기 명령문으로 Wget은 HTTP 요청을 생성해서 github 저장소의 "gen-survey-database.sql" 원파일만 현재 작업 디렉토리로 가져온다.


성공적으로 완료되면 터미널은 다음 출력결과를 화면에 표시한다.

~~~ {.output}
--2014-09-02 18:31:43--  https://raw.githubusercontent.com/swcarpentry/bc/master/novice/sql/gen-survey-database.sql
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 103.245.222.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|103.245.222.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3297 (3.2K) [text/plain]
Saving to: ‘gen-survey-database.sql’

100%[=========================================================================================================================&gt;] 3,297       --.-K/s   in 0.01s   

2014-09-02 18:31:45 (264 KB/s) - ‘gen-survey-database.sql’ saved [3297/3297]
~~~

이제 성공적으로 단일 SQL 파일을 가져와서, `survey.db` 데이터베이스를 생성하고 `gen-survey-database.sql` 에 저장된 지시방법에 따라서 데이터를 채워넣는다.

명령-라인 터미널에서 SQLite3 프로그램을 호출하기 위해서, 다음 명령문을 실행한다.

~~~ {.input}
root@hangul:~/swc/sql$ sqlite3 survey.db &lt; gen-survey-database.sql
~~~


#### 1.3. SQLite DB 연결 및 설치 테스트

생성된 데이터베이스에 연결하기 위해서, 데이터베이스를 생성한 디렉토리 안에서 SQLite를 시작한다. 그래서 `~/swc/sql` 디렉토리에서 다음과 같이 타이핑한다.

~~~ {.input}
root@hangul:~/swc/sql$ sqlite3 survey.db
~~~

`sqlite3 survey.db` 명령문이 데이터베이스를 열고 데이터베이스 명령-라인 프롬프트로 안내한다. SQLite에서 데이터베이스는 플랫 파일(flat file)로 명시적으로 열 필요가 있다. 그리고 나서 SQLite 시작되고 `sqlite`로 명령-라인 프롬프트가 다음과 같이 변경되어 표시된다.


~~~ {.output}
SQLite version 3.7.15.2 2013-01-09 11:53:05
Enter &#34;.help&#34; for instructions
Enter SQL statements terminated with a &#34;;&#34;
sqlite&gt;  
~~~

다음 출력결과가 보여주듯이 `.databases` 명령문으로 소속된 데이터베이스 이름과 파일 목록을 확인한다.

~~~ {.input}
sqlite&gt; .databases
~~~

~~~ {.output
seq  name             file                                                      
---  ---------------  ----------------------------------------------------------
0    main             ~/novice/sql/survey.db
~~~


다음과 같이 타이핑해서 필요한 "Person", "Survey", "Site" "Visited" 테이블이 존재하는 것을 확인한다.

~~~ {.input}
sqlite&gt; .tables
~~~

그리고 `.table`의 출력결과는 다음과 같다.

~~~ {.output}
Person   Site     Survey   Visited
~~~


### 2. R과 자료 구조

#### 2.0. 최신 버젼 R 설치

우분투 trusty R 최신버젼 설치에 대한 자세한 원문은 [CRAN 웹사이트](http://cran.r-project.org/bin/linux/ubuntu/)를 참조한다.

1. `/etc/apt/sources.list` 파일 하단에 `deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu/ trusty/` 내용을 추가한다.
    - [CRAN 미러](http://cran.r-project.org/mirrors.html)에서 버클리 대학을 선정했다. 다른 곳을 지정해도 된다.
2. 우분투 보안 APT 키를 가져온다. 

~~~ {.input}
root@docker:~# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
root@docker:~# gpg --hkp://keyserver keyserver.ubuntu.com:80 --recv-key E084DAB9
~~~
3. apt-key에 집어넣는다.

~~~ {.input}
root@docker:~# gpg -a --export E084DAB9 | sudo apt-key add 
~~~

4. 바이러리 R을 설치한다. 만약 소스코드에 R 팩키지를 컴파일한다면 `r-base-dev` 도 함께 설치한다.

~~~ {.input}
root@docker:~# sudo apt-get update && sudo apt-get install r-base
root@docker:~# sudo apt-get install r-base-dev
~~~

5. 원문은 [스택오버플러어 웹사이트](http://stackoverflow.com/questions/10476713/how-to-upgrade-r-in-ubuntu)를 참조한다.

~~~ {.output}
root@docker:~# R

R version 3.2.1 (2015-06-18) -- "World-Famous Astronaut"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R은 자유 소프트웨어이며, 어떠한 형태의 보증없이 배포됩니다.
또한, 일정한 조건하에서 이것을 재배포 할 수 있습니다.
배포와 관련된 상세한 내용은 'license()' 또는 'licence()'을 통하여 확인할 수 있습니다.

R은 많은 기여자들이 참여하는 공동프로젝트입니다.
'contributors()'라고 입력하시면 이에 대한 더 많은 정보를 확인하실 수 있습니다.
그리고, R 또는 R 패키지들을 출판물에 인용하는 방법에 대해서는 'citation()'을 통해 확인하시길 부탁드립니다.

'demo()'를 입력하신다면 몇가지 데모를 보실 수 있으며, 'help()'를 입력하시면 온라인 도움말을 이용하실 수 있습니다.
또한, 'help.start()'의 입력을 통하여 HTML 브라우저에 의한 도움말을 사용하실수 있습니다
R의 종료를 원하시면 'q()'을 입력해주세요.

>
~~~


#### 2.1. 모드(mode)와 클래스(class)

모드 함수는 객체의 모드를 리턴하고, 클래스 함수는 클래스를 리턴한다. 가장 흔하게 만나는 객체 모드는 숫자, 문자, 로직 모드다. 때때로 리스트와 데이터프레임과 같이 하나의 객체안에 여러 모드를 포함하기도 한다. 

범주형 자료를 R에 저장하기 위해서 요인(Factor) 클래스를 사용하며 요인 클래스를 사용하여 자료를 저장할 경우 저장공간을 절약할 수 있다. 요인은 내부적으로 숫자(value)로 저장을 하고 레이블(value label)을 사용하여 표시를 하여 저장공간을 절약한다.

날짜와 시간도 중요한 데이터자료형니다.

리스트(List)는 데이터를 저장하는 유연하며 강력한 방법으로 `sapply` 함수와 함께 가장 빈번하게 사용되는 자료형이다. 리스트형 자료 `mylist`를 세가지 숫자형, 문자형, 요인형 세가지 자료형을 포함하게 작성한다. `sapply` 함수를 이용하여 `mode`와 `class` 인자를 넣어줌으로써, 각각 자료형의 모드와 클래스를 확인할 수 있다.

~~~ {.input}
> mylist = list(a=c(1,2,3),b=c("cat","dog","duck"), d=factor("a","b","a"))
> sapply(mylist,mode)
~~~

~~~ {.output}
          a           b           d 
  "numeric" "character"   "numeric" 
~~~

~~~ {.input}
> sapply(mylist,class)
~~~

~~~ {.output}
          a           b           d 
  "numeric" "character"    "factor" 
~~~

~~~ {.input}
> factor2 <- factor(c(1,2,3,4,5,6,7,8,9),labels=letters[1:9])
> factor2
~~~

~~~ {.output}
[1] a b c d e f g h i
Levels: a b c d e f g h i
~~~

~~~ {.input}
> levels(factor2)
~~~

~~~ {.output}
[1] "a" "b" "c" "d" "e" "f" "g" "h" "i"
~~~

~~~ {.input}
> labels(factor2)
~~~

~~~ {.output}
[1] "1" "2" "3" "4" "5" "6" "7" "8" "9"
~~~

#### 2.2. 정의된 데이터 형식에 맞게 데이터 저장

가장 간단하게 자료를 저장할 수 있는 벡터 `c` 함수(concatenate or combine)로 시작해 봅시다. 1,2,5,10을 벡터 함수 `c`로 합쳐서 mode 함수를 확인하니 숫자형이 된다. 

숫자가 문자가 합쳐진 y는 문자 자료 형식이 됩니다. 숫자와 논리 자료형이 합쳐진 경우는 숫자가 됩니다. 벡터를 합쳐서 all 과 같이 활용도 가능하며 당연히 문자 자료형이 된다.

~~~ {.input}
> x = c(1,2,5,10)
> x
~~~

~~~ {.output}
[1]  1  2  5 10
~~~

~~~ {.input}
> mode(x)
~~~

~~~ {.output}
[1] "numeric"
~~~

~~~ {.input}
> y = c(1,2,"cat",3)
> y
~~~

~~~ {.output}
[1] "1"   "2"   "cat" "3"
~~~

~~~ {.input}  
> mode(y)
~~~

~~~ {.output}
[1] "character"
~~~

~~~ {.input}
> z = c(5,TRUE,3,7)
> z
~~~

~~~ {.output}
[1] 5 1 3 7
~~~

~~~ {.input}
> mode(z)
~~~

~~~ {.output}
[1] "numeric"
~~~

~~~ {.input}
> all = c(x,y,z)
> all
~~~

~~~ {.output}
 [1] "1"   "2"   "5"   "10"  "1"   "2"   "cat" "3"   "5"   "1"  "3"   "7"
~~~

~~~ {.input}
> mode(all)
~~~

~~~ {.ouptut}
[1] "character"
~~~

R은 6가지 기본 벡터 자료 저장 형식을 가지고 있다. 이와는 다른 행렬(matrix), 데이터프레임(data.frame), 리스트(list)가 있다.


<table>
  <tr><th>자료형(Type)</th><th>모드(Mode)</th><th>저장모드(Storage Mode)</th></tr>
  <tr><td>logical</td><td>logical</td><td>logical</td></tr>
  <tr><td>integer</td><td>numeric</td><td>integer</td></tr>
  <tr><td>double</td><td>numeric</td><td>double</td></tr>
  <tr><td>complex</td><td>complex</td><td>complex</td></tr>
  <tr><td>character</td><td>character</td><td>character</td></tr>
  <tr><td>raw</td><td>raw</td><td>raw</td></tr>
</table>

자료분석을 위해서 자료를 데이터셋의 형태로 구성을 해야한다. 데이터셋이 중요한 이유는 자료를 분석하기 위해서 다양한 형태의 개별 자료를 통합적으로 분석하기 위해서다. 이를 위해서 리스트 자료구조로 일단 모으게 된다. 예를 들어 개인 신용분석을 위해서는 개인의 소득, 부채, 성별, 학력 등등의 숫자형, 문자형, 요소(Factor)형 등의 자료를 데이터셋에 담아야 한다. 특히 변수와-관측값 (Variable-Observation) 형식의 자료를 분석하기 위해서는 데이터프레임(``data.frame``)을 자주 사용한다. 데이터프레임은 모든 변수에 대해서 관측값이 같은 길이를 갖도록 만들어 놓은 것이다. 

![리스트와 데이터프레임](fig/data-science-list-dataframe.png)


> #### 자료형 확인 {.callout}
> 
> 각각의 데이터 형식에 맞는지를 다양한 테스트 함수를 이용하여 데이터 형식을 확인할 수 있다. 
> 
> - is.list: 리스트 형식인 확인
> - is.factor: 팩터 형식인지 확인
> - is.numeric: 숫자형인지 확인
> - is.data.frame: 데이터 프레임형인지 확인
> - is.character: 문자형인지 확인
 
#### 2.3. R 객체 구조 파악

간단한 자료는 데이터 형식을 확인할 수 있는 1~2줄 정도의 간단한 스크립트와 명령어를 통해서 확인이 가능하지만 복잡한 데이터의 구조를 파악하기 위해서는 summary 함수와 str 함수를 통해서 확인해야 한다.

~~~ {.input}
> mylist = list(a=c(1,2,3),b=c("cat","dog","duck"),d=factor("a","b","a"))
> summary(mylist)
~~~

~~~ {.output}
  Length Class  Mode     
a 3      -none- numeric  
b 3      -none- character
d 1      factor numeric
~~~

~~~ {.input}  
> str(mylist)
~~~

~~~ {.output}
List of 3
 $ a: num [1:3] 1 2 3
 $ b: chr [1:3] "cat" "dog" "duck"
 $ d: Factor w/ 1 level "a": NA
~~~

#### 2.4. `apply` 함수

자료는 기본적으로 *벡터(Vector)*를 기본으로 한다. 하지만 벡터로 표현될 수 있는 정보량은 한정되어 있으며 이를 하나의 자료 형태로 구조화한 것을 *데이터프레임(dataframe)*으로 볼 수 있다. 따라서, 자료분석을 위한 기본 자료구조가 데이터프레임이 된다.

R을 사용하는 방법 중 하나는 반복을 통해 한번에 하나씩 연산을 수행하기 보다 단 한번 *호출(call)*을 통해 전체 벡터 연산을 수행한다. 또한 `apply` 함수를 사용해서 행, 열, 리스트에 대해 동일 연산을 수행한다. 또한 `reduce`를 사용해서 함수형 프로그래밍도 확장해서 수행한다.


 - `lapply(리스트, 함수)` : 리스트(list) 자료형에 `apply` 함수를 적용하여 데이터를 처리한다.
 - `sapply(리스트, 함수)` : `lappy` 함수와 동일하나 리스트 대신에 벡터를 반환한다.
 - `mapply(함수,리스트1,리스트2,...)` : 병렬로 다수 리스트에 대해서 `apply` 함수로 데이터를 처리한다.
 - `tapply(x,요인변수,함수)` : 요인변수(factor)에 맞춰 `apply` 함수로 데이터를 처리한다. 
 - `vapply(리스트,함수,...)` : `lappy`의 고속처리 버젼.

가공되지 않은 원자료(raw data)에서 자료를 자유자재로 다룰 수 있도록 수십년동안 수많은 통계/공학자들이 아낌없이 시간을 기부해 주었기 때문에 과거에는 전문가들만 할 수 있었던 고도의 어려운 작업도 정확하고 수월하게 수행할 수 있다. 

그 외에도 다양한 팩키지(package)를 파이썬과 마찬가지로 제공하여 R을 선택하는 순간 자료 분석, 모형, 제품화에 대해 강력한 무기를 손에 넣게 된다. 

특히 `SQL`을 통해서 **데이터 조작(Data Manipulation)**에 대한 개념 잡고 `쉘(shell)`을 통한 작업 자동화 개념을 익히고, 패키지를 사용하면 추구하는 바를 신속하고 정확하게 달성할 수 있다. 

#### 2.5. Hadley 자료분석 체계

![Hadley Wickham이 제시한 자료분석 체계](fig/data-science-had.png)

**[Hadley Wickham](http://www.had.co.nz/)**은 `tidyr`을 사용하여 자료 정제하고 자료변환을 위해서 `dplyr`을 사용하고 그래픽 문법(glammar of graphics)에 따라 `ggvis`로 시각화하고 R의 다양한 모형화를 이용한 자료분석 체계도를 제안한다. 

시각화(Visualization)는 데이터에 대한 통찰력(insight)과 탄성, 놀라움을 줄 수 있지만, 확장성(Scalability)은 떨어진다. 왜냐하면, 사람이 데이터 분석 루프에 포함되기 때문에 확장 및 자동화에 한계가 있다. 반대로 모형(Model)은 자동화와 확장성에는 장점이 있지만, 주어진 모형틀안에서 이루어지기 때문에 통찰력, 놀라움, 탄성을 주지는 못하는 아쉬움이 있다. 

#### 2.6. dplyr

[dplyr](http://cran.r-project.org/web/packages/dplyr/dplyr.pdf) 패키지는 데이터프레임(data.frame) 자료처리를 위한 차세대 `plyr` 패키지다. 다음 6가지 함수가 핵심 함수로 SQL 기본 기능과 유사성이 높다. 따라서, 기존 다양한 자료처리 방식을 직관적이고 빠르며 효율적인 dplyr 패키지 함수로 생산성을 높여본다.

 - filter (관측점 필터링) : 특정 기준을 만족하는 행을 추출한다.
 - select (변수 선택하기) : 변수명으로 특정 칼럼을 추출한다.
 - arrange (다시 정렬하기) : 행을 다시 정렬한다.
 - mutate (변수 추가하기) : 새로운 변수를 추가한다. 
 - summarise (변수를 값으로 줄이기) : 변수를 값(스칼라)으로 요약한다.
 
##### 2.6.1. 관측점(obervation) 필터링해서 선택하기 (filter)

<table>
  <tr><th>전통적 방법</th><th>dplyr 방법</th></tr>
  <tr><td>df[df$var01==3 & df$var02$==7]</td><td>filter(df, var01==3, var02==7</td></tr>
</table>


~~~ {.input}
df <- data.frame( 
  color = c("blue", "black", "blue", "blue", "black"), 
  value = 1:5) 
filter(df, color == "blue")
filter(df, value %in% c(1, 4))
~~~

##### 2.6.2. 특정 변수 선택하기 (select)
<table>
  <tr><th>전통적 방법</th><th>dplyr 방법</th></tr>
  <tr><td>df[df$var01==3 & df$var02$==7]</td><td>filter(df, var01==3, var02==7)</td></tr>
</table>

~~~ {.input}
select(df, color)
select(df, -color)
~~~

##### 2.6.3. 다시 정렬하기 (arrange)
<table>
  <tr><th>전통적 방법</th><th>dplyr 방법</th></tr>
  <tr><td>df[order(df$var01, df$var02)]</td><td>arrange(df, var01, var02)</td></tr>
</table>

~~~ {.input}
arrange(df, color)
arrange(df, desc(color))
~~~

##### 2.6.4. 새변수 생성하기 (mutate)
<table>
  <tr><th>전통적 방법</th><th>dplyr 방법</th></tr>
  <tr><td>df$new <- df$var01/df$var02</td><td>df <- mutate(df, new=var01/var02)</td></tr>
</table>

~~~ {.input}
mutate(df, double = 2 * value)
mutate(df, double = 2 * value, quadruple = 2 * double)
~~~

##### 2.6.5. 변수 요약하기 (summarize)
<table>
  <tr><th>전통적 방법</th><th>dplyr 방법</th></tr>
  <tr><td>aggregate(df$value, list(var01=df$var01), mean)</td><td>group_by(df, var01) %.% summarize(totalvalue = sum(value))</td></tr>
</table>

~~~ {.input}
summarise(df, total = sum(value))
by_color <- group_by(df, color) 
summarise(by_color, total = sum(value))
~~~

> #### 요약 통계량 함수 {.callout}
> min(x), median(x), max(x), quantile(x, p)   
> n(), n_distinct(), sum(x), mean(x)   
> sum(x > 10), mean(x > 10)   
> sd(x), var(x), iqr(x), mad(x)  

#### 2.7. 파이프-필터 자료 처리 이유

> #### 함수형 언어 인터페이스 단점 {.callout}
>
> ~~~ {.input}
>hourly_delay <- filter(   
>    summarise(   
>        group_by(   
>             filter(   
>                 flights,    
>                 !is.na(dep_delay)   
>             ),    
>             date, hour   
>        ),    
>    delay = mean(dep_delay),    
>         n = n()   
>    ),    
>    n > 10   
> )
> ~~~

유닉스 파이프-필터 [magrittr]()를 사용한다. ``%>%``은 "then"으로 발음한다.

~~~ {.python}
hourly_delay <- flights %>%  
  filter(!is.na(dep_delay)) %>% 
  group_by(date, hour) %>% 
  summarise(delay = mean(dep_delay), n = n()) %>%  
  filter(n > 10) 
~~~


> ### 자료 유형별 R 팩키지 {.callout}
>
> - 시계열 자료(time series) : zoo, xts, lubridate
> - 지리정보 자료(geospatial data) : sp/maptools
> - 범용 자료 처리 : reshape2/plyr/dplyr/tidyr


### 3. R 프로그래밍 Best Practices

[Martin Maechler](http://datascience.la/martin-maechler-invited-talk-at-user-2014-good-practices-in-r-programming/) useR 2014 컨퍼런스에서 "Good Practice in R Programming" 주제로 발표를 했습니다.  

- Rule 1. Work with source files !  
    - 원본 소스 파일(R Script) 작업하고 이를 통해 객체나 바이너리 산출물 생성로 일원화  
    - Emacs + ESS(Emacs Speacks Statistics) 혹은 Rstudio 같은 IDE(Integrated Development Environment) 사용

- Rule 2. Keep R source well-readable and maintainable
    - 가독성이 뛰어난 소스 코드는 나중에 유지 보수하기 좋다.
    - 들여쓰기(identation), 공백, 70~80 칼럼, 주석처리(하나(``#``)는 코드 끝에, 두개(``##``)는 일반 주석, 세개(``###``)는 코드 블록에 사용)
    - Sweave 혹은 knitr을 사용한다.
    - naming convention을 따른다.

- Rule 3. Do read the documentation
    - R 프로그래밍 책을 읽는다.화 V&R "S Programming"
    - R 매뉴얼 참조 : An introduction to R, Writing R extentions
    - R 패키지 Vignettes
    - help.search()
- Rule 4. Do learn from the masters
    - John Chambers, Bill Venables, Bill Dunlap, Luke Tierney, Brian Riply, R-core team, Dirk Eddelbuettel, Hadley Wickham
    - 다른 사람이 작성한 코드를 읽고 배운다. 일종의 Learning by examples.
    - 부활절 달걀(Easter egg)를 찾아라.
    - [Uwe Ligges, "R Help Desk", The Newsletter of the R Project Volume 6/4, October 2006](http://www.r-project.org/doc/Rnews/Rnews_2006-4.pdf)
    
~~~ {.input}
> anybody ? there ???
+ ?
+ ''
~~~

~~~ {.output}
Contacting Delphi...the oracle is unavailable.
We apologize for any inconvenience.
~~~

- Rule 5. Do not Copy and Paste!
    - 이유는 유지보수성이 좋지 않고 복사하면 확장성, 이식성이 떨어진다.
    - 함수(function)을 작성하고, 큰 함수는 잘게 쪼개 작은 함수로 나누어 작성하고, 함수를 사용한다. 

> #### John Chambers {.callout}
>
> Everything that **exists** is an object;  
> Everything that **happens** is a function call.

- Rule 6. Strive for clarity and simplicity
   - 자기설명가능한 변수명 사용하고, 간결하게 주석을 섞어 작성
   - 모듈방식 작성   

> #### Venables and Ripley {.callout}
>
> ''Refine and polish your code in the same way you would polish your English prose''

- Rule 7. Test your code !
    - 단위 테스트, 모듈
    - ``package.skeleteon()``을 통한 패키지 작성: auto-testing, specific testing, documentation.
    - R 패키지 ``tools``의 ``R CMD check`` 사용, Luke Tierney ``codetools`` 사용
    - 단위 테스트 패키지 ``RUnit``, ``testthat`` 사용
    - 테스트 후에 최적화
    - 최적화에 두가지 원칙: 
        * Don't do it unless you need it.
        * Measure, don't guess, about the speed
    - ``Rprof()``, ``unix.time()``, ``gc()``, R 패키지 ``rbenchmark``, ``microbenchmark``, ``pdbPROF``.

**새로 추가된 안내지침**  

- Rule 8. Maintain R code in **Packages** (extension of "Test!")
- Rule 9. Source code management, Git/GitHub, HG
- Rule 10. Rscript or R CMD BATCH *.R should "always" work ! -> Reproducible Data Analysis and Research

#### 3.1. R 코딩 규칙

R 코드를 가독성이 좋으며 이해하기 쉽게 일관되게 작성하는 것이 중요하다. 코딩 규칙에 대한 자세한 사항은 [The State of Naming Conventions in R][2] 참조한다.

- [Bioconductor’s coding standards](http://wiki.fhcrc.org/bioc/Coding_Standards)
- [Hadley Wickham’s style guide](http://stat405.had.co.nz/r-style.html)
- [Google’s R style guide](http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html)
- [Colin Gillespie’s R style guide](http://csgillespie.wordpress.com/2010/11/23/r-style-guide/)


#### 3.2. 기본 R 쉘 명령어
현재 작업공간을 확인하는 명령어는 `getwd()` 이며, 새로운 작업공간을 설정하는 명령어는 `setwd()` 이다. 현재 작업공간이 “C:\” 디렉토리인데 `setwd()` 명령어를 통해서 새로운 작업 공간으로 변경을 했다. 이것이 필요한 이유는 R은 기본적으로 자료처리 언어이기 때문에 데이터의 사전 위치를 파악하여 효율적으로 작업할 수 있다.

~~~ {.output}
> getwd()
[1] "C:/"
> setwd("D:/01. Work/09. Data_Products")
> getwd()
[1] "D:/01. Work/09. Data_Products"
> system("ls") # 윈도우에서는 shell("dir"), dir()
~~~

#### 3.3. R 패키지(package) 설치
R의 강점은 다양한 패키지를 지원하므로 새로이 뭔가 필요한 것을 자체 개발하는 것보다 우선 다른 사람들이 해논 것을 참조하고 이를 확대하여 가는 것을 권장한다. R 패키지를 설치하는 방법에 대해서 알아보자. *RStudio* 상에서 R 패키지를 설치하는 방법은 메뉴 상단의 `Tools > Install Packages…` 를 클릭하면 `Install Packages` 팝업 메뉴가 나오고 원하는 패키지를 설치하면 된다.

`rpart`는 의사결정나무모델 (Decision Tree) 을 구현할 때 자주 사용되는 패키지로 별도로 개발할 필요없이 기존의 개발 검증된 `rpart` 팩키지를 사용하는 것도 좋겠다. GUI를 통해서 일일이 설치하는 것도 좋지만, `install.packages`를 통한 명령어를 통해서도 설치가 동일하게 가능하다.

~~~ {.input}
> install.packages("rpart")
~~~

~~~ {.output}
trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.1/rpart_4.1-8.zip'
Content type 'application/zip' length 917885 bytes (896 Kb)
opened URL downloaded 896 Kb

package ‘rpart’ successfully unpacked and MD5 sums checked
The downloaded binary packages are in
	C:\Users\Administrator\AppData\Local\Temp\Rtmp4Ce7l1\downloaded_packages
~~~

#### 3.4. R 시작과 끝 (맛보기)

R이 설치되고, 필요한 패키지가 준비되면 분석에 사용할 데이터를 작업 메모리상에 올려야 한다. 분석 데이터를 R 작업공간에 준비하는 방법은 어려가지가 있다. Web URL을 활용한 웹 데이터를 가져오거나, `read.table`을 이용한 로컬 디스크 상의 데이터를 메모리로 불러올 수 있다.

~~~ {.input}
> abalone <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"), header=F)
> names(abalone) <- c("Sex","Length","Diameter","Height","Whole weight","Shucked weight","Viscera weight","Shell weight","Rings")
> head(abalone)
~~~

~~~ {.out}
  Sex Length Diameter Height Whole weight Shucked weight  Viscera weight Shell weight Rings
1   M  0.455    0.365  0.095       0.5140         0.2245          0.1010        0.150    15
2   M  0.350    0.265  0.090       0.2255         0.0995          0.0485        0.070     7
3   F  0.530    0.420  0.135       0.6770         0.2565          0.1415        0.210     9
4   M  0.440    0.365  0.125       0.5160         0.2155          0.1140        0.155    10
5   I  0.330    0.255  0.080       0.2050         0.0895          0.0395        0.055     7
6   I  0.425    0.300  0.095       0.3515         0.1410          0.0775        0.120     8
~~~

분석을 진행하기 위해서 간단한 R 스크립트를 작성하여 보자. 메뉴상단의 `File > New File > R Script` 혹은 `CTRL+SHIFT+N` 단축키를 사용하여 데이터 분석 결과를 스크립트로 작성하여 저장할 수 있다. 분석이 완료된 스크립트는 `SimpleR.R`로 저장한다.

~~~ {.input}
# 기본 분석 스크립트
abalone <- read.csv("abalone.csv")
table(abalone$Sex)
plot(Length ~ Sex, data=abalone)
~~~

~~~ {.output}
> # 기본 분석 스크립트
> abalone <- read.csv("abalone.csv")
> table(abalone$Sex)
   F    I    M 
1307 1342 1528 
> plot(Length ~ Sex, data=abalone)
~~~

자료 분석 결과는 코드, 데이터, 그래프, 테이블로 나타나게 되며 이를 하나의 문서로 각각 정리하는 것은 매우 수고스러운 일이며 기본적으로 기계나 컴퓨터가 해야되는 일중의 하나이다. 이를 위해서 RStudio의 Notebook 기능을 사용한다. 먼저 RStudio의 Notebook 도 `knitr` 패키지와 `Rmarkdown` 같은 패키지를 기반으로 하지만 `knitr` 패키지를 설치하면 모든 의존성을 자동으로 해결해 준다. `knitr` 패키지를 설치한 후에 메뉴상단의 `File > Compile Notebook…` 을 클릭하면 팝업메뉴가 뜨며 제목과 저자를 표시하면 코드, 데이터, 그래프, 테이블 등 정리된 결과를 HTML 파일로 얻을 수 있다. 

~~~ {.input}
install.packages("knitr")
~~~

R 코드, 그림, 테이블, 텍스트와 함께 하나의 작업파일로 데이터 제품을 만들 수 있다. Notebook, Markdown, HTML, LaTex 등 총 4가지 방법이 있으나 RStudio를 사용할 경우 Built-in 된 Notebook을 사용하는 것도 좋은 방법이며, Markdwon, LaTex, HTML등 친숙한 방법을 사용할 수도 있다.

<table>
  <tr><th>Markup 시스템</th><th>입력파일(Input)</th><th>리포트파일(Output)</th></tr>
  <tr><td>Notebook</td><td>.R</td><td>.html (.md 경유)</td></tr>
  <tr><td>Markdown</td><td>.Rmd</td><td>.html (.md 경유)</td></tr>
  <tr><td>HTML</td><td>.Rhtml</td><td>.html</td></tr>
  <tr><td>LaTeX</td><td>.Rnw</td><td>.pdf (.tex 경유)</td></tr>
</table>

RStudio_RMarkdown 을 이용하여 작업파일을 만든 후에 `knit HTML` 버튼을 누루면 HTML 파일을 바로 얻을 수 있다. 

어느 소프트웨어도 마찬가지지만 사용하다보면 오류가 발생하고 이를 확인해야 할 때가 있다. `RStudio`의 경우 `Help>Diagnostics>Show log files` 를 통해서 확인가능하다. `R`과 `Rstudio` 관련 도움말은 google 검색이나, [stack exchange](http://stackexchange.com/)를 통해 얻을 수 있다. 작업을 하다면 콘솔화면을 깨끗이하고 다시 시작하고 싶은 경우가 있다. 윈도나 도스의 경우 `cls` 명령어가 있는데 R에는 딱히 그런 명령어가 없다. 이런 경우 사용자 정의 함수를 하나 만들어서 실행할 수 있다. 

~~~ {.input}
> cls <- function() cat(rep("\n",50))
> cls()
~~~

하지만, 매번 R을 실행할 때마다 반복적으로 해야되기 때문에 R이 시작될 때 자동으로 설정을 하는 방법은 초기 실행 환경파일에 이를 적용하는 것이다. `C:\Program Files\R\R-3.1.0\library\base\R\RProfile` 파일을 텍스트 편집기로 열어 하단에 ``cls`` 함수를 적어두고 저장한다. 혹은, `CTRL+L` 키를 눌러 화면을 깨끗이하며 커서를 맨 위 상단으로 이동한다.

~~~ {.input}
….
local({
    br <- Sys.getenv("R_BROWSER", NA_character_)
    if(!is.na(br)) options(browser = br)
    tests_startup <- Sys.getenv("R_TESTS")
    if(nzchar(tests_startup)) source(tests_startup)
})

# User Defined Functions
cls <- function() cat(rep("\n",50))
~~~

### 4. R 팩키지 개발

#### 4.1. R 팩키지 개발 툴체인 설치

R 버젼이 3.2.0. 이상이며, 소스코드로부터 팩키지를 컴파일할 수 있는 `r-base-dev`이 설치되어 있어야 한다.
R 팩키지는 RStudio를 통해서 개발한다. 자세한 RStudio 설치는 [다음 웹사이트](06-install-shiny-rstudio.html)를 참조한다.

~~~ {.input}
root@csunplugged:~# apt-get install libcurl4-openssl-dev
root@csunplugged:~# wget http://cran.r-project.org/src/contrib/httr_1.0.0.tar.gz
~~~

~~~ {.input}
> install.packages("RCurl")
> install.packages("curl")
> install.packages("httr_1.0.0.tar.gz", repos = NULL, type = "source")
> install.packages(c("devtools", "roxygen2", "testthat", "knitr"))
> install.packages("rstudioapi")
> rstudioapi::isAvailable("0.98.1103")
> devtools::install_github("hadley/devtools")
> has_devel()
~~~

~~~ {.output}
'/usr/lib/R/bin/R' --no-site-file --no-environ --no-save --no-restore CMD SHLIB foo.c 

gcc -std=gnu99 -I/usr/share/R/include -DNDEBUG
  -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 
  -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c foo.c -o foo.o
gcc -std=gnu99 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions 
  -Wl,-z,relro -o foo.so foo.o -L/usr/lib/R/lib -lR
[1] TRUE
~~~

이제 R 팩키지 개발환경이 완성되었으니 `devtools::session_info()` 명령어로 R 시스템 정보를 살펴본다.

~~~ {.input}
> library(roxygen2)
> library(testthat)
> devtools::session_info()
~~~

~~~ {.input}
Session info ------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.2.1 (2015-06-18)
 system   x86_64, linux-gnu           
 ui       RStudio (0.98.1103)         
 language (EN)                        
 collate  en_US.UTF-8                 
 tz       <NA>                        

Packages ----------------------------------------------------------------------------------------------
 package  * version    date       source                          
 crayon     1.3.0      2015-06-05 CRAN (R 3.2.1)                  
 devtools * 1.8.0.9000 2015-06-25 Github (hadley/devtools@5034b86)
 digest     0.6.8      2014-12-31 CRAN (R 3.2.1)                  
 magrittr   1.5        2014-11-22 CRAN (R 3.2.1)                  
 memoise    0.2.1      2014-04-22 CRAN (R 3.2.1)                  
 Rcpp       0.11.6     2015-05-01 CRAN (R 3.2.1)                  
 roxygen2 * 4.1.1      2015-04-15 CRAN (R 3.2.1)                  
 stringi    0.5-2      2015-06-22 CRAN (R 3.2.1)                  
 stringr    1.0.0      2015-04-30 CRAN (R 3.2.1)                  
 testthat * 0.10.0     2015-05-22 CRAN (R 3.2.1)                  
 xwmooc   * 0.0.0.9000 <NA>       local               
~~~
