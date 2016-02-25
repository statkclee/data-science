---
layout: page
title: 데이터 과학
subtitle: 데이터 변환(dplyr)
---



> ## 학습 목표 {.objectives}
>
> * 데이터프레임과 동일하지만, `tbl`로 작업을 일원화한다. 
> * 선행 작업 프로세스 `tidyr`을 받아 `dplyr`로 작업한다.
> * `dplyr` 데이터 작업 동사 5개를 활용한다.
> * 다수 데이터셋에 다양한 병합(join) 작업을 수행한다.


### 1. RStudio와 Hadley 자료분석 체계

**[Hadley Wickham](http://www.had.co.nz/)**은 `tidyr`을 사용하여 자료 정제하고 자료변환을 위해서 `dplyr`을 사용하고 그래픽 문법(glammar of graphics)에 따라 `ggvis`로 시각화하고 R의 다양한 모형화를 이용한 자료분석 체계도를 제안하였고, 최근에는 `broom` 팩키지를 통해 R 모형에서 반환하는 결과값을 재활용할 수 있는 툴체인도 제안하고 있다.

시각화(Visualization)는 데이터에 대한 통찰력(insight)과 탄성, 놀라움을 줄 수 있지만, 확장성(Scalability)은 떨어진다. 왜냐하면, 사람이 데이터 분석 루프에 포함되기 때문에 확장 및 자동화에 한계가 있다. 반대로 모형(Model)은 자동화와 확장성에는 장점이 있지만, 주어진 모형틀안에서 이루어지기 때문에 통찰력, 놀라움, 탄성을 주지는 못하는 아쉬움이 있다. 

> ### `dplyr` 목표 {.callout}
>
> 1. 데이터를 소프트웨어로 작업하기 적합하게 만든다.  
> 2. 데이터를 쉽게 까볼 수 있게 한다.


#### 1.1. `dplyr`

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
 
##### 1.1.1. 관측점(obervation) 필터링해서 선택하기 (filter)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[df$var01==3 & df$var02$==7]` |`filter(df, var01==3, var02==7)`|


~~~ {.input}
filter(df, color == "blue")
filter(df, value %in% c(1, 4))
~~~

##### 1.1.2. 특정 변수 선택하기 (select)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[, c("var01","var02")]` |`select(df, var01)`|


~~~ {.input}
select(df, color)
select(df, -color)
~~~

##### 1.1.3. 다시 정렬하기 (arrange)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df[order(df$var01, df$var02)` |`arrange(df, var01, var02)`|

~~~ {.input}
arrange(df, color)
arrange(df, desc(color))
~~~

##### 1.1.4. 새변수 생성하기 (mutate)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`df$new <- df$var01/df$var02` |`df <- mutate(df, new=var01/var02)`|

~~~ {.input}
mutate(df, double = 2 * value)
mutate(df, double = 2 * value, quadruple = 2 * double)
~~~

##### 1.1.5. 변수 요약하기 (summarize)

| 전통적 R 코드 | `dplyr` R 코드 |
|---------------|---------------|
|`aggregate(df$value, list(var01=df$var01), mean)` |`group_by(df, var01) %.% summarize(totalvalue = sum(value))`|


~~~ {.input}
summarise(df, total = sum(value))
by_color <- group_by(df, color) 
summarise(by_color, total = sum(value))
~~~

### 2. `tidyr` 예제 데이터셋
 


~~~{.r}
# install.packages("devtools")
# devtools::install_github("rstudio/EDAWR")
library(EDAWR)
?storms
?pollution
?cases 
?tb
library(tidyr)
~~~


> #### 깔끔한 데이터 - 결핵  {.challenge}
> 
> 결핵(Tuberculosis, tb) 데이터를 깔끔한 데이터로 변형한다.
>
> **변경전 (Wide 형식, 사람 중심)**
>
> | country | 2011  | 2012   | 2013  |
> |---------|-------|--------|-------|
> | FR      | 7000  | 6900   | 7000  |
> | DE      | 5800  | 6000   | 6200  |
> | US      | 15000 | 14000  | 13000 |
>
> **변경후 (Long 형식, 기계 중심)** 
>
> | country | year | n     |
> |---------|------|-------|
> |      FR | 2011 | 7000  |
> |      DE | 2011 | 5800  |
> |      US | 2011 | 15000 |
> |      FR | 2012 | 6900  |
> |      DE | 2012 | 6000  |
> |      US | 2012 | 14000 |
> |      FR | 2013 | 7000  |
> |      DE | 2013 | 6200  |
> |      US | 2013 | 13000 |



~~~{.r}
gather(cases, "year", "n", 2:4)
~~~


> #### 깔끔한 데이터 - 환경오염 {.challenge}
> 
> 환경오염(pollution) 데이터를 깔끔한 데이터로 변형한다.
>
> **변경후 (Long 형식, 기계 중심)** 
>
> |     city |  size | amount |
> |----------|-------|--------|
> | New York | large |     23 |
> | New York | small |     14 |
> |   London | large |     22 |
> |   London | small |     16 |
> |  Beijing | large |    121 |
> |  Beijing | small |     56 |
> 
> **변경전 (Wide 형식, 사람 중심)**
>
> 
> |     city | large | small |
> |----------|-------|--------|
> |  Beijing |   121 |    56 |
> |   London |    22 |    16 |
> | New York |    23 |    14 |


~~~{.r}
spread(pollution, size, amount)
~~~

> #### 깔끔한 데이터 - 태풍 허리케인 {.challenge}
> 
> `storms` 태풍 허리케인 데이터에는 년월일 변수에 변수 세개가 숨겨져 있다.
> 변수를 쪼개는데 `separate()` 함수를 사용한다. 합치는데는 `unite()` 함수를 사용한다.
> 
> **변경전 (합쳐진 변수)** 
>
> |   storm |  wind | pressure |       date |
> |---------|-------|----------|------------|
> | Alberto |   110 |     1007 | 2000-08-03 |
> |    Alex |    45 |     1009 | 1998-07-27 |
> | Allison |    65 |     1005 | 1995-06-03 |
> |     Ana |    40 |     1013 | 1997-06-30 |
> |  Arlene |    50 |     1010 | 1999-06-11 |
> |  Arthur |    45 |     1010 | 1996-06-17 |
>
> **변경후 (쪼개진 변수)** 
>
> |   storm | wind | pressure | year | month | day |
> |---------|------|----------|------|-------|-----|
> | Alberto |  110 |     1007 | 2000 |    08 |  03 |
> |    Alex |   45 |     1009 | 1998 |    07 |  27 |
> | Allison |   65 |     1005 | 1995 |    06 |  03 |
> |     Ana |   40 |     1013 | 1997 |    06 |  30 |
> |  Arlene |   50 |     1010 | 1999 |    06 |  11 |
> |  Arthur |   45 |     1010 | 1996 |    06 |  17 |


~~~{.r}
separate(storms, date, c("year", "month", "day"), sep = "-")
unite(storms2, "date", year, month, day, sep = "-")
~~~

### 3. `dplyr` 예제 데이터셋

- select() : 변수를 추출한다.
- filter() : 관측점을 뽑아낸다.
- mutate() : 기존 변수에서 새로운 변수를 생성한다.
- summarise() : 분석 단위를 변경한다.


> #### 데이터 변환 - 변수 선택 {.challenge}
> 
> `storms` 태풍 허리케인 데이터에서 변수를 뽑아낼 때
> `select()`를 사용한다. `-`, `:` 연산자도 사용가능하다.
> 
> **변경전** 
>
> |   storm |  wind| pressure |       date |
> |---------|------|----------|------------|
> | Alberto |   110|     1007 | 2000-08-03 |
> |    Alex |    45|     1009 | 1998-07-27 |
> | Allison |    65|     1005 | 1995-06-03 |
> |     Ana |    40|     1013 | 1997-06-30 |
> |  Arlene |    50|     1010 | 1999-06-11 |
> |  Arthur |    45|     1010 | 1996-06-17 |
> 
>  **변경후(변수 선택)** 
>
> |   storm | pressure| 
> |---------|---------| 
> | Alberto |     1007| 
> |    Alex |     1009| 
> | Allison |     1005| 
> |     Ana |     1013| 
> |  Arlene |     1010| 
> |  Arthur |     1010| 



~~~{.r}
select(storms, storm, pressure)
select(storms, -storm)
select(storms, wind:date)
~~~

#### 유용한 `select()` 내장 함수

|     내장 함수   | 설명 |
|---------------|-------------------------------------|
| -             | 해당 변수를 제외한 모든 칼럼을 선택한다. |
| :             | 해당 범위에 해당되는 칼럼을 선택한다.|
| contains()    | 해당 문자열을 명칭을 포함한 칼럼을 선택한다. |
| starts_with() | 해당 문자열로 시작하는 명칭을 포함한 칼럼을 선택한다.|
| ends_with()   | 해당 문자열로 끝나는 명칭을 포함한 칼럼을 선택한다.|
| everything()  | 모든 칼럼을 선택한다.|
| matches()     | 정규표현식을 매칭하는 칼럼을 선택한다.|
| num_range()   | x1, x2, x3, x4, x5 명칭이 붙은 칼럼을 선택한다.|
| one_of()      | 그룹에 명칭이 담긴 칼럼을 선택한다.|


> #### 데이터 변환 - 관측점 선택 {.challenge}
> 
> `storms` 태풍 허리케인 데이터에서 관측점을 필터링한다.
> `filter()`를 사용한다.
> 
> **변경전** 
>
> |   storm |  wind| pressure |       date |
> |---------|------|----------|------------|
> | Alberto |   110|     1007 | 2000-08-03 |
> |    Alex |    45|     1009 | 1998-07-27 |
> | Allison |    65|     1005 | 1995-06-03 |
> |     Ana |    40|     1013 | 1997-06-30 |
> |  Arlene |    50|     1010 | 1999-06-11 |
> |  Arthur |    45|     1010 | 1996-06-17 |
> 
>  **변경후(관측점 선택)** 
>
> **변경후** 
>
> |   storm |  wind| pressure |       date |
> |---------|------|----------|------------|
> | Alberto |   110|     1007 | 2000-08-03 |
> | Allison |    65|     1005 | 1995-06-03 |
> |  Arlene |    50|     1010 | 1999-06-11 |



~~~{.r}
filter(storms, wind >= 50)
filter(storms, wind >= 50, storm %in% c("Alberto", "Alex", "Allison"))
~~~

#### `filter()` R 논리 연산자

|  비교연산자 `?Comparison` | 설명 | 논리 연산자 `?base::Logic` | 설명 |
|-------------|------|------------------------|-------------|
| `<`      |  적다             |  `&`   | 그리고 |
| `>`      |  크다             |  `|`   | 또는  |
| `==`     |  같다             |  `xor` | 배타적 논리합 |
| `<=`     |  이하             |  `!`   | 부정 |
| `>=`     |  이상             |  `any` | 참이 있음 |
| `!=`     |  같지 않다         |  `all` | 모두 참 |
| `%in%`   |  포함한다          | | |
| `is.na`  |  `NA` 값이다      | | |
| `!is.na` |  `NA` 값이 아니다.  | | |



> #### 데이터 변환 - 신규변수 생성 {.challenge}
> 
> `storms` 태풍 허리케인 데이터에서 변수를 새로 생성한다.
> `mutate()`를 사용한다.
> 
> **변경전** 
>
> |   storm |  wind| pressure |       date |
> |---------|------|----------|------------|
> | Alberto |   110|     1007 | 2000-08-03 |
> |    Alex |    45|     1009 | 1998-07-27 |
> | Allison |    65|     1005 | 1995-06-03 |
> |     Ana |    40|     1013 | 1997-06-30 |
> |  Arlene |    50|     1010 | 1999-06-11 |
> |  Arthur |    45|     1010 | 1996-06-17 |
> 
>  **변경후(변수 생성)** 
>
> |   storm |  wind| pressure |       date |    ratio |
> |---------|------|----------|------------|----------|
> | Alberto |   110|     1007 | 2000-08-03 | 9.154545 |
> |    Alex |    45|     1009 | 1998-07-27 |22.422222 |
> | Allison |    65|     1005 | 1995-06-03 |15.461538 |
> |     Ana |    40|     1013 | 1997-06-30 |25.325000 |
> |  Arlene |    50|     1010 | 1999-06-11 |20.200000 |
> |  Arthur |    45|     1010 | 1996-06-17 |22.444444 |



~~~{.r}
mutate(storms, ratio = pressure / wind)
mutate(storms, ratio = pressure / wind, inverse = ratio^-1)
~~~

#### 유용한 `mutate()` 내장 함수

|  함수명 |  설명 |
|-------------|----------------------|
| `pmin()`, `pmax()`               | 관측점별 최소값, 최대값|
| `cummin()`, `cummax()`           | 누적 최소값, 최대값 |
| `cumsum()`, `cumprod()`          | 누적합, 누적곱 |
| `between()`                      | a와 b 사이 |
| `cume_dist()`                    | 누적 분포값 |
| `cumall()`, `cumany()`           | 모든 누적값, 조건이 맞는 누적값 |
| `cummean()`                      | 누적 평균 |
| `lead()`, `lag()`                | 위치 값을 선행 혹은 후행하여 복사 |
| `ntile()`                        | 벡터를 n개 구간을 분할 |
| `dense_rank()`, `min_rank(),`, `percent_rank()`, `row_number()` | 다양한 순위 방법 |


> #### 데이터 변환 - 분석단위 변경(요약) {.challenge}
> 
> `pollution` 환경오염 데이터에 대한 분석단위를 변경한다.
> `summarise()`를 사용한다.
> 
> **변경전** 
>
> |     city |  size | amount |
> |----------|-------|--------|
> | New York | large |     23 |
> | New York | small |     14 |
> |   London | large |     22 |
> |   London | small |     16 |
> |  Beijing | large |    121 |
> |  Beijing | small |     56 |
>
> **변경후** 
>
> | median | variance |
> |--------|----------|
> |   22.5 |   1731.6 |



~~~{.r}
pollution %>% summarise(median = median(amount), variance = var(amount))
pollution %>% summarise(mean = mean(amount), sum = sum(amount), n = n())
~~~

#### 유용한 `summarize()` 내장 함수

|  함수명 |  설명 |
|-------------|----------------------|
| `min()`, `max()` | 최소값, 최대값 |
| `mean()`         | 평균 |
| `median()`       | 중위수 |
| `sum()`          | 합계 |
| `var`, `sd()`    | 분산, 표준편차 |
| `first()`        | 첫번째 값 |
| `last()`         | 마지막 값 |
| `nth()`          | n번째 값 |
| `n()`            | 해당 벡터에 값 개수 |
| `n_distinct()`   | 해당 벡터에 유일무이한 값 개수|


> #### 데이터 변환 - 정렬 {.challenge}
> 
> `storms` 태풍 허리케인 데이터 칼럼을 정렬한다.
> `arrange()` 함수를 사용한다.
>
> **변경전** 
>
> |   storm |  wind| pressure |       date |
> |---------|------|----------|------------|
> | Alberto |   110|     1007 | 2000-08-03 |
> |    Alex |    45|     1009 | 1998-07-27 |
> | Allison |    65|     1005 | 1995-06-03 |
> |     Ana |    40|     1013 | 1997-06-30 |
> |  Arlene |    50|     1010 | 1999-06-11 |
> |  Arthur |    45|     1010 | 1996-06-17 |
> 
>  **변경후(변수를 정렬)** 
> 
> |   storm |  wind | pressure |       date |
> |---------|-------|----------|------------|
> |     Ana |    40 |     1013 | 1997-06-30 |
> |    Alex |    45 |     1009 | 1998-07-27 |
> |  Arthur |    45 |     1010 | 1996-06-17 |
> |  Arlene |    50 |     1010 | 1999-06-11 |
> | Allison |    65 |     1005 | 1995-06-03 |
> | Alberto |   110 |     1007 | 2000-08-03 |


~~~{.r}
arrange(storms, wind)
arrange(storms, desc(wind))
arrange(storms, wind, date)
~~~


#### 3.1. `dplyr`::`group_by()` 함수 (분석 단위)

분석단위별로 나눠서 자료분석을 할 경우 `group_by()` 함수를 조합한다.


~~~{.r}
pollution %>% group_by(city)
~~~

~~~ {.output}
Source: local data frame [6 x 3]
Groups: city [3]

      city  size amount
     (chr) (chr)  (dbl)
1 New York large     23
2 New York small     14
3   London large     22
4   London small     16
5  Beijing large    121
6  Beijing small     56
~~~


~~~{.r}
pollution %>% group_by(city) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())
pollution %>% ungroup()  
~~~

~~~ {.output}
Source: local data frame [3 x 4]

      city  mean   sum     n
     (chr) (dbl) (dbl) (int)
1  Beijing  88.5   177     2
2   London  19.0    38     2
3 New York  18.5    37     2
~~~


#### 3.2. 데이터테이블 결합


~~~{.r}
bind_cols(y, z)
bind_rows(y, z)
intersect(y, z)
union(y, z)
setdiff(y, z)
~~~


~~~{.r}
left_join(songs, artists, by = "name")
left_join(songs2, artists2, by = c("first", "last"))
inner_join(songs, artists, by = "name")
semi_join(songs, artists, by = "name")
anti_join(songs, artists, by = "name")
~~~

### `data.table`과 `dplyr` 비교 [^dt-dplyr-comparison]

`data.table`과 `dplyr`은 데이터 변환작업을 수행하지만, 다음 관점에서 살펴볼 필요가 있다.

1. 속도
1. 메모리 사용량
1. 구문
1. 기능 


[^dt-dplyr-comparison]: [data.table vs dplyr: can one do something well the other can't or does poorly?](http://stackoverflow.com/questions/21435339/data-table-vs-dplyr-can-one-do-something-well-the-other-cant-or-does-poorly)
