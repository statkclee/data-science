---
layout: page
title: 데이터 과학
subtitle: 깔끔한 데이터와 모형 -- broom
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * 깔끔한 3종세트 `tidyr`, `dplyr`, `broom`를 살펴본다.

### 1. `broom` 팩키지를 사용해야 되는 이유 [^cran-broom]

[^cran-broom]: [broom: Convert Statistical Analysis Objects into Tidy Data Frames](https://cran.r-project.org/web/packages/broom/index.html)

`broom` 팩키지를 꼭 사용해야되는 이유는 R의 성공에서 찾을 수 있다. 
R이 성공하지 않았다면 이런 고민도, 데이터 과학이 이렇게 관심을 갖게 되지 않았다면 어쩌면 `broom` 팩키지를 생겨나지 않았을 수도 있다.

|        David Robinson           |         Hadley Wickham          |
|---------------------------------|---------------------------------|
| broom: Converting statistical models to tidy data frames, | Managing many models with R |
| <iframe width="300" height="180" src="https://www.youtube.com/embed/eM3Ha0kTAz4" frameborder="0" allowfullscreen></iframe> |<iframe width="300" height="180" src="https://www.youtube.com/embed/rz3_FDVt9eg" frameborder="0" allowfullscreen></iframe> |



~~~{.r}
lmfit <- lm(mpg ~ wt, mtcars)
# summary(lmfit)
~~~

선형 회귀식을 적합시키게 되면 회귀분석 결과는 4가지 산출결과를 출력한다.

1. 모형 정보: `lm(formula = mpg ~ wt, data = mtcars)`
1. 관측점 정보: 잔차 등
1. 구성요소 정보: 회귀계수, t-값, p-값 등
1. 모형 정보: $R^2$ 값, F-통계량, 편차(deviance)

하지만, 이런 선형회귀모형 산출물은 다음과 같은 문제점이 목도된다.

1. 회귀계수를 뽑아내는데 다수 단계가 필요하다.
    - `data.frame(coef(summary(lmfit)))`
1. 회귀계수가 행명칭(`row names`)라 모형에 바로 엮어 사용하기 번거럽다.
    - `(Intercept)`, `wt`에 변수명이 없음.
1. 데이터프레임 변수명으로 사용하기 부적절하게 표현
    - `Pr(>|t|)`을 변수명으로 변경하기 까다로움
1. 출력결과가 저장되지 않고 화면에 출력만 됨.
    - `p-value: 1.294e-10`

|               회귀 분석 결과                                    |        모형 출력 결과                     |  `broom`     |
|:----------------------------------------------------------------|-------------------------------------------|--------------|
| Call:                                                           |                                           |              |
| lm(formula = mpg ~ wt, data = mtcars)                           |  데이터 적합 모형                         |              |
|                                                                 |                                           |              |
| Residuals:                                                      |  관측점 수준: 잔차, 적합값 등             | `augment()`  |
|     Min      1Q  Median      3Q     Max                         |                                           |              |
| -4.5432 -2.3647 -0.1252  1.4096  6.8727                         |                                           |              |
|                                                                 |                                           |              |
| Coefficients:                                                   |  구성요소 수준: 회귀계수, p-값            | `tidy()`     |
|             Estimate Std. Error t value Pr(>\|t\|)              |                                           |              |
| (Intercept)  37.2851     1.8776  19.858  < 2e-16 ***            |                                           |              |
| wt           -5.3445     0.5591  -9.559 1.29e-10 ***            |                                           |              |
| Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1  |                                           |              |
|                                                                 |                                           |              |
| Residual standard error: 3.046 on 30 degrees of freedom         |  모형 수준: $R^2$ 값, F-통계량, 편차 등   | `glance()`   |
| Multiple R-squared:  0.7528, Adjusted R-squared:  0.7446        |                                           |              |
| F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10          |                                           |              |

### 2. `broom` 팩키지 3 종세트

후속작업을 이어나갈 수 있도록 모형 출력결과를 처리하는 `broom` 3종 세트가 준비되어 있다.

- `glance` : 모형을 한줄로 간략하게 요약한다. 한줄 요약 모형에는 $R^2$, 수정 $R^2$, p-값, AIC, BIC, 편차(deviance)등이 포함된다.
- `tidy` : 모형에 대한 통계적 결과물을 요약해서 데이터프레임으로 제공한다. 데이터프레임에는 회귀계수, p-값, 군집분석의 경우 군집별 정보,
t-검정, 다-검정의 경우 검정별 정보가 포함된다.
- `augment`: 원 데이터프레임에 칼럼을 추가해서 예측값, 잔차, 군집 배정등 각 관측점별 정보가 덧붙여진다.

`tidy` 실행결과 `Pr(>|t|)` p-값을 `p.value` 칼럼으로 `$` 을 조합해서 뽑아내기 쉽게 되었다. 물론 `coef(summary(lmfit))` 수고를 하지 않고도 
`$`을 사용해서 `term` 칼럼에서 회귀계수 값을 뽑아내기 편리하게 되었다. 


~~~{.r}
library(broom)
tidy(lmfit)
~~~



~~~{.output}
         term  estimate std.error statistic      p.value
1 (Intercept) 37.285126  1.877627 19.857575 8.241799e-19
2          wt -5.344472  0.559101 -9.559044 1.293959e-10

~~~

`augment`를 사용해서 일관된 규칙으로 적합값, 잔차 등을 `.`을 앞에 붙여 활용하기 쉽게 만들어 기존 변수명과 섞이는 일이 없게 되었다.


~~~{.r}
head(augment(lmfit))
~~~



~~~{.output}
          .rownames  mpg    wt  .fitted   .se.fit     .resid       .hat
1         Mazda RX4 21.0 2.620 23.28261 0.6335798 -2.2826106 0.04326896
2     Mazda RX4 Wag 21.0 2.875 21.91977 0.5714319 -0.9197704 0.03519677
3        Datsun 710 22.8 2.320 24.88595 0.7359177 -2.0859521 0.05837573
4    Hornet 4 Drive 21.4 3.215 20.10265 0.5384424  1.2973499 0.03125017
5 Hornet Sportabout 18.7 3.440 18.90014 0.5526562 -0.2001440 0.03292182
6           Valiant 18.1 3.460 18.79325 0.5552829 -0.6932545 0.03323551
    .sigma      .cooksd  .std.resid
1 3.067494 1.327407e-02 -0.76616765
2 3.093068 1.723963e-03 -0.30743051
3 3.072127 1.543937e-02 -0.70575249
4 3.088268 3.020558e-03  0.43275114
5 3.097722 7.599578e-05 -0.06681879
6 3.095184 9.210650e-04 -0.23148309

~~~

`glance` 함수를 사용해서 $R^2$, 수정 $R^2$, p-값, AIC, BIC, 편차(deviance) 각종 통계량이 한줄로 정리되었다.


~~~{.r}
glance(lmfit)
~~~



~~~{.output}
  r.squared adj.r.squared    sigma statistic      p.value df    logLik
1 0.7528328     0.7445939 3.045882  91.37533 1.293959e-10  2 -80.01471
       AIC      BIC deviance df.residual
1 166.0294 170.4266 278.3219          30

~~~

### 3. `broom` 팩키지 지원현황

`broom` 팩키지가 각 수준별로 활용가능한 현황은 다음과 같다.
`tidy`, `augment`, `glance` 3종 세트에 대해 각 모형별로 지원현황을 확인하고 `broom` 팩키지와 엮어 사용한다.


~~~{.output}
Warning: package 'dplyr' was built under R version 3.2.5

~~~



|Class                    |`tidy` |`glance` |`augment` |
|:------------------------|:------|:--------|:---------|
|aareg                    |x      |x        |          |
|anova                    |x      |         |          |
|aov                      |x      |         |          |
|aovlist                  |x      |         |          |
|Arima                    |x      |x        |          |
|biglm                    |x      |x        |          |
|binDesign                |x      |x        |          |
|binWidth                 |x      |         |          |
|boot                     |x      |         |          |
|btergm                   |x      |         |          |
|cch                      |x      |x        |          |
|cld                      |x      |         |          |
|coeftest                 |x      |         |          |
|confint.glht             |x      |         |          |
|coxph                    |x      |x        |x         |
|cv.glmnet                |x      |x        |          |
|data.frame               |x      |x        |x         |
|default                  |x      |x        |x         |
|density                  |x      |         |          |
|ergm                     |x      |x        |          |
|felm                     |x      |x        |x         |
|fitdistr                 |x      |x        |          |
|ftable                   |x      |         |          |
|gam                      |x      |x        |          |
|gamlss                   |x      |         |          |
|geeglm                   |x      |         |          |
|glht                     |x      |         |          |
|glmnet                   |x      |x        |          |
|htest                    |x      |x        |          |
|kappa                    |x      |         |          |
|kmeans                   |x      |x        |x         |
|Line                     |x      |         |          |
|Lines                    |x      |         |          |
|list                     |x      |x        |          |
|lm                       |x      |x        |x         |
|lme                      |x      |x        |x         |
|manova                   |x      |         |          |
|map                      |x      |         |          |
|matrix                   |x      |x        |          |
|merMod                   |x      |x        |x         |
|mle2                     |x      |         |          |
|multinom                 |x      |x        |          |
|nlrq                     |x      |x        |x         |
|nls                      |x      |x        |x         |
|NULL                     |x      |x        |x         |
|pairwise.htest           |x      |         |          |
|plm                      |x      |x        |x         |
|Polygon                  |x      |         |          |
|Polygons                 |x      |         |          |
|power.htest              |x      |         |          |
|pyears                   |x      |x        |          |
|rcorr                    |x      |         |          |
|ridgelm                  |x      |x        |          |
|rjags                    |x      |         |          |
|roc                      |x      |         |          |
|rowwise_df               |x      |x        |x         |
|rq                       |x      |x        |x         |
|rqs                      |x      |x        |x         |
|SpatialLinesDataFrame    |x      |         |          |
|SpatialPolygons          |x      |         |          |
|SpatialPolygonsDataFrame |x      |         |          |
|spec                     |x      |         |          |
|stanfit                  |x      |         |          |
|summary.glht             |x      |         |          |
|summaryDefault           |x      |x        |          |
|survexp                  |x      |x        |          |
|survfit                  |x      |x        |          |
|survreg                  |x      |x        |x         |
|table                    |x      |         |          |
|tbl_df                   |x      |x        |x         |
|ts                       |x      |         |          |
|TukeyHSD                 |x      |         |          |
|zoo                      |x      |         |          |

### 4. 다수 모형 [^many-models]

[^many-models]: [R for Data Science - 25 Many models](http://r4ds.had.co.nz/many-models.html)


