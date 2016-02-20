---
layout: page
title: 데이터 과학
subtitle: SQL
---
> ## 학습 목표 {.objectives}
>
> * SQL 개념을 이해한다.

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

