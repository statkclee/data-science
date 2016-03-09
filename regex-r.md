---
layout: page
title: 데이터 과학
subtitle: R 정규표현식
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---





### 학습 데이터 준비 [^regex-intro] [^regex-r] 

[^regex-intro]: [Regular Expression in R](https://stat545-ubc.github.io/block022_regular-expression.html)
[^regex-r] : [Regular Expressions and Character Data](https://stat545-ubc.github.io/block027_regular-expressions.html)

`git clone` 명령어로 정규표현식 실습을 위한 텍스트 데이터를 불러온다.
[STAT545](https://stat545-ubc.github.io/)와 연결된 [GitHub STAT545](https://github.com/STAT545-UBC/STAT545-UBC.github.io)
저장소를 클론한다.

~~~ {.shell}
$ git clone https://github.com/STAT545-UBC/STAT545-UBC.github.io.git
$ cd STAT545-UBC.github.io
~~~

GitHub 저장소에서 학습에 사용될 데이터를 가져왔으면, `list.files()` R 내부 쉘명령어로 저장소에서 로컬컴퓨터로 제대로 가져왔는지 확인한다.



~~~{.r}
install.packages("stringr")
~~~


`stringr` 팩키지에 나온 함수를 활용한다.
`stringr` 팩키지가 깔끔하고 현대적인 문자열 연산기능을 제공하고,
R에 기본으로 내장된 문자열 함수보다 사용하기 쉽고 기억하기도 좋다.
지금까지 사용한 적이 없다면, 팩키지를 설치하고 시작해본다.


~~~{.r}
library(stringr)
files <- list.files()
head(files)
~~~



~~~{.output}
[1] "_includes" "_layouts"  "_site"     "AUTHORS"   "code"      "css"      

~~~



~~~{.r}
gDat <- read.delim("gapminderDataFiveYear.txt")
~~~



~~~{.output}
Warning in file(file, "rt"): 파일 'gapminderDataFiveYear.txt'를 여는데 실패
했습니다: No such file or directory

~~~



~~~{.output}
Error in file(file, "rt"): 커넥션을 열 수 없습니다

~~~



~~~{.r}
str(gDat)
~~~



~~~{.output}
Error in str(gDat): 객체 'gDat'를 찾을 수 없습니다

~~~

문자열 함수를 사용해서 파일명을 추출한다. 예를 들어 `dplyr` 관련 문서.
`grep()` 함수를 사용해서 `dplyr` 문자열이 포함된 파일명을 식별한다.
인자값을 `value = TRUE` 으로 설정하면, `grep()` 함수가 매칭되는 것을 반환하는 반면에, `value = FALSE` 로 설정하면, 인덱스를 반환한다.
`invert` 인자를 사용하면, 지정된 패턴을 제외한 모든 것을 반환한다.
`grepl()` 함수는 유사한 함수지만, 논리벡터를 반환한다.
자세한 정보는 [여기](http://www.rdocumentation.org/packages/base/functions/grep)를 참조한다.


~~~{.r}
grep("dplyr", files, value = TRUE)
~~~



~~~{.output}
[1] "data-handling-dplyr.html" "data-handling-dplyr.md"  
[3] "data-handling-dplyr.Rmd" 

~~~



~~~{.r}
grep("dplyr", files, value = FALSE)
~~~



~~~{.output}
[1] 11 12 13

~~~



~~~{.r}
grepl("dplyr", files)
~~~



~~~{.output}
  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
 [12]  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [34] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [45] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [56] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [67] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [78] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [89] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[100] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[111] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[122] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[144] FALSE

~~~

`dplyr` 팩키지와 관련된 모든 숙제 파일을 뽑아내려면 어떨까?
`hw` 문자열과 중간에 문자열 그리고 `dplyr` 문자열을 매칭하도록 명세할 필요가 있다.
이런 경우에 정규표현식이 편리하다.

### 정규표현식과 관련된 문자열 함수

정규표현식은 공통된 구조를 갖는 특정 문자열을 기술하는 패턴이다.
특정 구문에서 언어마다 약간 차이가 날 수 있지만, 모든 프로그래밍 언어에서 
공통적으로 문자열 매칭/치환에 사용되는 것이 정규표현식이다.
문자열 연산에 있어 정규표현식은 심장과 영혼이다.
`base` R과 `stringr` 팩키지 모두 문자열 함수는 정규표현식을 사용한다.
심지어 RStudio 찾기와 바꾸기 기능도 정규표현식을 허용한다.

  * 패턴과 매칭되는지 확인 : `grep(..., value = FALSE)`, `grepl()`, `stringr::str_detect()`
  * 패턴과 매칭되는 것을 추출 : `grep(..., value = TRUE)`, `stringr::str_extract()`, `stringr::str_extract_all()`
  * 문자열 내부에 패턴을 위치, 즉 매칭된 패턴의 시작점 부여 : `regexpr()`, `gregexpr()`, `stringr::str_locate()`, `string::str_locate_all()`
  * 매칭된 패턴 바꾸기 : `sub()`, `gsub()`, `stringr::str_replace()`, `stringr::str_replace_all()`
  * 패턴을 사용해서 문자열 쪼개기 : `strsplit()`, `stringr::str_split()`

### 정규표현식 구문

일반적으로 정규표현식은 문자열 내부에 반복되는 정보와 위치정보로 검색할 문자열 (혹은 문자열 클래스)를 명세한다.
특수한 의미를 갖는 메타문자를 사용해서 이런 작업을 완수한다: `$ * + . ? [ ] ^ { } | ( ) \`.
다음에 단순하고 작은 예제를 통해 정규표현식 구문과 메타문자가 어떤 의미도 함께 소개한다.

### 확장 문자열 (Escape Sequence)

문자열로 직접적으로 부호화할 수 없는 특수한 문자가 있다.
예를 들어, 단일 인용부호를 패턴으로 두고 단일 인용부호(`'`)를 갖는 국가를 검색한다고 가정하자.
패턴에서 단일 인용부호 앞에 `\` 부호를 넣어서 단일 인용부호를 "빠져나오게(escape)" 만들어야 한다.
그렇게 함으로써 문자열에서 명세하는 부분이 아님을 분명히 한다.


~~~{.r}
grep('\'', levels(gDat$country), value = TRUE)
~~~



~~~{.output}
Error in levels(gDat$country): 객체 'gDat'를 찾을 수 없습니다

~~~

R에는 확장 문자가 또 있다.
정규표현식을 포함해서, R에 모든 문자열함수에 동일한 규칙이 적용된다.
R 확장 문자열에 대한 전체 목록은 [여기](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Quotes.html)서 확인한다.

  * `\'`: 단일 인용부호. 
          이중 인용부호 내부에 있는 단일 인용부호를 빠져나올 필요는 없다. 그래서 앞선 예제에서 `"'"`도 사용한다.
  * `\"`: 이중 인용부호.
          마찬가지로 단일 인용부호 내부에 이중 인용부호를 사용할 수 있다. 즉, `'"'`.          
  * `\n`: 개행문자.
  * `\r`: 복귀문자.
  * `\t`: 탭문자.

> 주목: `cat()` 함수와 `print()` 함수는 확장문자열을 다르게 처리한다.
> 확장문자열을 해석된 그대로 문자열을 출력하려면, `cat()` 함수를 사용한다.


~~~{.r}
print("a\nb")
~~~



~~~{.output}
[1] "a\nb"

~~~



~~~{.r}
cat("a\nb")
~~~



~~~{.output}
a
b

~~~

### 정량자(Quantifiers)

정량자는 패턴을 얼마나 많이 반복할지 명세한다.

  * `*`: 적어도 0 번 매칭한다.
  * `+`: 적어도 1 번 매칭한다.
  * `?`: 많아아 1 번 매칭한다.
  * `{n}`: 정확히 n 번 매칭한다.
  * `{n,}`: 적어도 n 번 매칭한다.
  * `{n,m}`: n 번에서 m 번 매칭한다.


~~~{.r}
(strings <- c("a", "ab", "acb", "accb", "acccb", "accccb"))
~~~



~~~{.output}
[1] "a"      "ab"     "acb"    "accb"   "acccb"  "accccb"

~~~



~~~{.r}
grep("ac*b", strings, value = TRUE)
~~~



~~~{.output}
[1] "ab"     "acb"    "accb"   "acccb"  "accccb"

~~~



~~~{.r}
grep("ac+b", strings, value = TRUE)
~~~



~~~{.output}
[1] "acb"    "accb"   "acccb"  "accccb"

~~~



~~~{.r}
grep("ac?b", strings, value = TRUE)
~~~



~~~{.output}
[1] "ab"  "acb"

~~~



~~~{.r}
grep("ac{2}b", strings, value = TRUE)
~~~



~~~{.output}
[1] "accb"

~~~



~~~{.r}
grep("ac{2,}b", strings, value = TRUE)
~~~



~~~{.output}
[1] "accb"   "acccb"  "accccb"

~~~



~~~{.r}
grep("ac{2,3}b", strings, value = TRUE)
~~~



~~~{.output}
[1] "accb"  "acccb"

~~~

> 도전과제 {.challenges}
>
> 정량자를 사용해서 `gapminder` 데이터프레임에서 `ee` 문자열을 갖는 모든 국가를 찾아라.


~~~{.output}
Error in levels(gDat$country): 객체 'gDat'를 찾을 수 없습니다

~~~

### 문자열 내부 패턴 위치

  * `^`:  문자열 시작위치를 매칭.
  * `$`: 문자열 끝위치를 매칭.
  * `\b`: *단어* 양쪽 끝에 위치한 빈문자열을 매칭. 문자열 끝을 표식하는 `^$`와 혼동하지 않는다.
  * `\B`: 단어 끝에 위치하지 않는 빈문자열을 매칭.


~~~{.r}
(strings <- c("abcd", "cdab", "cabd", "c abd"))
~~~



~~~{.output}
[1] "abcd"  "cdab"  "cabd"  "c abd"

~~~



~~~{.r}
grep("ab", strings, value = TRUE)
~~~



~~~{.output}
[1] "abcd"  "cdab"  "cabd"  "c abd"

~~~



~~~{.r}
grep("^ab", strings, value = TRUE)
~~~



~~~{.output}
[1] "abcd"

~~~



~~~{.r}
grep("ab$", strings, value = TRUE)
~~~



~~~{.output}
[1] "cdab"

~~~



~~~{.r}
grep("\\bab", strings, value = TRUE)
~~~



~~~{.output}
[1] "abcd"  "c abd"

~~~

> 도전과제 {.challenges}
>
> 해당 디렉토리에 `.txt` 확장자를 갖는 모든 파일을 찾는다.
> 
> 
> ~~~{.output}
> [1] "requirements.txt"
> 
> ~~~

### 연산자

  * `.`: 어떤 문자 하나와 매칭. 
  * `[...]`: 문자 리스트. 꺾쇠괄호 내부에 지정된 문자중 하나와 매칭.
              문자범위를 지정하는데 꺽쇠 내부에 `-`도 사용가능. 
  * `[^...]`: 반전문자 리스트. `[...]`와 유사하지만, 꺾쇠괄호 내부에 있는 것을 **제외**한 문자 어떤 것이나 매칭 
  * `\`: 정규표현식 메타문자가 갖는 특수한 의미를 억제. 즉, `$ * + . ? [ ] ^ { } | ( ) \` 확장문자열 사용과 유사함. R에서 `\` 자체가 탈출할 필요가 있기 때문에, `\\$`처럼 역슬래쉬를 두개 사용해서 이런 메타문자를 탈출시킨다.   
  * `|`: "or" 또는 연산자. `|` 어느쪽이든 패턴을 매칭.  
  * `(...)`: 정규표현식에 있는 그룹연산자. 정규표현식으로 매칭된 부분을 나중에 불러올 수 있어서 추후 변경을 하거나 새로운 문자열을 만들어 내는데 사용할 수 있다. 각 그룹을 `\\N` 을 사용해서 참조할 수 있다. N은  `(...)` 에서 나온 번호에 해당되는 N 이다. 이것을 **역참조(backreference)**라고 부른다.

  
  ~~~{.r}
  (strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12"))
  ~~~
  
  
  
  ~~~{.output}
  [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("ab.", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "abc"   "abd"   "abe"   "ab 12"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("ab[c-e]", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "abc" "abd" "abe"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("ab[^c]", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "abd"   "abe"   "ab 12"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("^ab", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "ab"    "abc"   "abd"   "abe"   "ab 12"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("\\^ab", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "^ab"
  
  ~~~
  
  
  
  ~~~{.r}
  grep("abc|abd", strings, value = TRUE)
  ~~~
  
  
  
  ~~~{.output}
  [1] "abc" "abd"
  
  ~~~
  
  
  
  ~~~{.r}
  gsub("(ab) 12", "\\1 34", strings)
  ~~~
  
  
  
  ~~~{.output}
  [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 34"
  
  ~~~

> 도전과제 {.challenges}
>
> `i` 혹은 `t` 를 포함하고, `land`로 끝나는 국가를 `gapminder` 에서 찾아 역참조를 사용해서 `land`를 `LAND`로 치환한다.
> 
> 
> ~~~{.output}
> Error in levels(gDat$country): 객체 'gDat'를 찾을 수 없습니다
> 
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in grep("LAND", countries, value = TRUE): 객체 'countries'를 찾을 수 없습니다
> 
> ~~~

### 문자열 클래스

문자열 클래스는 문자열 클래스 전체 예를 들어, 문자, 숫자를 명세하도록 한다. 문자열 클래스에 대한 두가지 선호방식이 존재한다. 한방식은 
꺾쇠괄호 내부 사전에 정의된 이름을 `[:`와 `:]` 사이에 사용하는 것이고, 또다른 방식은 `\` 와 특수문자를 사용하는 것이다. 두가지 방식은 때때로 상호바꿔서 사용가능하다.

  * `[:숫자:]` 혹은 `\d` : 숫자, 0,1,2,3,4,5,6,7,8,9, 동등한 표현 `[0-9]`.
  * `\D` : 숫자가 아님, 동등한 표현 `[^0-9]`.
  * `[:영문 소문자:]` : 영문 소문자, 동등한 표현 `[a-z]`.
  * `[:영문 대문자:]` : 영문 대문자, 동등한 표현 `[A-Z]`.
  * `[:알파벳:]` : 알파벳 대소문자, 동등한 표현 `[[:영문 소문자:][:영문 대문자:]]` 혹은 `[A-z]`
  * `[:알파벳숫자:]` : 알파벳 숫자 문자, 동등한 표현 `[[:알파벳:][:숫자:]]` 혹은 `[A-z0-9]`.
  * `\w` : 단어 문자,  











