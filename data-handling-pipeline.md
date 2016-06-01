---
layout: page
title: 데이터 과학
subtitle: 데이터분석을 위한 파이프라인
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---

> ## 학습 목표 [^pipeline-webinar] {.objectives}
>
> * 데이터 분석용 파이프라인을 이핸한다. 


[^pipeline-webinar]: [Pipelines for data analysis in R](https://www.rstudio.com/resources/webinars/pipelines-for-data-analysis-in-r/)

### 데이터 분석 파이프라인

데이터 분석은 다른 소프트웨어 개발과 동일하게 **컴퓨터 시간(Computer time)**과 
**개발자 시간(Human time)**을 최적화하는 과정으로 볼 수 있다.
최근에 가장 귀중한 자원은 컴퓨터가 아니라 개발자 시간 즉, 사람이다.

따라서, 사람 시간을 최적화하는 것이 데이터 분석에서 가장 중요한 요소가 되면 그 해답이
**%>%** 즉, `magrittr` 팩키지에 있다. 
프랑스 액센트가 들어간 [magrittr](https://cran.r-project.org/web/packages/magrittr/) 팩키지는 
개발시간을 단축하고 코드 가독성을 높이고 유지보수성을 높이는 목적을 갖고 있다.
유닉스 쉘, F#, haskell, clojure, method chaining에 영감을 받았다.


> ### 데이터 분석 정의 {.callout}
>
> 데이터 분석은 데이터가 이해되고, 지식이 되고, 통찰을 얻게 되는 과정이다.
> "Data analysis is the process by which data becomes understanding, knowledge and insight"  
> --- Hadley Wickham


### `magrittr` 코드와 일반 R 코드 비교 [^magrittr-vignette]

`mtcars` 데이터셋을 파이프를 통해 데이터를 깔끔하게 정리하는 것과 기존 전통적 방식으로 개발된 코드를 비교해 보자.


~~~{.r}
library(magrittr)

car_data <- 
  mtcars %>%
  subset(hp > 100) %>%
  aggregate(. ~ cyl, data = ., FUN = . %>% mean %>% round(2)) %>%
  transform(kpl = mpg %>% multiply_by(0.4251)) %>%
  print
~~~



~~~{.output}
FALSE   cyl   mpg   disp     hp drat   wt  qsec   vs   am gear carb       kpl
FALSE 1   4 25.90 108.05 111.00 3.94 2.15 17.75 1.00 1.00 4.50 2.00 11.010090
FALSE 2   6 19.74 183.31 122.29 3.59 3.12 17.98 0.57 0.43 3.86 3.43  8.391474
FALSE 3   8 15.10 353.10 209.21 3.23 4.00 16.77 0.00 0.14 3.29 3.50  6.419010

~~~

전통적인 R코드는 본인이 작성하지 않았다면 해독하기가 만만치 않고, 괄호가 많다.


~~~{.r}
car_data <- 
  transform(aggregate(. ~ cyl, 
                      data = subset(mtcars, hp > 100), 
                      FUN = function(x) round(mean(x, 2))), 
            kpl = mpg*0.4251)
~~~

결국 읽기 어렵고 이해하기 힘든 함수 조합을 가독성 높은 순열(sequence)로 변환하는 역할을 한다.


~~~{.r}
x %>% f(y)
# f(x, y)
x %>% f(z, .)
# f(z, x)
x %>% f(y) %>% g(z)
# g(f(x, y), z)
~~~

### 데이터 분석을 위한 파이프라인 팩키지 모음

데이터 분석을 위한 파이프라인은 유닉스 파이프와 마찬가지로 입력유형과 출력유형이 동일해야만 된다는 속성을 만족해야만 된다.

- tidyr: 깔끔한 데이터를 위한 파이프라인
- dplyr: 데이터 조작을 위한 파이프라인
- ggvis: 시각화를 위한 파이프라인
- rvest: HTML을 위한 파이프라인
- purrr: 리스트를 위한 파이프라인
- xml2: XML을 위한 파이프라인
- stringr: 문자열을 위한 파이프라인

### 1. 깔끔한 데이터 `tidyr`


~~~{.r}
library(tidyr)
library(readr)
library(dplyr, warn.conflicts = FALSE)
library(curl)

# 데이터 가져오기
tb <- tbl_df(read_csv(url("https://raw.githubusercontent.com/hadley/tidyr/master/vignettes/tb.csv")))
tb
~~~



~~~{.output}
FALSE Source: local data frame [5,769 x 22]
FALSE 
FALSE     iso2  year   m04  m514  m014 m1524 m2534 m3544 m4554 m5564   m65    mu
FALSE    (chr) (int) (int) (int) (int) (int) (int) (int) (int) (int) (int) (int)
FALSE 1     AD  1989    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 2     AD  1990    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 3     AD  1991    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 4     AD  1992    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 5     AD  1993    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 6     AD  1994    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
FALSE 7     AD  1996    NA    NA     0     0     0     4     1     0     0    NA
FALSE 8     AD  1997    NA    NA     0     0     1     2     2     1     6    NA
FALSE 9     AD  1998    NA    NA     0     0     0     1     0     0     0    NA
FALSE 10    AD  1999    NA    NA     0     0     0     1     1     0     0    NA
FALSE ..   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...
FALSE Variables not shown: f04 (int), f514 (int), f014 (int), f1524 (int), f2534
FALSE   (int), f3544 (int), f4554 (int), f5564 (int), f65 (int), fu (int)

~~~



~~~{.r}
# 자료분석을 위한 형태로 변형한다.
tb2 <- tb %>%
  gather(demographic, n, m04:fu, na.rm = TRUE)
tb2
~~~



~~~{.output}
FALSE Source: local data frame [35,750 x 4]
FALSE 
FALSE     iso2  year demographic     n
FALSE    (chr) (int)       (chr) (int)
FALSE 1     AD  2005         m04     0
FALSE 2     AD  2006         m04     0
FALSE 3     AD  2008         m04     0
FALSE 4     AE  2006         m04     0
FALSE 5     AE  2007         m04     0
FALSE 6     AE  2008         m04     0
FALSE 7     AG  2007         m04     0
FALSE 8     AL  2005         m04     0
FALSE 9     AL  2006         m04     1
FALSE 10    AL  2007         m04     0
FALSE ..   ...   ...         ...   ...

~~~



~~~{.r}
# 변수를 성별과 연령으로 쪼갠다.
tb3 <- tb2 %>%
  separate(demographic, c("sex", "age"), 1)
tb3
~~~



~~~{.output}
FALSE Source: local data frame [35,750 x 5]
FALSE 
FALSE     iso2  year   sex   age     n
FALSE    (chr) (int) (chr) (chr) (int)
FALSE 1     AD  2005     m    04     0
FALSE 2     AD  2006     m    04     0
FALSE 3     AD  2008     m    04     0
FALSE 4     AE  2006     m    04     0
FALSE 5     AE  2007     m    04     0
FALSE 6     AE  2008     m    04     0
FALSE 7     AG  2007     m    04     0
FALSE 8     AL  2005     m    04     0
FALSE 9     AL  2006     m    04     1
FALSE 10    AL  2007     m    04     0
FALSE ..   ...   ...   ...   ...   ...

~~~



~~~{.r}
tb4 <- tb3 %>%
  rename(country = iso2) %>%
  arrange(country, year, sex, age)
tb4
~~~



~~~{.output}
FALSE Source: local data frame [35,750 x 5]
FALSE 
FALSE    country  year   sex   age     n
FALSE      (chr) (int) (chr) (chr) (int)
FALSE 1       AD  1996     f   014     0
FALSE 2       AD  1996     f  1524     1
FALSE 3       AD  1996     f  2534     1
FALSE 4       AD  1996     f  3544     0
FALSE 5       AD  1996     f  4554     0
FALSE 6       AD  1996     f  5564     1
FALSE 7       AD  1996     f    65     0
FALSE 8       AD  1996     m   014     0
FALSE 9       AD  1996     m  1524     0
FALSE 10      AD  1996     m  2534     0
FALSE ..     ...   ...   ...   ...   ...

~~~

### 2. 변환 `dplyr`

- select: 데이터테이블에서 변수를 뽑아낸다.
- filter: 값으로 관측점을 뽑아낸다.
- mutate: 신규 변수를 생성한다. (log 변환)
- summarise: 관측점을 하나로 축약한다. (평균)
- arrange: 관측점을 오름차순, 내림차순으로 정렬한다.

### 3. 시각화 `ggvis`

- ggplot2
- shiny
- dplyr 파이프라인
- vega 

### 4. 모형 `broom`

모형은 알려진 패턴을 제거하는데 탁월하다.


~~~{.r}
library(tidyr)
library(dplyr)
library(ggplot2)
library(broom)

tx <- 
  readRDS("tx-housing.rds") %>%
  mutate(date = year + (month - 1) / 12) %>%
  filter(!(city %in% c("Texas Totals", "Palestine")))
tx

ggplot(tx, aes(date, log(sales))) + 
  geom_line(aes(group = city), alpha = 1/2)
ggsave("sales.pdf", width = 8, height = 6)


# Models as a tool --------------------------------------------------------
tx <- tx %>% 
  group_by(city) %>% 
  mutate(
    resid = 
      lm(log(sales) ~ factor(month), na.action = na.exclude) %>%
      resid()
  )

ggplot(tx, aes(date, resid)) +
  geom_line(aes(group = city), alpha = 1/5) + 
  geom_line(stat = "summary", fun.y = "mean", colour = "red")
~~~

### 5. 빅데이터 

| 구분  |  데이터 크기 |
|--------------|--------------|
| 매우 큰 데이터 | 컴퓨터 한대 메모리에 저장될 수 없는 크기 : **>5 TB** |
| 중간 데이터 | 서버 컴퓨터 메모리에 저장할 수 있는 크기 : **10 GB -- 5 TB** |
| 작은 데이터 | 노트북 컴퓨터 메모리에 저장할 수 있는 크기 : **<10 GB |

전통적으로 R은 작은 데이터를 빠르게 탐색하는데 최적의 환경을 제공한다.
중간크기 데이터를 작업하지 못할 기술적인 이유는 없지만, 거의 작업이 이뤄지지 않고 있다.

빅데이터를 처리하는 전략

1. 요약/표본추출/부분집합 추출 (90%)
2. 작은 데이터 문제로 쪼개서 분할 정복 (9%)
3. 더이상 어찌할 수 없는 큰 문제 데이터 (1%)

### 참고자료

[^magrittr-vignette]: [Library magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
