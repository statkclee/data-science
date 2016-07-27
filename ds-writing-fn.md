---
layout: page
title: 데이터 과학
subtitle: R 함수 작성
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * R 함수를 작성한다.

### 1. 함수 작성

함수를 정의할 때 함수명(`my_fun`)을 먼저 적고 대입 연산자(`<-`)를 작성하고 
예약어 `function` 을 적어 나서 인자(`arg1`, `arg2`)를 정의한다. 그리고 함수 몸통을 적성한다.


~~~{.r}
my_fun <- function(arg1, arg2) {
    함수 몸통부분
}
~~~



~~~{.output}
Error: <text>:2:12: 예상하지 못한 기호(symbol)입니다.
1: my_fun <- function(arg1, arg2) {
2:     함수 몸통부분
              ^

~~~

예를 들어, 두 수를 더하여 합을 구하는 `add` 함수를 정의해 보자. 함수명 `add`를 적고 나서 
예약어 `function`을 적고 나서 인자 `x`, `y`를 선언한다. 그리고 나서 함수몸통부분에 두 수를 더하는 로직 
`x + y` 를 정의한다. 


~~~{.r}
add <- function(x, y = 1) {
    x + y
}
~~~

#### 1.1. 함수 해부

`add` 상기 함수를 `formals`, `body`, `environment` 명령어를 통해 해부할 수 있다. 


~~~{.r}
formals(add)
~~~



~~~{.output}
$x


$y
[1] 1

~~~



~~~{.r}
body(add)
~~~



~~~{.output}
{
    x + y
}

~~~



~~~{.r}
environment(add)
~~~



~~~{.output}
<environment: R_GlobalEnv>

~~~

#### 1.2. 함수 반환값

R에서 명시적으로 `return` 예약어를 사용해서 반환하기도 하지만, `return` 예약어로 명시하지 않는 경우
함수몸통부문 마지막 표현식이 평가되어 반환된다.


~~~{.r}
f <- function(x) {
    if (x < 0) {
        -x
    } else {
        x
    }
}
~~~

상기 함수 `f`는 숫자를 받아 양수면 양수로, 음수면 양수로 절대값으로 변환하는 함수다.


~~~{.r}
f(-5)
~~~



~~~{.output}
[1] 5

~~~



~~~{.r}
f(15)
~~~



~~~{.output}
[1] 15

~~~

#### 1.3. 함수는 객체다.

함수는 일반 R 객체처럼 다룰 수 있다.


~~~{.r}
mean2 <- mean

mean2(1:10)
~~~



~~~{.output}
[1] 5.5

~~~



~~~{.r}
function(x) { x + 1 }
~~~



~~~{.output}
function(x) { x + 1 }

~~~



~~~{.r}
(function(x) { x + 1 })(2)
~~~



~~~{.output}
[1] 3

~~~

`mean` 함수로 `mean2` 객체를 생성시킬 수 있고, 인자를 받아 평균을 계산하고, 이름없는 함수에 인자를 넣어 계산도 가능하다.


### 2. 함수 유효 범위(Scope)

함수 유효범위(Scoping)는 명칭으로 값을 R이 찾는 방법으로 함수 내부에 명칭이 정의하지 않는 경우 한단계 상위 수준에서 R이 자동으로 검색한다.


~~~{.r}
x <- 2

g <- function() {
    y <- 1
    c(x, y)
}

g()
~~~



~~~{.output}
[1] 2 1

~~~

변수명이 함수내부에서 지역적으로 정의되지 않고, 상위 수준에서도 정의되지 않는 경우 오류가 발생된다.


~~~{.r}
rm(x) # 변수 x를 제거

g <- function() {
    y <- 1
    c(x, y)
}

g()
~~~



~~~{.output}
Error in g(): 객체 'x'를 찾을 수 없습니다

~~~

유효범위는 값을 찾는 장소를 정의하지만, 시간을 정의하지는 않는다. 


~~~{.r}
f <- function() x

x <- 15
f()
~~~



~~~{.output}
[1] 15

~~~



~~~{.r}
x <- 20
f()
~~~



~~~{.output}
[1] 20

~~~

변수와 마찬가지로, 검색(lookup)도 함수에 대해 동일하게 적용된다.


~~~{.r}
l <- function(x) x + 1

m <- function() {
    l <- function(x) x * 2
    l(10)
}

m()
~~~



~~~{.output}
[1] 20

~~~

함수를 호출할 때마다 새로 시작되는 자체 환경이 새롭게 준비되고, 새로운 환경이 인자값과 함께 제공된다.
객체는 그 자체 환경을 먼저 검색하고 만약, 찾는 것이 없으면 함수가 생성된 환경에서 검색을 재개한다.


~~~{.r}
j <- function() {
    if (!exists("a")) {
        a <- 1
    } else {
        a <- a + 1
    }
        print(a)
}

j()
~~~



~~~{.output}
[1] 1

~~~



~~~{.r}
j()
~~~



~~~{.output}
[1] 1

~~~



~~~{.r}
a
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'a'를 찾을 수 없습니다

~~~

### 3. 자료구조

6가지 **원자 벡터** 와 리스트가 자료구조로 R에 존재한다.
원자벡터는 `logical`, `integer`, `double`, `character`, `complex`, `raw` 가 있고, 자료가 모두 동일해야 한다.
반면에 리스트는 이질적인 원자벡터를 포함할 수 있다.

#### 3.1. 결측값

* `NULL`: 벡터가 존재하지 않는 경우를 표현하는데 사용된다.
* `NA`: 벡터에 빠진 값을 표현하는데 사용된다.


~~~{.r}
typeof(NULL)
~~~



~~~{.output}
[1] "NULL"

~~~



~~~{.r}
length(NULL)
~~~



~~~{.output}
[1] 0

~~~



~~~{.r}
typeof(NA)
~~~



~~~{.output}
[1] "logical"

~~~



~~~{.r}
length(NA)
~~~



~~~{.output}
[1] 1

~~~

벡터 내부에 `NA` 가 존재하는 경우 `is.na` 함수를 통해 검출가능하다.


~~~{.r}
x <- c(1, 2, 3, NA, 5)

x
~~~



~~~{.output}
[1]  1  2  3 NA  5

~~~



~~~{.r}
is.na(x)
~~~



~~~{.output}
[1] FALSE FALSE FALSE  TRUE FALSE

~~~

#### 3.2. `NA`는 전염된다.


~~~{.r}
NA + 10
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
NA / 2
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
NA > 5
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
10 == NA
~~~



~~~{.output}
[1] NA

~~~



~~~{.r}
NA == NA
~~~



~~~{.output}
[1] NA

~~~

#### 3.3. 리스트

리스트는 다른 형태 객체를 담을 수 있다는 점에서 유용한데, 복잡하게 반환되는 객체는 거의 리스트다. 예를 들어 회귀분석, `lm()` 에서 반환되는 객체를 살펴보면 쉽게 이해된다.

`list()` 함수로 리스트를 생성하고, `[`, `[[`, `$` 을 통해 부분집합을 뽑아낸다.

* `[`: 리스트가 포함한 하위 리스트를 뽑아낸다.
* `[[`, `$`: 원소를 추출하고, 계층구조 수준을 한단계 제거한다.


~~~{.r}
a <- list(
    a = 1:3,
    b = "a string",
    c = pi,
    d = list(-1, -5)
)

str(a[4])
~~~



~~~{.output}
List of 1
 $ d:List of 2
  ..$ : num -1
  ..$ : num -5

~~~



~~~{.r}
str(a[[4]])
~~~



~~~{.output}
List of 2
 $ : num -1
 $ : num -5

~~~

<img src="fig/ds-writing-r-fun-subset.png" alt="리스트 부분집합 추출" width="50%" />


