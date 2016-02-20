---
layout: page
title: 데이터 과학
subtitle: 데이터 정제
---
> ## 학습 목표 {.objectives}
>
> * 왜 데이터 정제인가?
> * 데이터 정제 문제에 대한 R진영 해결책을 이해한다.
> * 사람과 컴퓨터를 위한 `dplyr` 데이터 랭글링 코딩을 수행한다.

데이터 정제(Cleansing)는 원데이터를 시각화하거나 모형을 개발을 위해 다음 단계를 준비하는 사전 준비과정이다. 
하지만, 데이터 정제는 과거 많이 사용된 개념으로 정형화된 데이터베이스 혹은 통계 팩키지에 데이터를 사전 준비하는 과정을 
지칭하는 것으로 비정형 데이터와 정형 데이터가 함께 공존하고, 새로운 유형의 데이터가 넘처나는 지금에는 데이터 랭글링(Data Wrangling) 혹은 데이터 먼징(Data Munging)같은 용어가 사용된다.

목표는 원자료(raw data)를 또다른 형태로 수작업 혹은 자동화하는 프로그램을 작성하여 전환하거나 매핑하는 과정이다.
[데이터 과학자에 관한 하바드 비즈니스 리뷰 기사](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/)[^data-science-hbr]에 따르면, 21세기 가장 인기있는 직업이 데이터 과학자로 친송받고 있지만, **[데이터 랭글링에 관한 뉴욕타임즈 기사](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0)**[^data-science-nytimes]에 따르면 데이터 과학자 시간의 50% ~ 80% 시간을 데이터를 수집, 준비, 정제 등의 노동집약적인 작업에 소모하는 것으로 보고되고 있다. 

[^data-science-hbr]: [Data Scientist: The Sexiest Job of the 21st Century](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/)
[^data-science-nytimes]: [For Big-Data Scientists, ‘Janitor Work’ Is Key Hurdle to Insights](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0)

이런 문제에 대한 해결책을 오랜 기간동안 탐구해 왔지만, 문제의 본질을 파악하고 이에 대한 적절한 툴체인을 구축함으로써 
문제를 기회를 바꿀 수 있다.

<img src="fig/data-science-rationale.png" alt="전통적 문제정의" width="50%" />

### 1. 기본문제 정의틀

데이터 과학은 컴퓨터와 사람이 데이터 프로그래밍 언어 R로 소통하는 과정으로 이해할 수 있다.
사람이 인지하여 생각한 것을 코딩을 통해 기술하고 이를 컴퓨터에 넣어주면, 컴퓨터가 이를 실행하는 과정이다.
과거, 컴퓨터 자원이 희귀하여 최대한 컴퓨터을 활용하는 점에 초점을 맞춰 데이터 과학 아키텍처가 설계되었다면,
현재는 클라우드, 오픈소스, 오픈 데이터, 인터넷에 연결된 수많은 컴퓨터로 말미암아 
사람이 가장 중요한 자원이 되었고, 컴퓨터에 작업명령을 기술하는 코딩도 기계중심 프로그래밍 언어에서
인간중심 프로그래밍 언어로 진화하고 있다.

### 2. 문제해결 개념 아키텍쳐

문제 해결의 중심에 사람이 있다. 하지만 `tidyr`을 통해 데이터테이블 형식의 
데이터가 `dplyr`에 들어오는 것을 기본 가정으로 깔고 있다.
데이터테이블로 데이터가 들어오면 데이터를 처리하는 인지능력을 통해
알고리즘을 생각하고, 이를 코딩으로 기술해서,
컴퓨터에 작업명령을 내린다.

<img src="fig/data-science-countermeasure.png" alt="R진영 해결책" width="50%" />

#### 2.1. `dplyr` 동사 명령어

인지능력을 통해 데이터를 처리하는 알고리즘은 데이터 처리 동사 명령어로 볼 수 있다.
`tidyr`을 통해 정규데이터 형태로 변형이 되었다고 가정하면,
변수에 연산작업을 내리는 `select()`, 행에 연산작업을 지시하는 `filter()`,
변수 변환과정을 통해 신규 변수를 생성하게 만드는 `mutate()`,
평균, 합, 분산, 최대값 등 관측점을 요약하는 `summarise()`,
변수에 관측점을 오름차순 혹은 내림차순으로 정렬하는 `arrange()` 함수가 있고,
추가로 `group_by()` 함수로 그룹집단을 지정한다.

- select: 데이터테이블에서 변수를 뽑아낸다.
- filter: 값으로 관측점을 뽑아낸다.
- mutate: 신규 변수를 생성한다. (log 변환)
- summarise: 관측점을 하나로 축약한다. (평균)
- arrange: 관측점을 오름차순, 내림차순으로 정렬한다.

#### 2.2. `%>%` 파이프라인 연산자

`dplyr`은 파이프 연산자 [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)을 가져와서 사용한다. `%>%`은 "then"으로, 혹은 "파이프"" 발음한다.

파이프-필터 스타일을 사용해야 되는 이유는 다음 전통적 R 코드와 파이프를 사용한 코드를 
살펴보게 되면 확연히 이해할 수 있다. 즉, 괄호를 많이 사용한 R코드는 인지적으로 
괄호안으로 들어갔다 나오고 이해하고, 또 괄호를 내부를 이해하고 나서 
괄호내부를 외부 괄호와 연결하는등 상당히 많은 두뇌회전을 요구하지만, 
파이프 연산자를 사용하면 매우 직관적으로 이해할 수 있다.

> ### 전통적 R 코드와 파이프 연산자를 사용한 R 코드 비교 {.callout}
>
> #### 전통적 R 코드
> ~~~ {.input}
> hourly_delay <- filter(   
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
>
> #### 파이프 연산자를 사용한 R 코드
> 
> ~~~ {.r}
> hourly_delay <- flights %>%  
>   filter(!is.na(dep_delay)) %>% 
>   group_by(date, hour) %>% 
>   summarise(delay = mean(dep_delay), n = n()) %>%  
>   filter(n > 10) 
> ~~~

#### 2.3. SQL 코드 자동생성

`dplyr` 팩키지에 `translate_sql` 함수를 통해 R코드를 SQL 쿼리문으로 
바꿔 데이터베이스에 질의를 던지게 된다. 이를 통해 빅데이터 및 다양한 데이터베이스에 
존재하는 데이터를 R에서 인지적 부담없이 작업할 수 있게 된다.

~~~ {.r}
flights %>%
 filter(!is.na(dep_delay)) %>%
 group_by(date, hour) %>%
 summarise(delay = mean(dep_delay), n = n()) %>%
 filter(n > 10)
}
~~~

~~~ {.r}
SELECT "date", "hour", "delay", "n"
FROM (
    SELECT "date", "hour",
        AVG("dep_delay") AS "delay",
        COUNT() AS "n"
    FROM "flights"
    WHERE NOT("dep_delay" IS NULL)
    GROUP BY "date", "hour"
) AS "_W1"
WHERE "n" > 10.0
~~~


### 3. Hadley 자료분석 체계

**[Hadley Wickham](http://www.had.co.nz/)**은 `tidyr`을 사용하여 자료 정제하고 자료변환을 위해서 `dplyr`을 사용하고 그래픽 문법(glammar of graphics)에 따라 `ggvis`로 시각화하고 R의 다양한 모형화를 이용한 자료분석 체계도를 제안하였고, 최근에는 `broom` 팩키지를 통해 R 모형에서 반환하는 결과값을 재활용할 수 있는 툴체인도 제안하고 있다.

시각화(Visualization)는 데이터에 대한 통찰력(insight)과 탄성, 놀라움을 줄 수 있지만, 확장성(Scalability)은 떨어진다. 왜냐하면, 사람이 데이터 분석 루프에 포함되기 때문에 확장 및 자동화에 한계가 있다. 반대로 모형(Model)은 자동화와 확장성에는 장점이 있지만, 주어진 모형틀안에서 이루어지기 때문에 통찰력, 놀라움, 탄성을 주지는 못하는 아쉬움이 있다. 

#### 3.1. `dplyr`

[dplyr](http://cran.r-project.org/web/packages/dplyr/dplyr.pdf) 패키지는 데이터프레임(data.frame) 자료처리를 위한 차세대 `plyr` 패키지다. 다음 6가지 함수가 핵심 함수로 SQL 기본 기능과 유사성이 높다. 따라서, 기존 다양한 자료처리 방식을 직관적이고 빠르며 효율적인 dplyr 패키지 함수로 생산성을 높여본다.

 - filter (관측점 필터링) : 특정 기준을 만족하는 행을 추출한다.
 - select (변수 선택하기) : 변수명으로 특정 칼럼을 추출한다.
 - arrange (다시 정렬하기) : 행을 다시 정렬한다.
 - mutate (변수 추가하기) : 새로운 변수를 추가한다. 
 - summarise (변수를 값으로 줄이기) : 변수를 값(스칼라)으로 요약한다.

~~~ {.input}
df <- data.frame( 
  color = c("blue", "black", "blue", "blue", "black"), 
  value = 1:5) 
~~~
 
##### 3.1.1. 관측점(obervation) 필터링해서 선택하기 (filter)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[df$var01==3 & df$var02$==7]` |`filter(df, var01==3, var02==7)`|


~~~ {.input}
filter(df, color == "blue")
filter(df, value %in% c(1, 4))
~~~

##### 3.1.2. 특정 변수 선택하기 (select)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[, c("var01","var02")]` |`select(df, var01)`|


~~~ {.input}
select(df, color)
select(df, -color)
~~~

##### 3.1.3. 다시 정렬하기 (arrange)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[order(df$var01, df$var02)` |`arrange(df, var01, var02)`|

~~~ {.input}
arrange(df, color)
arrange(df, desc(color))
~~~

##### 3.1.4. 새변수 생성하기 (mutate)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df$new <- df$var01/df$var02` |`df <- mutate(df, new=var01/var02)`|

~~~ {.input}
mutate(df, double = 2 * value)
mutate(df, double = 2 * value, quadruple = 2 * double)
~~~

##### 3.1.5. 변수 요약하기 (summarize)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`aggregate(df$value, list(var01=df$var01), mean)` |`group_by(df, var01) %.% summarize(totalvalue = sum(value))`|


~~~ {.input}
summarise(df, total = sum(value))
by_color <- group_by(df, color) 
summarise(by_color, total = sum(value))
~~~




### 4. R 프로그래밍 모범 사례

[Martin Maechler](http://datascience.la/martin-maechler-invited-talk-at-user-2014-good-practices-in-r-programming/) useR 2014 컨퍼런스에서 "Good Practice in R Programming" 주제로 발표를 했습니다.  

- **Rule 1.** Work with source files !  
    - 원본 소스 파일(R Script) 작업하고 이를 통해 객체나 바이너리 산출물 생성로 일원화  
    - Emacs + ESS(Emacs Speacks Statistics) 혹은 Rstudio 같은 IDE(Integrated Development Environment) 사용

- **Rule 2.** Keep R source well-readable and maintainable
    - 가독성이 뛰어난 소스 코드는 나중에 유지 보수하기 좋다.
    - 들여쓰기(identation), 공백, 70~80 칼럼, 주석처리(하나(``#``)는 코드 끝에, 두개(``##``)는 일반 주석, 세개(``###``)는 코드 블록에 사용)
    - Sweave 혹은 knitr을 사용한다.
    - naming convention을 따른다.

- **Rule 3.** Do read the documentation
    - R 프로그래밍 책을 읽는다.화 V&R "S Programming"
    - R 매뉴얼 참조 : An introduction to R, Writing R extentions
    - R 패키지 Vignettes
    - help.search()
- **Rule 4.** Do learn from the masters
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

- **Rule 5.** Do not Copy and Paste!
    - 이유는 유지보수성이 좋지 않고 복사하면 확장성, 이식성이 떨어진다.
    - 함수(function)을 작성하고, 큰 함수는 잘게 쪼개 작은 함수로 나누어 작성하고, 함수를 사용한다. 

> #### John Chambers {.callout}
>
> Everything that **exists** is an object;  
> Everything that **happens** is a function call.

- **Rule 6.** Strive for clarity and simplicity
    - 자기설명가능한 변수명 사용하고, 간결하게 주석을 섞어 작성
    - 모듈방식 작성   

> #### Venables and Ripley {.callout}
>
> ''Refine and polish your code in the same way you would polish your English prose''

- **Rule 7.** Test your code !
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

- **Rule 8.** Maintain R code in **Packages** (extension of "Test!")
- **Rule 9.** Source code management, Git/GitHub, HG
- **Rule 10.** Rscript or R CMD BATCH *.R should "always" work ! -> Reproducible Data Analysis and Research

> #### R 코딩 규칙 {.callout}
> 
> R 코드를 가독성이 좋으며 이해하기 쉽게 일관되게 작성하는 것이 중요하다. 코딩 규칙에 대한 자세한 사항은 [The State of > Naming Conventions in R](https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) 참조한다.
> 
> - [Bioconductor’s coding standards](http://wiki.fhcrc.org/bioc/Coding_Standards)
> - [Hadley Wickham’s style guide](http://stat405.had.co.nz/r-style.html)
> - [Google’s R style guide](http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html)
> - [Colin Gillespie’s R style guide](http://csgillespie.wordpress.com/2010/11/23/r-style-guide/)



