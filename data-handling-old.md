---
layout: page
title: 데이터 과학
subtitle: R 이전 교육자료 (2015)
---
> ## 학습 목표 {.objectives}
>
> * SQL 개념을 이해한다.


### 2. R과 자료 구조

#### 2.0. 최신 버젼 R 설치

우분투 trusty R 최신버젼 설치에 대한 자세한 원문은 [CRAN 웹사이트](http://cran.r-project.org/bin/linux/ubuntu/)를 참조한다.

1. `/etc/apt/sources.list` 파일 하단에 `deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu/ trusty/` 내용을 추가한다.
    - [CRAN 미러](http://cran.r-project.org/mirrors.html)에서 버클리 대학을 선정했다. 다른 곳을 지정해도 된다.
2. 우분투 보안 APT 키를 가져온다. 

~~~ {.input}
root@docker:~# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
root@docker:~# gpg --hkp://keyserver keyserver.ubuntu.com:80 --recv-key E084DAB9
~~~
3. apt-key에 집어넣는다.

~~~ {.input}
root@docker:~# gpg -a --export E084DAB9 | sudo apt-key add 
~~~

4. 바이러리 R을 설치한다. 만약 소스코드에 R 팩키지를 컴파일한다면 `r-base-dev` 도 함께 설치한다.

~~~ {.input}
root@docker:~# sudo apt-get update && sudo apt-get install r-base
root@docker:~# sudo apt-get install r-base-dev
~~~

5. 원문은 [스택오버플러어 웹사이트](http://stackoverflow.com/questions/10476713/how-to-upgrade-r-in-ubuntu)를 참조한다.

~~~ {.output}
root@docker:~# R

R version 3.2.1 (2015-06-18) -- "World-Famous Astronaut"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R은 자유 소프트웨어이며, 어떠한 형태의 보증없이 배포됩니다.
또한, 일정한 조건하에서 이것을 재배포 할 수 있습니다.
배포와 관련된 상세한 내용은 'license()' 또는 'licence()'을 통하여 확인할 수 있습니다.

R은 많은 기여자들이 참여하는 공동프로젝트입니다.
'contributors()'라고 입력하시면 이에 대한 더 많은 정보를 확인하실 수 있습니다.
그리고, R 또는 R 패키지들을 출판물에 인용하는 방법에 대해서는 'citation()'을 통해 확인하시길 부탁드립니다.

'demo()'를 입력하신다면 몇가지 데모를 보실 수 있으며, 'help()'를 입력하시면 온라인 도움말을 이용하실 수 있습니다.
또한, 'help.start()'의 입력을 통하여 HTML 브라우저에 의한 도움말을 사용하실수 있습니다
R의 종료를 원하시면 'q()'을 입력해주세요.

>
~~~




#### 2.4. `apply` 함수

자료는 기본적으로 *벡터(Vector)*를 기본으로 한다. 하지만 벡터로 표현될 수 있는 정보량은 한정되어 있으며 이를 하나의 자료 형태로 구조화한 것을 *데이터프레임(dataframe)*으로 볼 수 있다. 따라서, 자료분석을 위한 기본 자료구조가 데이터프레임이 된다.

R을 사용하는 방법 중 하나는 반복을 통해 한번에 하나씩 연산을 수행하기 보다 단 한번 *호출(call)*을 통해 전체 벡터 연산을 수행한다. 또한 `apply` 함수를 사용해서 행, 열, 리스트에 대해 동일 연산을 수행한다. 또한 `reduce`를 사용해서 함수형 프로그래밍도 확장해서 수행한다.


 - `lapply(리스트, 함수)` : 리스트(list) 자료형에 `apply` 함수를 적용하여 데이터를 처리한다.
 - `sapply(리스트, 함수)` : `lappy` 함수와 동일하나 리스트 대신에 벡터를 반환한다.
 - `mapply(함수,리스트1,리스트2,...)` : 병렬로 다수 리스트에 대해서 `apply` 함수로 데이터를 처리한다.
 - `tapply(x,요인변수,함수)` : 요인변수(factor)에 맞춰 `apply` 함수로 데이터를 처리한다. 
 - `vapply(리스트,함수,...)` : `lappy`의 고속처리 버젼.

가공되지 않은 원자료(raw data)에서 자료를 자유자재로 다룰 수 있도록 수십년동안 수많은 통계/공학자들이 아낌없이 시간을 기부해 주었기 때문에 과거에는 전문가들만 할 수 있었던 고도의 어려운 작업도 정확하고 수월하게 수행할 수 있다. 

그 외에도 다양한 팩키지(package)를 파이썬과 마찬가지로 제공하여 R을 선택하는 순간 자료 분석, 모형, 제품화에 대해 강력한 무기를 손에 넣게 된다. 

특히 `SQL`을 통해서 **데이터 조작(Data Manipulation)**에 대한 개념 잡고 `쉘(shell)`을 통한 작업 자동화 개념을 익히고, 패키지를 사용하면 추구하는 바를 신속하고 정확하게 달성할 수 있다. 


#### 3.4. R 시작과 끝 (맛보기)

R이 설치되고, 필요한 패키지가 준비되면 분석에 사용할 데이터를 작업 메모리상에 올려야 한다. 분석 데이터를 R 작업공간에 준비하는 방법은 어려가지가 있다. Web URL을 활용한 웹 데이터를 가져오거나, `read.table`을 이용한 로컬 디스크 상의 데이터를 메모리로 불러올 수 있다.

~~~ {.input}
> abalone <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"), header=F)
> names(abalone) <- c("Sex","Length","Diameter","Height","Whole weight","Shucked weight","Viscera weight","Shell weight","Rings")
> head(abalone)
~~~

~~~ {.out}
  Sex Length Diameter Height Whole weight Shucked weight  Viscera weight Shell weight Rings
1   M  0.455    0.365  0.095       0.5140         0.2245          0.1010        0.150    15
2   M  0.350    0.265  0.090       0.2255         0.0995          0.0485        0.070     7
3   F  0.530    0.420  0.135       0.6770         0.2565          0.1415        0.210     9
4   M  0.440    0.365  0.125       0.5160         0.2155          0.1140        0.155    10
5   I  0.330    0.255  0.080       0.2050         0.0895          0.0395        0.055     7
6   I  0.425    0.300  0.095       0.3515         0.1410          0.0775        0.120     8
~~~

분석을 진행하기 위해서 간단한 R 스크립트를 작성하여 보자. 메뉴상단의 `File > New File > R Script` 혹은 `CTRL+SHIFT+N` 단축키를 사용하여 데이터 분석 결과를 스크립트로 작성하여 저장할 수 있다. 분석이 완료된 스크립트는 `SimpleR.R`로 저장한다.

~~~ {.input}
# 기본 분석 스크립트
abalone <- read.csv("abalone.csv")
table(abalone$Sex)
plot(Length ~ Sex, data=abalone)
~~~

~~~ {.output}
> # 기본 분석 스크립트
> abalone <- read.csv("abalone.csv")
> table(abalone$Sex)
   F    I    M 
1307 1342 1528 
> plot(Length ~ Sex, data=abalone)
~~~

자료 분석 결과는 코드, 데이터, 그래프, 테이블로 나타나게 되며 이를 하나의 문서로 각각 정리하는 것은 매우 수고스러운 일이며 기본적으로 기계나 컴퓨터가 해야되는 일중의 하나이다. 이를 위해서 RStudio의 Notebook 기능을 사용한다. 먼저 RStudio의 Notebook 도 `knitr` 패키지와 `Rmarkdown` 같은 패키지를 기반으로 하지만 `knitr` 패키지를 설치하면 모든 의존성을 자동으로 해결해 준다. `knitr` 패키지를 설치한 후에 메뉴상단의 `File > Compile Notebook…` 을 클릭하면 팝업메뉴가 뜨며 제목과 저자를 표시하면 코드, 데이터, 그래프, 테이블 등 정리된 결과를 HTML 파일로 얻을 수 있다. 

~~~ {.input}
install.packages("knitr")
~~~

R 코드, 그림, 테이블, 텍스트와 함께 하나의 작업파일로 데이터 제품을 만들 수 있다. Notebook, Markdown, HTML, LaTex 등 총 4가지 방법이 있으나 RStudio를 사용할 경우 Built-in 된 Notebook을 사용하는 것도 좋은 방법이며, Markdwon, LaTex, HTML등 친숙한 방법을 사용할 수도 있다.

<table>
  <tr><th>Markup 시스템</th><th>입력파일(Input)</th><th>리포트파일(Output)</th></tr>
  <tr><td>Notebook</td><td>.R</td><td>.html (.md 경유)</td></tr>
  <tr><td>Markdown</td><td>.Rmd</td><td>.html (.md 경유)</td></tr>
  <tr><td>HTML</td><td>.Rhtml</td><td>.html</td></tr>
  <tr><td>LaTeX</td><td>.Rnw</td><td>.pdf (.tex 경유)</td></tr>
</table>

RStudio_RMarkdown 을 이용하여 작업파일을 만든 후에 `knit HTML` 버튼을 누루면 HTML 파일을 바로 얻을 수 있다. 

어느 소프트웨어도 마찬가지지만 사용하다보면 오류가 발생하고 이를 확인해야 할 때가 있다. `RStudio`의 경우 `Help>Diagnostics>Show log files` 를 통해서 확인가능하다. `R`과 `Rstudio` 관련 도움말은 google 검색이나, [stack exchange](http://stackexchange.com/)를 통해 얻을 수 있다. 작업을 하다면 콘솔화면을 깨끗이하고 다시 시작하고 싶은 경우가 있다. 윈도나 도스의 경우 `cls` 명령어가 있는데 R에는 딱히 그런 명령어가 없다. 이런 경우 사용자 정의 함수를 하나 만들어서 실행할 수 있다. 

~~~ {.input}
> cls <- function() cat(rep("\n",50))
> cls()
~~~

하지만, 매번 R을 실행할 때마다 반복적으로 해야되기 때문에 R이 시작될 때 자동으로 설정을 하는 방법은 초기 실행 환경파일에 이를 적용하는 것이다. `C:\Program Files\R\R-3.1.0\library\base\R\RProfile` 파일을 텍스트 편집기로 열어 하단에 ``cls`` 함수를 적어두고 저장한다. 혹은, `CTRL+L` 키를 눌러 화면을 깨끗이하며 커서를 맨 위 상단으로 이동한다.

~~~ {.input}
….
local({
    br <- Sys.getenv("R_BROWSER", NA_character_)
    if(!is.na(br)) options(browser = br)
    tests_startup <- Sys.getenv("R_TESTS")
    if(nzchar(tests_startup)) source(tests_startup)
})

# User Defined Functions
cls <- function() cat(rep("\n",50))
~~~

### 4. R 팩키지 개발

#### 4.1. R 팩키지 개발 툴체인 설치

R 버젼이 3.2.0. 이상이며, 소스코드로부터 팩키지를 컴파일할 수 있는 `r-base-dev`이 설치되어 있어야 한다.
R 팩키지는 RStudio를 통해서 개발한다. 자세한 RStudio 설치는 [다음 웹사이트](06-install-shiny-rstudio.html)를 참조한다.

~~~ {.input}
root@csunplugged:~# apt-get install libcurl4-openssl-dev
root@csunplugged:~# wget http://cran.r-project.org/src/contrib/httr_1.0.0.tar.gz
~~~

~~~ {.input}
> install.packages("RCurl")
> install.packages("curl")
> install.packages("httr_1.0.0.tar.gz", repos = NULL, type = "source")
> install.packages(c("devtools", "roxygen2", "testthat", "knitr"))
> install.packages("rstudioapi")
> rstudioapi::isAvailable("0.98.1103")
> devtools::install_github("hadley/devtools")
> has_devel()
~~~

~~~ {.output}
'/usr/lib/R/bin/R' --no-site-file --no-environ --no-save --no-restore CMD SHLIB foo.c 

gcc -std=gnu99 -I/usr/share/R/include -DNDEBUG
  -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 
  -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c foo.c -o foo.o
gcc -std=gnu99 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions 
  -Wl,-z,relro -o foo.so foo.o -L/usr/lib/R/lib -lR
[1] TRUE
~~~

이제 R 팩키지 개발환경이 완성되었으니 `devtools::session_info()` 명령어로 R 시스템 정보를 살펴본다.

~~~ {.input}
> library(roxygen2)
> library(testthat)
> devtools::session_info()
~~~

~~~ {.input}
Session info ------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.2.1 (2015-06-18)
 system   x86_64, linux-gnu           
 ui       RStudio (0.98.1103)         
 language (EN)                        
 collate  en_US.UTF-8                 
 tz       <NA>                        

Packages ----------------------------------------------------------------------------------------------
 package  * version    date       source                          
 crayon     1.3.0      2015-06-05 CRAN (R 3.2.1)                  
 devtools * 1.8.0.9000 2015-06-25 Github (hadley/devtools@5034b86)
 digest     0.6.8      2014-12-31 CRAN (R 3.2.1)                  
 magrittr   1.5        2014-11-22 CRAN (R 3.2.1)                  
 memoise    0.2.1      2014-04-22 CRAN (R 3.2.1)                  
 Rcpp       0.11.6     2015-05-01 CRAN (R 3.2.1)                  
 roxygen2 * 4.1.1      2015-04-15 CRAN (R 3.2.1)                  
 stringi    0.5-2      2015-06-22 CRAN (R 3.2.1)                  
 stringr    1.0.0      2015-04-30 CRAN (R 3.2.1)                  
 testthat * 0.10.0     2015-05-22 CRAN (R 3.2.1)                  
 xwmooc   * 0.0.0.9000 <NA>       local               
~~~


### 기본 R 쉘 명령어
현재 작업공간을 확인하는 명령어는 `getwd()` 이며, 새로운 작업공간을 설정하는 명령어는 `setwd()` 이다. 현재 작업공간이 “C:\” 디렉토리인데 `setwd()` 명령어를 통해서 새로운 작업 공간으로 변경을 했다. 이것이 필요한 이유는 R은 기본적으로 자료처리 언어이기 때문에 데이터의 사전 위치를 파악하여 효율적으로 작업할 수 있다.

~~~ {.output}
> getwd()
[1] "C:/"
> setwd("D:/01. Work/09. Data_Products")
> getwd()
[1] "D:/01. Work/09. Data_Products"
> system("ls") # 윈도우에서는 shell("dir"), dir()
~~~

### R 패키지(package) 설치

R의 강점은 다양한 패키지를 지원하므로 새로이 뭔가 필요한 것을 자체 개발하는 것보다 우선 다른 사람들이 해논 것을 참조하고 이를 확대하여 가는 것을 권장한다. R 패키지를 설치하는 방법에 대해서 알아보자. *RStudio* 상에서 R 패키지를 설치하는 방법은 메뉴 상단의 `Tools > Install Packages…` 를 클릭하면 `Install Packages` 팝업 메뉴가 나오고 원하는 패키지를 설치하면 된다.

`rpart`는 의사결정나무모델 (Decision Tree) 을 구현할 때 자주 사용되는 패키지로 별도로 개발할 필요없이 기존의 개발 검증된 `rpart` 팩키지를 사용하는 것도 좋겠다. GUI를 통해서 일일이 설치하는 것도 좋지만, `install.packages`를 통한 명령어를 통해서도 설치가 동일하게 가능하다.

~~~ {.input}
> install.packages("rpart")
~~~

~~~ {.output}
trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.1/rpart_4.1-8.zip'
Content type 'application/zip' length 917885 bytes (896 Kb)
opened URL downloaded 896 Kb

package ‘rpart’ successfully unpacked and MD5 sums checked
The downloaded binary packages are in
  C:\Users\Administrator\AppData\Local\Temp\Rtmp4Ce7l1\downloaded_packages
~~~
