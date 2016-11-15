# 데이터 과학



> ## 학습 목표 {.objectives}
>
> *  R 데이터 정렬 연습문제를 풀어본다. 


### 정렬 문제 정의 및 개념 이해 [^sort-ex] [^sort-sol]

[^sort-ex]: [Get-your-stuff-in-order exercises](http://www.r-bloggers.com/get-your-stuff-in-order-exercises/)
[^sort-sol]: [Get-your-stuff-in-order: solutions](http://r-exercises.com/2016/03/01/get-your-stuff-in-order-solutions/)

[http://www.r-bloggers.com/](http://www.r-bloggers.com/)에 올라온 블로그 내용을 번역한 것이다.
처음 [http://r-exercises.com](http://r-exercises.com) 사이트에 게시된 것으로 
최근에 r-bloggers에 기여한 블로그다.

<img src="fig/data-handling_quicksort_anim.gif" alt="Quicksort animation" width="77%" />
이미지 출처: [RolandH, GFDL, CC-BY-SA-3.0 or CC BY-SA 2.5-2.0-1.0, Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3ASorting_quicksort_anim.gif)

### 1.번 정렬 문제

#### 1.1. 문제 정의

벡터 `1,3,2,5,4` 를 오름차순과 내림차순으로 정렬하시오.


~~~{.r}
x <- c(1, 3, 2, 5, 4)
~~~
#### 1.2. 문제 해답

붙박이 내장함수 `sort` 를 사용하고, `decreasing` 인자에 오름차순과 내림차순 값을 명시한다.


~~~{.r}
sort(x, decreasing = FALSE)
~~~



~~~{.output}
[1] 1 2 3 4 5

~~~



~~~{.r}
sort(x, decreasing = TRUE)
~~~



~~~{.output}
[1] 5 4 3 2 1

~~~

### 2.번 정렬 문제

#### 2.1. 문제 정의

`5 곱하기 5` 행렬을 특정 행기준, 특정 열기준 내림차순 정렬한다.
특정 행과 열로 각각 2번째 행과 열을 기준으로 삼는다.
즉, 특정 행 혹은 열기준 값에 맞춰 모든 행과 열을 내림차순 혹은 오름차순으로 정렬한다.

`round(runif(25,1,100),0)` 명령어는 `runif` 함수로 25개 균등분포 난수를 뽑아내는데
범위는 1에서 100사이가 되고, `round` 함수로 반올림하는데 0을 인자로 넘겨 소수점은 없앤다.


~~~{.r}
x <- matrix(round(runif(25,1,100),0), ncol=5)
~~~

#### 2.2. 문제 해답

`order` 함수를 사용하여 정렬을 하는데, 인자 값으로 두번째 열을 기준으로 
`-` 부호를 앞에 넣어 기본설정된 내림차순을 오름차순으로 변경한다.
동일하게 order 인자값으로 두번째 행을 기준으로 선택하면, 행기준으로 내림차순 정렬된다.


~~~{.r}
x <- matrix(round(runif(25,1,100),0), ncol=5)
x1 <- x[order(-x[,2]), ]
x2 <- x[, order(-x[2, ])]
x
~~~



~~~{.output}
     [,1] [,2] [,3] [,4] [,5]
[1,]   96   41   82   35   11
[2,]   91   50   60   87   95
[3,]   45   23   23   25   84
[4,]   24   75   54   99   30
[5,]   64   90   12   55   72

~~~



~~~{.r}
x1
~~~



~~~{.output}
     [,1] [,2] [,3] [,4] [,5]
[1,]   64   90   12   55   72
[2,]   24   75   54   99   30
[3,]   91   50   60   87   95
[4,]   96   41   82   35   11
[5,]   45   23   23   25   84

~~~



~~~{.r}
x2
~~~



~~~{.output}
     [,1] [,2] [,3] [,4] [,5]
[1,]   11   96   35   82   41
[2,]   95   91   87   60   50
[3,]   84   45   25   23   23
[4,]   30   24   99   54   75
[5,]   72   64   55   12   90

~~~

### 3.번 정렬 문제

#### 3.1. 문제 정의

특정열 1번 열만 오름차순으로 정렬하고 나머지 열은 그대로 둔다.


~~~{.r}
x <- matrix(round(runif(25,1,100),0), ncol=5)
~~~

#### 3.2. 문제 해답

`sort` 함수로 특정 1번 열을 정렬하여 이를 다시 원 행렬에 꽂아 넣는다. 


~~~{.r}
x
~~~



~~~{.output}
     [,1] [,2] [,3] [,4] [,5]
[1,]   64   45    4   93   57
[2,]   39   69   34   91   88
[3,]   91   51   23   62   21
[4,]   31   67   80   36   50
[5,]   54   43   41   30   70

~~~



~~~{.r}
x[,1] <- sort(x[,1])
~~~

### 4.번 정렬 문제

#### 4.1. 문제 정의

특정열 1번 열만 오름차순으로 정렬하고 나머지 열은 그대로 둔다.


~~~{.r}
library(datasets)
# install.packages(datasets)
? women
~~~

- `women` 데이터를 열어보지 않고 `height`와 `weight`가 정렬되었는지 확인한다.
- `bmi` 변수를 `BMI = ( Weight / (Height) x (Height) ) x 703` 공식에 맞춰 생성한다.
단, 체중은 kg, 신장은 인치가 단위다.
- 행은 `bmi` 순으로 내림차순 정렬하고, 열은 칼럼명 알파벳 순으로 정렬한다.


#### 4.2. 문제 해답

- 신장과 체중 칼럼이 각각 정렬되어 있는지 확인한다.


~~~{.r}
is.unsorted(women$height)
~~~



~~~{.output}
[1] FALSE

~~~



~~~{.r}
is.unsorted(women$weight)
~~~



~~~{.output}
[1] FALSE

~~~

- bmi 변수를 공식에 맞춰 생성한다.


~~~{.r}
women$bmi <- women$weight  / women$height^2 * 703
is.unsorted(women$bmi)
~~~



~~~{.output}
[1] TRUE

~~~

- 행은 `bmi`로 열은 알파벳 순으로 정렬한다.


~~~{.r}
women <- women[order(women$bmi), sort(names(women))]
~~~

### 5.번 정렬 문제

#### 5.1. 문제 정의

- `Plant` 변수기준으로 내림차순 정렬한다. `Plant` 변수는 요인으로,
`str` 함수로 순서있는 요인변수임을 확인한다.
- `Plant`(알파벳 순서)을 기준으로 `uptake`을 오름차순으로 정렬한다.
- `Plant`(역알파벳 순서)을 기준으로 `uptake`을 오름차순으로 정렬한다.



~~~{.r}
library(datasets)
# install.packages(datasets)
? CO2
head(CO2)
~~~



~~~{.output}
  Plant   Type  Treatment conc uptake
1   Qn1 Quebec nonchilled   95   16.0
2   Qn1 Quebec nonchilled  175   30.4
3   Qn1 Quebec nonchilled  250   34.8
4   Qn1 Quebec nonchilled  350   37.2
5   Qn1 Quebec nonchilled  500   35.3
6   Qn1 Quebec nonchilled  675   39.2

~~~



~~~{.r}
str(CO2)
~~~



~~~{.output}
Classes 'nfnGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':	84 obs. of  5 variables:
 $ Plant    : Ord.factor w/ 12 levels "Qn1"<"Qn2"<"Qn3"<..: 1 1 1 1 1 1 1 2 2 2 ...
 $ Type     : Factor w/ 2 levels "Quebec","Mississippi": 1 1 1 1 1 1 1 1 1 1 ...
 $ Treatment: Factor w/ 2 levels "nonchilled","chilled": 1 1 1 1 1 1 1 1 1 1 ...
 $ conc     : num  95 175 250 350 500 675 1000 95 175 250 ...
 $ uptake   : num  16 30.4 34.8 37.2 35.3 39.2 39.7 13.6 27.3 37.1 ...
 - attr(*, "formula")=Class 'formula' length 3 uptake ~ conc | Plant
  .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
 - attr(*, "outer")=Class 'formula' length 2 ~Treatment * Type
  .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
 - attr(*, "labels")=List of 2
  ..$ x: chr "Ambient carbon dioxide concentration"
  ..$ y: chr "CO2 uptake rate"
 - attr(*, "units")=List of 2
  ..$ x: chr "(uL/L)"
  ..$ y: chr "(umol/m^2 s)"

~~~



~~~{.r}
unique(CO2$Plant)
~~~



~~~{.output}
 [1] Qn1 Qn2 Qn3 Qc1 Qc2 Qc3 Mn1 Mn2 Mn3 Mc1 Mc2 Mc3
12 Levels: Qn1 < Qn2 < Qn3 < Qc1 < Qc3 < Qc2 < Mn3 < Mn2 < Mn1 < ... < Mc1

~~~

#### 5.2. 문제 해답


~~~{.r}
CO2 <- CO2[order(as.character(CO2$Plant)), ]
CO2 <- CO2[order(CO2$uptake, as.character(CO2$Plant)), ]
CO2 <- CO2[order(CO2$uptake, -xtfrm(as.character(CO2$Plant))), ]
~~~

### 6.번 정렬 문제

#### 6.1. 문제 정의


~~~{.r}
df <- as.data.frame(matrix(sample(1:5, 2000, T), ncol=40))
~~~
- 칼럼 40개 모두를 왼쪽에서 오른쪽으로 오름차순으로 정렬한다.
- 칼럼 40개 모두를 왼쪽에서 오른쪽으로 내림차순으로 정렬한다.
- 칼럼 40개 모두를 오른쪽에서 왼쪽으로 오름차순으로 정렬한다.

#### 6.2. 문제 해답


~~~{.r}
df <- df[do.call(order, df), ]
df <- df[do.call(order, -df), ]
df <- df[do.call(order, rev(df)), ]  
~~~


