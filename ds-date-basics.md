---
layout: page
title: 데이터 과학
subtitle: 시간 데이터 기초
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * 시간데이터에 대한 기초 지식을 살펴본다.
> * 시간 데이터를 관장하는 주요 R 팩키지를 살펴본다.

## 1. 날짜와 시간 [^coursera-dates-and-time]

[^coursera-dates-and-time]: [Coursera Lecture 41 - Dates and Times](https://www.coursera.org/learn/r-programming/lecture/yl7BO/dates-and-times)

날짜정보와 시간정보는 R에서 다른 클래스를 통해 구현된다. 날짜(Date)는 `1970-01-01`을 기준으로 R 내부적으로 정수형으로 저장되고,
시간(Time)도 R 내부적으로 `1970-01-01`을 기준으로 초단위로 저장된다.

- 날짜(Date): `Date` 클래스
- 시간(time): `POSIXct`, `POSIXlt` 클래스
    - `POSIXct` 클래스는 매우 큰 정수로 시간정보를 데이터프레임으로 저장할 때 유용하다.
    - `POSIXlt` 클래스는 리스트 자료형으로 요일, 년, 월, 일 등의 정보를 리스트 내부 원소로 저장되어 유용하다.


~~~{.r}
x <- as.Date("1970-01-01")
x
~~~



~~~{.output}
[1] "1970-01-01"

~~~



~~~{.r}
unclass(x)
~~~



~~~{.output}
[1] 0

~~~



~~~{.r}
unclass(as.Date("1970-01-03"))
~~~



~~~{.output}
[1] 2

~~~

### 1.1. 날짜 자료형 확인

`Sys.time()` 함수를 통해 현재 시스템 시간정보를 받아내면 `POSIXct` 클래스임이 확인되고,
`unclass()` 정보를 통해 내부적으로 정수값으로 저장된 것이 확인된다.


~~~{.r}
x <- Sys.time()
x
~~~



~~~{.output}
[1] "2016-11-27 23:49:30 KST"

~~~



~~~{.r}
unclass(x)
~~~



~~~{.output}
[1] 1480258171

~~~

문자열을 받아 `as.POSIXlt()`, `as.POSIXct()` 함수를 사용해서 시간자료형으로 변환시킨다.
`POSIXlt` 자료형으로 변환시킨 경우 리스트로 저장되어 있어 시, 분, 초, 요일등 하위 원소값으로 뽑아낼 수 있다.


~~~{.r}
x <- Sys.time()
x
~~~



~~~{.output}
[1] "2016-11-27 23:49:30 KST"

~~~



~~~{.r}
p <- as.POSIXlt(x)
names(unclass(p))
~~~



~~~{.output}
 [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"  
 [8] "yday"   "isdst"  "zone"   "gmtoff"

~~~



~~~{.r}
p$wday
~~~



~~~{.output}
[1] 0

~~~

### 1.2. 날짜, 시간 자료형 변환

결국 문자열을 받아 날짜, 시간 자료형으로 변환시키는데 `strptime()` 함수를 사용한다.
문자열을 입력으로 받아 문자열의 날짜, 시간 형식을 매칭하여 넘기게 되면 날짜, 시간 자료형으로 변환된다.


~~~{.r}
datestring <- c("2006-01-08 10:07:52", "2006-08-07 19:33:02")
x <- strptime(datestring, "%Y-%m-%d %H:%M:%S", tz = "EST5EDT")
x
~~~



~~~{.output}
[1] "2006-01-08 10:07:52 EST" "2006-08-07 19:33:02 EDT"

~~~



~~~{.r}
class(x)
~~~



~~~{.output}
[1] "POSIXlt" "POSIXt" 

~~~

### 1.3. 날짜, 시간 데이터 기본 연산

문자열 데이터를 날짜 시간 자료형으로 변환시키게 되면 컴퓨터 내부적으로 윤년, 윤초, 일광절약시간, 표준시간대를 자동으로 계산해 준다.
"2012-03-01", "2012-02-28" 두 날짜사이는 보통 하루 차이가 나지만 윤년이 있는 경우 이틀이 된다. 


~~~{.r}
x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y
~~~



~~~{.output}
Time difference of 2 days

~~~

시간이 5시간 차이가 나지만, 표준시간대가 다른 경우 한 시간 차이만 난다.


~~~{.r}
x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
y - x
~~~



~~~{.output}
Time difference of 14 hours

~~~

## 2. 날짜 시간 R 팩키지 [^r-date-time-packages]

[^r-date-time-packages]: [Working with xts and quantmod-Leveraging R with xts and quantmod for quantitative trading](http://www.rinfinance.com/RinFinance2009/presentations/xts_quantmod_workshop.pdf)

날짜와 시간을 다루기 위한 팩키지가 다수 개발되었다. 기존 `Data` 클래스에 시계열 데이터를 다루기도 하고, `Time` 클래스에서 데이터를 다루기 한다.
종류도 많고 접근방법도 다양하다.

| `Data` 클래스 | `Time` 클래스 |
|---------------|---------------|
| timeSeries    | chron         |
| its           | POSIXct       |
| irts          | POSIXlt       |
| matrix        | yearmon       |
| tframe        | Date          |
| mts           | character     |
| zoo           | numeric       |
| irts          | yearqtr       |
| ts            | timeDate      |
| zooreg        |               |
| vectors       |               |

> ### ISO 8601 - 날짜와 시간 데이터 교환을 위한 국제 표준 [^iso-8601] {.callout}
> 
> **ISO 8601**(Data elements and interchange formats - Information interchange - Representation of dates and times) 표준은 
> 국제 표준화 기구(ISO)에 의해 공포되었으며 1988년에 처음으로 공개었고, 표준 제정 목적은 
> 날짜와 시간을 표현함에 있어 명백하고 잘 정의된 방법을 제공함으로써, 
> 날짜와 시간의 숫자 표현에 대한 오해를 줄이고자 한다. 보편적 원칙은 다음과 같다.
> 
> - 날짜와 시간 값은 시간 단위의 가장 큰 것부터 가장 작은 것으로 정렬된다: 년도, 월(혹은 주), 일, 시, 분, 초, 그리고 초보다 더 작은 단위.
> - 날짜와 시간은 각각 앞에 0을 붙여서(leading zeros) 유지해야 하는 고정된 자릿수(fixed number of digits)를 갖는다.
> - 표현은 두 가지 형식 중 한 가지로 이루어질 수 있다. 하나는 최소한의 구분자를 이용한 기본 형식이고 다른 하나는 가독성을 높이기 위해 추가된 구분자를 이용한 확장 형식이다. 
>     - 예를 들어, 2009년 1월 6일은 확장 형식으로 "2009-01-06"으로 쓰일 수 있으며, 애매모호함 없이 기본 형식에서는 "20090106"으로 간단히 쓰일 수 있다.
> - 줄어든 정밀도를 위해, 날짜와 시간 표현에서 값들 중 어떤 숫자든지 제외될 수 있으나, 큰 단위가 앞에, 작은 단위가 뒤로 오는 순서는 유지해야 한다. 
>     - 예를 들어, "2004-05"는 2004년 5월을 가르키는 유효한 ISO 8601 날짜이다. 이 형식은 결코 2004년의 지정되지 않은 달의 5일을 표현하는 것이 아니며 2004년부터 2005년 사이의 기간을 말하는 것이 아니다.
> - 특정 애플리케이션에서의 필요성으로, 표준에서는 표현 내에서의 가장 작은 단위의 시간 값에 십진수 기반의 분수를 지원하고 있다.

[^iso-8601]: [위키피디아 - ISO 8601](https://ko.wikipedia.org/wiki/ISO_8601)



