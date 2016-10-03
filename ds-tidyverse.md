---
layout: page
title: 데이터 과학
subtitle: 데이터 정제
---
> ## 학습 목표 {.objectives}
>
> * 왜 데이터 정제인가?
> * 데이터 정제 문제에 대한 R진영 해결책을 이해한다.
> * 사람과 컴퓨터를 작업 최적화를 위한 접점을 찾아본다.

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




