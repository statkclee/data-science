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

### 2. `dplyr` 예제 데이터셋
 



