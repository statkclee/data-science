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

파일로 저장할 필요가 있는 것을 컴퓨터로 돌릴 필요가 있다.
회귀분석을 돌린 모형의 기울기와 절편만 저장하자.


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

`gfits` 데이터프레임은 후행 분석작업 혹은 시각화로
향후 사용될 중간 결과물에 대한 한 사례다.

#### 데이터 내보내서 저장하기

R의 기본 내보내기 함수가 `write.table()`다. 


~~~{.r}
write.table(gfits, "gfits.tsv")
~~~

`gfits.tsv` 파일 앞부분 몇줄을 살펴보자. 아래 출력결과를 시연하려면,
파일을 열거나, 쉘에서 `head` 명령어로 확인한다.


~~~{.output}
"country" "continent" "intercept" "slope"
"1" "Afghanistan" "Asia" 29.9072948717949 0.275328671328671
"2" "Albania" "Europe" 59.2291282051282 0.334683216783216
"3" "Algeria" "Africa" 43.3749743589744 0.56927972027972
"4" "Angola" "Africa" 32.1266538461539 0.20933986013986
"5" "Argentina" "Americas" 62.6884358974359 0.231708391608391

~~~

무엇보다도 인용부호가 포함된 것은 참을 수가 없다. 행명칭(rownames)도 인용부호로 감싸졌다!
시각적으로 정렬이 맞지않고, 그다지 깔끔하다는 느낌이 없다.

- 문자 정보를 인용부호로 보호한다. (맞는 말이다, 요소는 이런 목적에 부합되는 문자로 파일에 
  이와같은 형식으로 저장된다) 문제는 변수명, 행명칭, 변수 자체에 영향을 준다. 미래 특정시점에 다시 가져와서 불러오기 할때
  인용부호가 꼭 필요한 것은 아니다. 특히, R로 다시 불러올 때 인용부호는 필요하지 않아서,
  흔히 비활성화 시킨다. 
- 숫자형 기본디폴트설정된 행명칭(rownames)은 불필요하다. 저자는 절대로 행명칭을 사용하지 않는다.
  행명칭 정보가 중요하다면, 적절한 변수로 들어가는 것이 맞다.
- 시각적인 정렬이 마음에 들지 않는다고 불평하는 것은 말이 되지 않는다.
  [write code for humans, write data for computers](https://twitter.com/vsbuffalo/statuses/358699162679787521)
  라는 주장을 기억하라. 데이터를 살펴보고 싶다면, 엑셀에서 열어서 살펴보라.
  하지만, 데이터 솜씨있게 조작은 하지마라... 다시 R로 돌아가서 "가져오기/정제/통계분석/내보내기" 작업을
  스크립트에 R 명령어로 작성하라. 저자를 믿어라. 이루어진다!

다시 파일에 저장하는데, `write.table()` 함수에 인수를 전달하여 개발자의 의지를 반영한다.


~~~{.r}
write.table(gfits, "gfits.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
~~~

다시 저장한 파일 앞부분 몇줄을 살펴보자:


~~~{.output}
country	continent	intercept	slope
Afghanistan	Asia	29.9072948717949	0.275328671328671
Albania	Europe	59.2291282051282	0.334683216783216
Algeria	Africa	43.3749743589744	0.56927972027972
Angola	Africa	32.1266538461539	0.20933986013986
Argentina	Americas	62.6884358974359	0.231708391608391

~~~

이제 `readr` 팩키지에는 이에 상응하는 더 깔끔한 인터페이스 외양을 갖추고 있다.


### `saveRDS()` 와 `readRDS()`

데이터프레임과 함께 요소 수준을 작업한 결과 등을 그대로 저장하고자 한다면 `saveRDS()` 함수를 사용한다.
이런 경우 `readRDS()` 함수로 `.rds` 파일을 불러오게 되면 모든 정보가 그대로 유지된다.

```{r}
saveRDS(gfits, "gfits.rds")
```

`saveRDS()` 함수는 R 객체를 이진파일로 직렬화한다. 편집기로 열거나, Git(Hub)로 차이점을 살펴보거나,
R 사용자가 아닌 친구와 공유할 수 있는 성질의 파일이 아니다. 
특별한 상황에서 전용목적을 갖고, 한정된 범위를 갖고 사용된다.

`saveRDS()` 반대가 `readRDS()` 다. `readRDS()` 함수로 불러오면 반환값을 갖게 되는데 이를 객체에 대입해야만 된다.
저장할 때와 마찬가지로 동일한 명칭을 갖는 것을 저자가 추천하고 있다.

```{r error = TRUE}
rm(gfits)
gfits
gfits <- readRDS("gfits.rds")
gfits
```

`saveRDS()` 함수는 인자가 더 있다. 특히, `compress` 인자는 압축을 제어하는데 사용되는데 
자세한 사용법은 도움말을 확인한다.
연산작업에 상당한 시간이 소요되는 (직사각형 모양의 데이터프레임과 대비되는) 회귀모형을 적합한 객체를 저장하는데 매우 손쉽다.

`save()` + `load()`, `save.image()` 함수에 대해서 익히 알고 있을 수도 있다.
R 공식문서와 강의교재에서도 보았을 수도 있지만, 절대로 흔들리지 마라.
이런 함수는 객체 다수를 함께 저장하거나, 혹은 심지어 전체 작업공간을 한통에 저장하는 안정성이 검증되지 않는 
실무사례를 조장하고 있다. 이런 유형의 함수가 적용되는 적법한 사용례가 있지만, 
일반적인 자료분석에는 그런 사례가 적용되지 못한다.

### `dput()` 과 `dget()`

마지막으로 언급할 가치가 있는 데이터를 가져오고 저장하는 방법이 있다: `dput()` 과 `dget()`.
`dput()` 함수는 기묘한 기능조합으로 볼 수 있다: 이해하게 힘든 방식으로 R 객체를 일반 텍스트로 표현한다.
`file=` 인자가 사용되면, `dput()` 함수는 파일에 저장하지만, 실제 눈으로 읽고 싶은 생각이 들지는 않는다.
`dput()` 함수는 R전용이지만 바이너리 표기를 생성한다. 다음을 실행해 보자.


```{r}
## first restore gfits with our desired country factor level order
gfits <- readRDS("gfits.rds")
dput(gfits, "gfits-dput.txt")
```

`gfits-dput.txt` 파일 첫몇줄을 살펴보자.

```{r echo = FALSE, comment = NA}
"gfits-dput.txt" %>% 
  readLines(n = 6) %>% 
  cat(sep = "\n")
```

걱정하지는 마라.  ["write code for humans, write data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521)
 트윗을 기억하라. `dget()` 짝꿍 함수는 `dput()`으로 저장한 것을 다시 불러 읽어온다.

```{r}
gfits_dget <- dget("gfits-dput.txt")
country_levels <- country_levels %>% 
  mutate(via_dput = head(levels(gfits_dget$country)))
country_levels
```

`dput()`, `dget()` 함수의 주된 응용사례는 스택오버플로우 
[the creation of highly portable, self-contained minimal examples](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example)
에 잘 정리되어 있다. 
예를 들어, 지식인에 질문을 올리고 전문가에게 질문하려면, 어떤 데이터 파일도 첨부를 못하고 일반 텍스트만 사용해서 질문내용을 정리해야만 된다.
질문내용에 필요한 코드와 함께 객체를 정의하는 몸통하나로 된 일반텍스트가 요구된다.
`dput()`이 객체를 정의하는 코드 일부를 만들어내는데 도움이 된다.
파일을 지정하지 않고 `dput()` 하려면, 콘솔에서 나온 반환값을 복사해서 스크립트에 붙여넣는다.
혹은 파일에 저장하고 나서 파일을 열어 복사해서 R 명령어 아래 추가한다.

### 마무리 청소

자료분석 작업을 하면서 파일 몇개 작성했다. 일부는 가치가 오래가지 못하거나, 파일명이 혼동스러울 수 있다.
파일시스템과 상호작용하는데 R이 제공하는 함수를 사용해서도 가능하다.

```{r}
file.remove(list.files(pattern = "^gfits"))
```

### 구분자를 갖는 파일이 갖는 함정들

구분자를 갖는 파일에 사람이 입력한 필드가 담겨있다면, 편집증적일 수 있는데 이유는 사람들이 정말 말도 안되는 일을 저지른다.
특히 프로그래밍 분야와 관계가 없거나 텍스트로 작업한 적이 없는 사람인 경우 그렇다.
이런 사람들이 생성하는 파일을 처리하는데는 이들이 갖는 정규표현식 기술과 반비례하는 경향이 있다:
즉, 정규표현식을 전혀 들어본 적이 없다면, 이런 분들이 작업한 파일을 작업하는데 상당한 노력이 요구되고, 고생길이 열려있다.

헤더 필드 혹은 실제 데이터가 구분자를 갖는 경우, 파싱에 실패하거나 가져오기 오류가 날 수 있다.
가장 일반적인 구분자는 콤마 `,`와 탭 `\t`로 타이핑할 때 사람들이 흔히 사용한다.
데이터를 수집하는 동안 문제를 회피하려면, 입력양식에 드롭다운 메뉴 같은 것 등으로 최대한 회피한다.
때때로 이것이 불가능해서 어쩔 수 없다면, 자유형식 텍스트로 처리해야만 된다.
인용부호로 감싸서 텍스트를 강제하거나 허용하는 것이 좋은데 이유는 구분자 파일을 좀더 부드럽게 파싱하게 한다.

종종 엄격한 탭구분자 대신에 공백을 구분자로 사용한다. 즉, `read.table()`과 `write.table()` 함수 모두 
기본디폴트 설정으로 공백이 사용된다. 첫번째 행에서 변수명을 읽거나 쓰는 경우
(`write.table()`, `read.table()` 함수에서 `header`로 불림), 적법한 R 변수명이 있거나,
적법한 것으로 강제로 치환해야된다. 
그래서, 이런 두가지 이유로, 가능하면 변수명은 "한단어"로 작성하는 것이 모범사례가 된다.
단어 다수가 사용되는 경우, `snake_case` 나 `camelCase` 를 사용한다.
예를 들어, 피험자 성씨를 갖는 필드명을 헤더로 사용하는 경우 `last_name` 혹은 `lastName`으로 작성한다.
`readr` 팩키지의 경우, 칼럼명은 적법한 R 식별자로 정리되기 보다는, 있는 그대로 남겨진다.
(즉, `check.names = TRUE`이 없다) 그래서 변수명에서 공백을 갖고 그럭저럭 넘어갈 수 있지만, 변수명에 공백을 넣는 것을
추천하지 않는다.


### 참고자료

Ethan P White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, Sarah R. Supp, "Nine simple ways to make it easier to (re)use your data"

- 최초 출판: [PeerJ Preprints 1:e7v2](http://dx.doi.org/10.7287/peerj.preprints.7v2)
- 공식 출판: [Ideas in Ecology and Evolution 6(2): 1?10, 2013.](http://library.queensu.ca/ojs/index.php/IEE/article/view/4608)
    + [doi:10.4033/iee.2013.6b.6.f](doi:10.4033/iee.2013.6b.6.f)
- 특히 4절 "Use Standard Data Formats" 추천.

Hadley Wickham 의 깔끔한 데이터

- [Journal of Statistical Software Vol 59 (2014), Issue 10, 10.18637/jss.v059.i10](http://www.jstatsoft.org/article/view/v059i10)
- [PDF 파일](http://vita.had.co.nz/papers/tidy-data.pdf)

Phil Spector(2008), Data Manipulation with R, Springer.

- 2장 "Reading and Writing Data" 참고
- [SpringerLink](http://ezproxy.library.ubc.ca/login?url=http://link.springer.com.ezproxy.library.ubc.ca/book/10.1007/978-0-387-74731-6/page/1)
- [저자 웹페이지](http://www.stat.berkeley.edu/~spector/)
- [구글 도서검색](http://books.google.com/books?id=grfuq1twFe4C&lpg=PP1&dq=data%2520manipulation%2520spector&pg=PP1#v=onepage&q=&f=false)

