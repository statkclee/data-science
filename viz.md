---
layout: page
title: 데이터 과학
subtitle: 시각화(Visualization)
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표  {.objectives}
>
> * Anscombe 데이터를 통해 데이터 시각화의 중요성을 이해한다.
> * 시각화 얼개를 통한 시각화를 목적과 방향을 탐색한다.
> * 시각화 산출물을 만들어내는 3가지 R 시각화 시스템을 살펴본다.


## 1. Anscombe 4종류 데이터(Anscombe's Quartet) [^anscombe] [^anscombe-jstor]

Anscombe는 1973년 동일한 통계량을 갖는 4종류 데이터셋을 만들어서 시각화의 중요성을 공개했다.

|  통계량     |   값  |
|-------------|-------|
|  평균(`x`)  |  9    |
|  분산(`x`)  |  11   |
|  평균(`y`)  |  7.5  |
|  분산(`y`)  |  4.1  |
|  상관계수   |  0.82  |
|  회귀식     |  y = 3.0 + 0.5*x |



[^anscombe]: [Anscombe quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet)
[^anscombe-jstor]: Anscombe, F. J. (1973). "Graphs in Statistical Analysis". American Statistician 27 (1): 17–21.



~~~{.r}
# library(gridExtra)

data(anscombe)
anscombe
~~~



~~~{.output}
   x1 x2 x3 x4    y1   y2    y3    y4
1  10 10 10  8  8.04 9.14  7.46  6.58
2   8  8  8  8  6.95 8.14  6.77  5.76
3  13 13 13  8  7.58 8.74 12.74  7.71
4   9  9  9  8  8.81 8.77  7.11  8.84
5  11 11 11  8  8.33 9.26  7.81  8.47
6  14 14 14  8  9.96 8.10  8.84  7.04
7   6  6  6  8  7.24 6.13  6.08  5.25
8   4  4  4 19  4.26 3.10  5.39 12.50
9  12 12 12  8 10.84 9.13  8.15  5.56
10  7  7  7  8  4.82 7.26  6.42  7.91
11  5  5  5  8  5.68 4.74  5.73  6.89

~~~

### 1.1. Anscombe 데이터셋 4종 기술통계량


~~~{.r}
# x1, x2, x3, x4 평균
sapply(1:4, function(x) mean(anscombe[,x]))
~~~



~~~{.output}
[1] 9 9 9 9

~~~



~~~{.r}
# anscombe %>% select(x1,x2,x3,x4) %>% 
#   summarize(x1Mean=round(mean(x1),1), y2Mean=round(mean(x2),2), y3Mean=round(mean(x3),1), y4Mean=round(mean(x4),1))

# x1, x2, x3, x4 분산
sapply(1:4, function(x) var(anscombe[,x]))
~~~



~~~{.output}
[1] 11 11 11 11

~~~



~~~{.r}
# anscombe %>% select(x1,x2,x3,x4) %>% 
#   summarize(x1Var=round(var(x1),1), x2Var=round(var(x2),1), x3Var=round(var(x3),1), x4Var=round(var(x4),1))

# y1, y2, y3, y4 평균
sapply(5:8, function(x) mean(anscombe[,x]))
~~~



~~~{.output}
[1] 7.500909 7.500909 7.500000 7.500909

~~~



~~~{.r}
# anscombe %>% select(y1,y2,y3,y4) %>% 
#   summarize(y1Mean=round(mean(y1),1), y2Mean=round(mean(y2),2), y3Mean=round(mean(y3),1), y4Mean=round(mean(y4),1))

# y1, y2, y3, y4 분산
sapply(5:8, function(x) var(anscombe[,x]))
~~~



~~~{.output}
[1] 4.127269 4.127629 4.122620 4.123249

~~~



~~~{.r}
# anscombe %>% select(y1,y2,y3,y4) %>% 
#   summarize(y1Var=round(var(y1),1), y2Var=round(var(y2),1), y3Var=round(var(y3),1), y4Var=round(var(y4),1))

# x1:y1 ~ x4:y4 상관계수
# 상관계수
sapply(1:4, function(x) cor(anscombe[, x], anscombe[, x+4]))
~~~



~~~{.output}
[1] 0.8164205 0.8162365 0.8162867 0.8165214

~~~



~~~{.r}
# anscombe %>% 
#   summarise(cor1=round(cor(x1,y1),2), cor2=round(cor(x2,y2),2), cor3=round(cor(x3,y3),2),cor4=round(cor(x4,y4),2))

# y1:x1-x4 ~ y1:x1-x4 회귀분석
lm_fit <- function(y1, x1, dat) {
  the_fit <- lm(y1 ~ x1, dat)
  setNames(data.frame(t(coef(the_fit))), c("intercept", "slope"))
}

gfits <- anscombe %>%
  do(reg1 = lm_fit(y1, x1, .), reg2 = lm_fit(y2, x2, .), 
     reg3 = lm_fit(y3, x3, .), reg4 = lm_fit(y4, x4, .))

unlist(gfits$reg1)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg2)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg3)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg4)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~

### 1.2. Anscombe 데이터셋 4종 시각화


~~~{.r}
p1 <- ggplot(anscombe) + geom_point(aes(x1, y1), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 1")
p2 <- ggplot(anscombe) + geom_point(aes(x2, y2), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 2")
p3 <- ggplot(anscombe) + geom_point(aes(x3, y3), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 3")
p4 <- ggplot(anscombe) + geom_point(aes(x4, y4), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 4")

grid.arrange(p1, p2, p3, p4, ncol=2, top = "Anscombe's Quartet")
~~~

<img src="fig/anscombe-quartet-1.png" title="plot of chunk anscombe-quartet" alt="plot of chunk anscombe-quartet" style="display: block; margin: auto;" />

## 2. 시각화 [^tamara] 

컴퓨터를 기반으로 한 시각화 시스템은 시각적으로 데이터를 표현함으로 인해서 
사람들이 작업을 더욱 효율적으로 수행할 수 있도록 돕는다.

여기서 시각화가 적합한 상황은 인공지능 및 전사화를 통해 사람을 대체하기 보다는 인간능력을 증강시키는데 유용하다.
따라서, 완전 자동화 해결책이 존재하고 신뢰성이 있는 경우 시각화가 그다지 필요하지는 않는다.
또한, 많은 분석문제에는 어떤 질문을 던져야 되는지 사전에 알고 있는 경우가 적어, 명세가 분명하지 않는 경우가 있는데,
이런 목적에 유용하다.

> ### 시각화 {.callout}
> 
> "Computer-based visualization systems provide visual representations of datasets
 designed to help people carry out tasks more effectively" -- Tamara Munzner


[^tamara]: [Tamara Munzner. Visualization Analysis and Design. A K Peters Visualization Series, CRC Press, 2014](http://www.cs.ubc.ca/~tmm/vadbook/)

### 2.1. 시각화가 왜 필요한가?

**인지부하(cognitive load)**를 **시각적 지각(perception)**으로 바꿔 해당 작업을 더욱 효과적으로 처리하는데 시각화를 사용한다.


~~~{.r}
library(datasets)
women
~~~



~~~{.output}
   height weight
1      58    115
2      59    117
3      60    120
4      61    123
5      62    126
6      63    129
7      64    132
8      65    135
9      66    139
10     67    142
11     68    146
12     69    150
13     70    154
14     71    159
15     72    164

~~~

`women` 데이터가 정렬이 되어 있어서, 신장이 커짐에 따라 체중이 증가하는 것을 알 수 있지만, 데이터만 보고 이해하려면
인지적으로 데이터 한줄을 읽고 머리속으로 생각하고, 두번째 줄을 읽고 생각하고, ... 이런 과정을 반복하면서 인지적 부하가 증가하게 된다.
하지만, 시각적으로 표현하게 되면 한눈에 신장과 체중 관계를 볼 수 있다.


~~~{.r}
women %>% ggplot(aes(y=weight, x=height)) + geom_point(color='blue', size=2) +
  geom_smooth(color='pink')
~~~



~~~{.output}
`geom_smooth()` using method = 'loess'

~~~

<img src="fig/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

### 2.2. 시각화 분석 얼개 구성요소

시각화 분석 얼개는 4가지 부분으로 구성된다. 

- 전문영역 : 최종 사용자 고객이 누군인가?
- 추상화
    + 전문영역의 구체적인 점을 시각화 용어로 번역
        * **데이터 추상화** : 시각화하는 것이 무엇(what)인가?
        * **작업 추상화** : 왜(why) 사용자가 눈을 돌리는가?
- 표현양식(idiom)
    + 데이터가 어떻게(How) 시각화되는가?
    	* **시각적 인코딩 표현양식** : 시각화하는 방법
    	* **상호작용 표현양식** : 조작하는 방법
- 알고리즘
	+ 효율적 연산방법    	

[Munzner, Tamara. "A nested model for visualization design and validation." Visualization and Computer Graphics, IEEE Transactions on 15.6 (2009): 921-928.](http://www.cs.ubc.ca/~tmm/talks/iv09/nestedmodel-4x4.pdf)

<img src="fig/viz-framework.png" alt="RStudio" width="77%" />

### 2.3. 시각화 분석 접근방향

시각화 시스템 실행시간, 메모리 사용량 등을 측정하고, 연산 복잡성을 분석하는 알고리즘 작업은 컴퓨터 과학자의 몫이다.
여러가지 대안 시스템 아키텍처를 정당화하고 시각적 인코딩 방법과 상호작용하는 표현양식을 설계하는 것은 시스템 설계자의 몫이다.
시각화 시스템 결과물을 정량적으로 분석하고, 사용자 인간에 대한 실험을 추진하는 것은 인지심리학자의 몫이다.
이를 감싸고 있는 데이터 추상화와 작업추상화가 있는데, 시스템 설계자가 앞단에서 설계하면 후행단에서 인지심리학자가 검증하고,
컴퓨터 과학자가 개발하는 구조를 갖는다.

이 모든 시작은 전문영역에서 문제점을 인식하고 기존의 도구를 사용하는 목표 사용자를 관측하는 것에서 시작되는데 이는 인류학자, 민족지라는 분야와 연관된다.
따라서, 기술중심으로 밖으로 퍼져나갈 수도 있지만, 문제해결작업으로 시각화를 활용하는 것도 가능한 접근법이다.

> ### 시각화 도구{.callout}
> 
> - **명령형(imperative)**: "방법(how)"에 초점, Processing, OpenGL, prefuse
> - **선언형(declarative)**: "무엇(what)"에 초점, D3, ggplot2, Protovis 


## 3. R 시각화 시스템 [^coursera-r-plotting-system]

[^coursera-r-plotting-system]: [코세라 Lecture 10 - Plotting Systems in R](https://www.coursera.org/learn/exploratory-data-analysis/lecture/MTRt4/plotting-systems-in-r)

R에는 다양한 시각화 관련 시스템이 존재하지만, 가장 대표적으로 3가지 시각화 시스템을 이해하면 실무적으로 충분하다.

- Base 시각화 시스템
- `lattice` 시각화 시스템
- `ggplot` 시각화 시스템

### 3.1. Base 시각화 시스템

R설치하면 내장된 Base 시각화 시스템은 **화가의 팔레트(Artist's Palallete)** 모형으로 빈 도화지 캔바스 위에 화가가 그림을 그리는 것과 동일한 방식으로 시각화 산출물을 만들어 나간다.
`plot()` 혹은 유사한 시각화 함수로 시작해서 텍스트(`text`), 선(`line`), 점(`point`), 축(`axis`) 등을 표현하는데  **주석(Annotation)** 함수를 활용한다.

따라서, 사람이 사고하는 방식으로 시각화 산출물을 만들어 나가 편리하지만, 시각화 산출물을 다시 그리려고 하면 처음부터 다시 해야 되기 때문에 시각화 산출물을 
만드는 초기부터 시간을 갖고 잘 설계해 나가야 된다. 그리고, 시각화 산출물이 생성되면 다른 것으로 변환하기 어려운 단점이 있고, 그래픽 언어가 아니라 일련의 R 명령어
묶음에 불가하다.


~~~{.r}
#1. Base 시각화 시스템----------------------------------------------------------------
library(datasets)
data(mtcars)
with(mtcars, plot(disp, mpg))
~~~

<img src="fig/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

### 3.2. `lattice` 시각화 시스템

`lattice` 시각화 시스템은 `lattice` 팩키지를 통해 설치되고, 함수 호출(`xyplot()`, `bwplot()` 등)을 통해 시각화 산출물을 생성하게 된다.
조건에 따라 일변량 혹은 다변량 변수를 시각화하는데 유용하다. 즉, 특정 범주형 변수 수준에 따라 두 변수간의 관계를 시각적으로 표현하는 것을 예로 들 수 있다.
전체 시각화 산출물 결과는 여백(margin), 공간 등은 자동으로 한번에 정해져서, 화면에 다수 시각화 산출물을 배치할 때 유용하다.

하지만, 함수호출 한번으로 전체 시각화 산출물을 명세하는 것이 쉽지는 않다. 특히 주석(Annotation)을 시각화 산출물에 다는 것이 그다지 직관적이는 않다.
그리고 `lattice` 함수를 통해 시각화 산출물이 만들어지면 더이상 추가는 불가하다.



~~~{.r}
#2. Lattice 시각화 시스템----------------------------------------------------------------
# library(lattice)
xyplot(mpg ~ disp | am, data=mtcars, layout=c(2,1))
~~~

<img src="fig/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

### 3.3. `ggplot` 시각화 시스템

`ggplot` 시각화 시스템은 `ggplot2` 팩키지를 통해 설치가 가능하다. Base 시각화 시스템과 `lattice` 시각화 시스템의 장점을 취사선택해서 개발된 것으로 보는 견해도 있다.
그래픽 문법(Grammer of Graphic)에 기반하고 있으며, `lattice` 시각화 시스템처럼 공백, 텍스트, 제목 등을 자동으로 설정하고,
Base 시각화 시스템에서 지원하는 다양한 그래픽 요소를 추가하는 것도 가능하다. 전반적으로 `lattice`느낌이 나지만 사용하기는 직관적이며 다양한 그래픽 요소를 
추가하는 것도 쉽다. 물론 `ggplot`에서 자동으로 설정하는 것도 원하는 설정으로 바꾸는 것도 가능하다.


~~~{.r}
#3. ggplot 시각화 시스템----------------------------------------------------------------
ggplot(data=mtcars, mapping=aes(x=disp, y=mpg)) + 
  geom_point() +
  geom_smooth(method="lm", se=FALSE)
~~~

<img src="fig/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

### 3.4. `grid` 시각화 시스템

`grid` 시각화 시스템은 `lattice`와 `ggplot`의 기반이 되는 시각화 시스템으로 R 버전 1.8.0 부터 Base 팩키지의 일부가 되었다.[^grid-viz-system]
grid_0.7-4에서 [Base 팩키지 일부](https://stat.ethz.ch/R-manual/R-devel/library/grid/doc/changes.txt)가 되어 버젼이 Base 팩키지에 맞춰 버젼이 급상승했다.

`grid` 시각화 시스템을 사용해서 위와 동일하게 상기 그래프를 그리면 다음과 같다. 
`grid` 시스템을 숙달하기까지 시간이 걸리지만, 익숙해지면 장점이 상당하다.

[^grid-viz-system]: [R package grid disappeared?](http://stackoverflow.com/questions/29349398/r-package-grid-disappeared)


~~~{.r}
library(grid)
x <- mtcars$disp
y <- mtcars$mpg

pushViewport(plotViewport())
pushViewport(dataViewport(x, y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x, y)
grid.text("mtcars$disp", x = unit(-3, "lines"), rot = 90)
grid.text("mtcars$mpg", y = unit(-3, "lines"), rot = 0)
popViewport(2)
~~~

<img src="fig/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />
