---
layout: page
title: 데이터 과학
subtitle: 시간데이터
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---

> ## 학습 목표 {.objectives}
>
> *  날짜 및 시간 데이터를 이해하고 처리한다.


### `lubridate` 팩키지 [^lubridate]

날짜-시간 데이터는 작업하기 까다로운데 이유는 형식이 너무나 다양해서, 날짜-시간 정보를 담긴 데이터를 파싱해서 R에 인식시키기가 손이 많이 가기 때문이다. 

이런 문제를 해결하기 위해서 다양한 팩키지들이 개발되어 활용되고 있다. 예를 들어, `chron`, `timeDate`, `zoo`, `xts`, `its`, `tis`, `timeSeries`, `fts`, `tseries` 팩키지가 날짜-시간 데이터를 처리하지만, **`lubridate`** 를 활용하여 살펴본다.

> ### `lubridate` 팩키지 기능 요약 {.callout}
>
> - 날짜-시간 데이터를 식별하고 파싱한다.
> - 년, 월, 일, 시, 분, 초 같은 날짜-시간 구성요소를 추출하고 변형한다.
> - 날짜-시간 사이 기간을 정확하게 계산한다.
> - 시간대와 일광 절약 시간을 처리한다.

#### 기본 R 메쏘드와 `lubridate` 메쏘드 구문 비교 

| 기본 R 메쏘드 | `lubridate` 메쏘드 |
|-------------------------------------------|-------------------------------------------|
| date <- as.POSIXct("01-01-2010", format = "%d-%m-%Y", tz = "UTC") | date <- dmy("01-01-2010") |
| as.numeric(format(date, "%m")) or as.POSIXlt(date)$month + 1 | month(date) |
| date <- as.POSIXct(format(date, "%Y-2-%d"), tz = "UTC") | month(date) <- 2 |
| date <- seq(date, length = 2, by = "-1 day")[2] | date <- date - days(1) |
| as.POSIXct(format(as.POSIXct(date), tz = "UTC"), tz = "GMT") | with_tz(date, "GMT") |


### 날짜-시간 데이터 파싱 [^lubridate-vignette]

`ymd` 함수를 사용해서 연도, 월, 일 문자열 정보를 인자로 넘겨 날짜-시간 자료형으로 변형한다.


```r
library(lubridate)
ymd("20110604")
```

```
FALSE [1] "2011-06-04"
```

```r
mdy("06-04-2011")
```

```
FALSE [1] "2011-06-04"
```

날짜 시간 형식으로 전환하는데 `ymd_hms` 함수가 가장 흔히 사용된다. 시간대를 특정하는데 `tz` 인자를 사용한다.


```r
arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
arrive
```

```
FALSE [1] "2011-06-04 12:00:00 NZST"
```



```r
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")
leave
```

```
FALSE [1] "2011-08-10 14:00:00 NZST"
```

### 날짜-시간 정보 추출

`second`, `minute`, `hour`, `day`, `wday`, `yday`, `week`, `month`, `year`, `tz` 함수를 사용해서 날짜와 시간 정보를
데이터에서 추출한다. `wday`함수와 `month`함수는 선택옵션으로 `label` 인자를 갖게 되어 숫자를 요일과 월명으로 출력할 수 있다.


```r
second(arrive)
```

```
FALSE [1] 0
```

```r
second(arrive) <- 25
arrive
```

```
FALSE [1] "2011-06-04 12:00:25 NZST"
```

```r
second(arrive) <- 0
wday(arrive)
```

```
FALSE [1] 7
```

```r
wday(arrive, label = TRUE)
```

```
FALSE [1] Sat
FALSE Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
```

### 시간대 제어

`with_tz`와 `force_tz` 함수로 시간대 관리 작업을 제어한다.


```r
meeting <- ymd_hms("2011-07-01 09:00:00", tz = "Pacific/Auckland")
with_tz(meeting, "America/Chicago")
```

```
FALSE [1] "2011-06-30 16:00:00 CDT"
```

약속시간을 잘못알아 시간대를 변경할 경우 `force_tz` 함수로 시간대를 변경한다.


```r
mistake <- force_tz(meeting, "America/Chicago")
with_tz(mistake, "Pacific/Auckland")
```

```
FALSE [1] "2011-07-02 02:00:00 NZST"
```


### 시간 간격

`interval` 함수를 사용해서 시간 간격(time interval)을 계산할 수 있다.


```r
auckland <- interval(arrive, leave) 
auckland
```

```
FALSE [1] 2011-06-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
```

동일하게 `%--%` 함수를 사용해서도 가능하다.


```r
auckland <- arrive %--% leave
auckland
```

```
FALSE [1] 2011-06-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
```

시간 간격이 겹치는지 확인하고자 새로운 시간 간격 객체를 생성하자.


```r
jsm <- interval(ymd(20110720, tz = "Pacific/Auckland"), ymd(20110831, tz = "Pacific/Auckland"))
jsm
```

```
FALSE [1] 2011-07-20 NZST--2011-08-31 NZST
```

두 시간 간격이 겹치는지 확인해 보자.


```r
int_overlaps(jsm, auckland)
```

```
FALSE [1] TRUE
```

그 외에도 `setdiff`, `int_start`, `int_end`, `int_flip`, `int_shift`, `int_aligns`, `union`, `intersect`, `setdiff`, `%within%` 
다양한 함수를 통해 작업이 가능하다.


```r
setdiff(auckland, jsm)
```

```
FALSE [1] 2011-06-04 12:00:00 NZST--2011-07-20 NZST
```

### 날짜 시간 산술 연산

기간(interval)은 특정 기간이다. 즉, 특정된 날짜에 구속된다. `lubridate` 함수는 *duration* 과 *period* 클래스를 제공한다.


```r
minutes(2) ## period
```

```
FALSE [1] "2M 0S"
```


```r
dminutes(2) ## duration
```

```
FALSE [1] "120s (~2 minutes)"
```

기간(duration)의 경우 1년은 항상 365일이 되지만, 시기(Period)는 시각표가 직관적으로 제시하는 것과 같은 방식으로 변동하게 된다.
예를 들어, 기간은 윤년이 있는 경우 정직하게 숫자를 제시하지만, 시기는 예상하는 바를 제시하게 된다.


```r
leap_year(2011) ## regular year
```

```
FALSE [1] FALSE
```

```r
ymd(20110101) + dyears(1)
```

```
FALSE [1] "2012-01-01"
```

```r
ymd(20110101) + years(1)
```

```
FALSE [1] "2012-01-01"
```

```r
leap_year(2012) ## leap year
```

```
FALSE [1] TRUE
```

```r
ymd(20120101) + dyears(1)
```

```
FALSE [1] "2012-12-31"
```

```r
ymd(20120101) + years(1)
```

```
FALSE [1] "2013-01-01"
```

기간과 시기를 사용해서 날짜-시간에 대한 기본 연산도 할 수 있다.



```r
meetings <- meeting + weeks(0:5)
meetings %within% jsm
```

```
FALSE [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE
```

오클랜드에 얼마나 머무를까?


```r
auckland / ddays(1)
```

```
FALSE [1] 67.08333
```

```r
auckland / ddays(2)
```

```
FALSE [1] 33.54167
```

```r
auckland / dminutes(1)
```

```
FALSE [1] 96600
```

나머지 연산자와 정수 나눗셈을 할 수도 있다.


```r
auckland %/% months(1)
```

```
FALSE [1] 2
```

```r
auckland %% months(1)
```

```
FALSE [1] 2011-08-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
```

```r
as.period(auckland %% months(1))
```

```
FALSE [1] "6d 2H 0M 0S"
```

```r
as.period(auckland)
```

```
FALSE [1] "2m 6d 2H 0M 0S"
```

### 벡터화

`lubridate`는 벡터화가 되어 있어 바로 함수와 인터랙티브한 방식으로 적용이 가능하다.


```r
last_day <- function(date) {
  ceiling_date(date, "month") - days(1)
}
```



[^lubridate]: [Dates and Times Made Easy with lubridate](https://www.jstatsoft.org/article/view/v040i03)

[^lubridate-vignette]: [lubridate 소품문](https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html)
