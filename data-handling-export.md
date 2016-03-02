---
layout: page
title: 데이터 과학
subtitle: 데이터 내보내기
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---





> ## 학습 목표 [^stat545-data-inout] {.objectives}
>
> * 작업한 데이터를 내보내어 다음 후행 작업에 대한 선행작업을 깔끔히 마무리한다.
> * 일반 텍스트 파일형식으로 기본 내보내기를 한다.
> * 특정 플랫폼이나 파일형식에 종속되지 않게 작업한다.


[^stat545-data-inout]: [STAT545 - Getting data in and out of R](http://stat545-ubc.github.io/block026_file-out-in.html)

### 두가지 데이터를 가져오는 마음의 자세 

- **불러와서 정리하기**: 데이터를 일단 오류없이 불러온다. 자료탐색을 시작하고 나서, 데이터 자체나 
불로오는 과정에서 오류를 발견한다. 오류를 찾아내고, 고치고, 깨끗하게 만드는 과정을 반복한다.
- **스크립트 작성후 실행해서 불러오기**: 데이터 정제 스크립트로 깔끔하게 만든 데이터셋을 불러온다. 즉, 데이터를 불러오는 과정을
스크립트로 작성해서 명시적으로 표현한다.

**가능한 빨리, 할수 있는만큼 가져오기 함수 인자를 활용한다.** 가져오기 함수 문서를 읽고, 
데이터를 가져오는데 제어하는 최대한 인자를 활용한다. 이를 초보자가 데이터를 불어 읽어와서
뒷단에서 데이터를 처리하는 코드가 붙어 있는 것과 비교해보라.

### 데이터 내보내는 마음의 자세

R에서 데이터를 파일로 써서 내보내는 경우는 많지만, 다음 두가지 경우를 살펴보자:

- 지저분한 데이터를 엄청작업해서 깔끔하게 작성하여 모형을 적합시킬 준비가 된 깨끗한 데이터
- 데이터를 모아서 수치분석한 결과, 모형실행 결과, 통계적 추론 산출물

> #### 몇가지 팁 {.callout}
> 
> - **오늘 작업한 출력물은 내일 작업할 입력물**: 뒤돌아 생각해보면, 데이터를 가져와서 불러올 때 고생한 것이 기억날 것이다. 
> 본인을 다시 그런 구렁텅이로 몰아넣을 이유는 없다.
> - **특정 플랫폼 혹은 전용파일형식이 아닌 텍스트 파일을 사용**: 텍스트 편집기에서 사람이 읽을 수 있는 일반
> 텍스트 파일이 기본디폴트 파일 형식이 되어야 한다. 이상하거나 독점적 파일형식을 불러 읽어오거나 내보내면
> 가까운 미래 다른 컴퓨터에서 작업을 이어나가기 힘든 상황에 바로 맞닥드리게 된다.
> 또한, 다른 툴체인이나 경험을 갖고 있는 사람과 협업하는데 장벽으로 작용한다.
> 소프트웨어 중립적(Software-agnostic)이 되라. 폐물이 되는 것을 방지하고, 바보가 되는 것도 방지하라. 따라서 일반 텍스트를 
> 사용하지 못할 실증적 증거가 있지 않는한 특정플랫폼에 종속되거나 독점 파일형식을 배제한다. 

재현가능한 과학연구를 위해 가장 중요한 것이 [Sweave](http://www.stat.uni-muenchen.de/~leisch/Sweave/), 
[knitr](http://yihui.name/knitr/), [GNU make](http://www.gnu.org/software/make)와 같은 도구를 사용하는 것은 아니다.

참고: [minimal make A minimal tutorial on make](http://kbroman.org/minimal_make/)

### 데이터 불러오기

데이터를 하드디스크에 파일을 불러읽어도 되지만, 
`gapminder` 팩키지에 `gapminder.tsv` 파일이 저장되어 있어 이 파일을 바로 불러 읽어들인다.


~~~{.r}
gap_tsv <- system.file("gapminder.tsv", package = "gapminder")
gapminder <- read.table(gap_tsv, header = TRUE, sep = "\t", quote = "")
str(gapminder)
~~~



~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

R에 기본으로 설정된 가져오기 함수는 `read.table()`이다. 인자 몇개에 일반적인 값의 조합을 해서 넘겨야 되지만,
탭구분 데이터를 가진 경우, 몇가지 인자 설정을 생략할 수 있는 더욱 단순한 `read.delim()` 함수로 데이터를 불러 읽어올 
수 있다.


~~~{.r}
gapminder <- read.delim(gap_tsv)
str(gapminder)
~~~



~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

콤마구분자인 경우 `read.csv()` 함수가 `read.delim()` 함수와 유사한 편의성 기능을 제공한다.

마지막으로 가장 최근 팩키지를 역자도 추천한다. `readr` 팩키지로 `read_excel()`, `read_csv()` 등 일관된 기능을 제공한다.
[readr CRAN](https://cran.r-project.org/web/packages/readr/index.html),
[readr GitHub](https://github.com/hadley/readr) 참고한다.


~~~{.r}
library(readr)
gapminder <- read_tsv(gap_tsv)
str(gapminder)
~~~



~~~{.output}
Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

`readr` 기본디폴트 동작으로 유념할 점은 **문자열(string)을 요소(factor) 자료형으로 변경하지 않는다**는 것이다.
즉, `country`와 `continent`는 가져와서 불러읽어들이면 자료형이 문자형이다.
크게 생각해 보면, 문자열을 다시 요소자료형으로 변경해야 되지만, 이런 것이 더 나은 기본디폴트 동작유형이다.
일반적으로, `readr` 팩키지를 사용하게 되면 뒷단에 더 적은 작업량이 배정된다.


~~~{.r}
gapminder$country <- factor(gapminder$country)
gapminder$continent <- factor(gapminder$continent)
str(gapminder)
~~~



~~~{.output}
Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

`readr` 팩키지에 대한 소품문을 읽고 진정한 강력함을 느껴보기 바란다. 
[칼럼 자료형](https://cran.r-project.org/web/packages/readr/vignettes/column-types.html) 참고.


### 데이터 내보내기


~~~{.r}
suppressPackageStartupMessages(library(dplyr))
le_lin_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  setNames(data.frame(t(coef(the_fit))), c("intercept", "slope"))
}
gfits <- gapminder %>%
  group_by(country, continent) %>% 
  do(le_lin_fit(.)) %>% 
  ungroup()
gfits
~~~



~~~{.output}
Source: local data frame [142 x 4]

       country continent intercept     slope
        (fctr)    (fctr)     (dbl)     (dbl)
1  Afghanistan      Asia  29.90729 0.2753287
2      Albania    Europe  59.22913 0.3346832
3      Algeria    Africa  43.37497 0.5692797
4       Angola    Africa  32.12665 0.2093399
5    Argentina  Americas  62.68844 0.2317084
6    Australia   Oceania  68.40051 0.2277238
7      Austria    Europe  66.44846 0.2419923
8      Bahrain      Asia  52.74921 0.4675077
9   Bangladesh      Asia  36.13549 0.4981308
10     Belgium    Europe  67.89192 0.2090846
..         ...       ...       ...       ...

~~~

















### 참고자료
