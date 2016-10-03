---
layout: page
title: 데이터 과학
subtitle: `tidyverse` 기반 R 팩키지와 라이브러리
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---




> ## 학습 목표 {.objectives}
>
> * `tidyverse`와 `messyverse`를 구분한다.
> * R 팩키지와 라이브러리를 이해한다.
> * R을 최신 버젼으로 업그레이드 한다.


### 1. R 팩키지와 라이브러리

데이터 과학 모형개발과 자료분석에서 R 팩키지 도구상자를 잘 갖추는 것도 중요한 작업이다.
다행히도, 최근에 [`tidyverse`](https://cran.r-project.org/web/packages/tidyverse/index.html) 팩키지가 새로 나와 많은 부분 체계화되었다.
사실 오픈소스 프로젝트가 성공되기 위해서 극복해야 되는 중요한 일중의 하나가 너무 많은 소프트웨어 덩어리를 정리하여
핵심적인 코드를 선별하여 다양성을 갖추면서도 성능과 신뢰성을 확보하는 것이 중요하다.

<img src="fig/ds-tidyverse.png" alt="깜끔한 세상" width="77%" />



### 2. 라이브러리 설정  

`.libPaths()` 명령어로 현재 팩키지가 설치된 디렉토리를 확인할 수 있다.


~~~{.r}
.libPaths()
~~~

`[1] "C:/Users/KwangChun/Documents/R/win-library/3.2"` 디렉토리는 
사용자가 개별적으로 설치한 팩키지 목록이 나와 있고,
`[2] "C:/Program Files/R/R-3.2.3/library"` 디렉토리에는 
기본 팩키지와 유틸리티가 나타나 있다.


`.Rprofile` 파일에 `.libPaths("C:/Users/xwMOOC/Rpackages")`를 추가해서 팩키지를 한 곳에 몰아 관리할 수도 있다. 


#### 2.1. 팩키지 설치 방법

R 저장소 안정된 버젼을 다운로드 받는 경우.

- install.packages("mapmisc")

R 저장소 최신 버젼을 다운로드 받는 경우.

- `install.packages("mapmisc", repos="http://R-Forge.R-project.org")`

#### 2.2. 설치된 팩키지 검색방법 [^statmethods-packages]



~~~{.r}
library()
~~~


~~~{.r}
search()
~~~



~~~{.output}
FALSE [1] ".GlobalEnv"        "package:knitr"     "package:stats"    
FALSE [4] "package:graphics"  "package:grDevices" "package:utils"    
FALSE [7] "package:datasets"  "Autoloads"         "package:base"

~~~

[^statmethods-packages]: [Statmethods - Packages](http://www.statmethods.net/interface/packages.html)

### 3. R 엔진 업그레이드 [^r-upgrade]

[^r-upgrade]: [R 3.2.4 is released](http://www.r-bloggers.com/r-3-2-4-is-released/)

R 버젼이 3.2.3(2015-12-10) 에서 3.2.4(2016-03-10)로 4개월만에 업그레이드 되었다.

`sessionInfo()` 명령어를 통해서 현재 버전을 확인한다.


~~~{.r}
sessionInfo()
~~~


~~~{.r}
R version 3.2.3 (2015-12-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=Korean_Korea.949  LC_CTYPE=Korean_Korea.949   
[3] LC_MONETARY=Korean_Korea.949 LC_NUMERIC=C                
[5] LC_TIME=Korean_Korea.949    

attached base packages:
[1] stats     graphics  grDevices utils     datasets 
[6] methods   base     

loaded via a namespace (and not attached):
[1] tools_3.2.3
~~~

#### 3.1. R 엔진 업그레이드

[installr](http://cran.r-project.org/web/packages/installr/) 팩키지를 사용해서 간단히 R 을 최신 버젼으로 업그레이드 한다.


~~~{.r}
install.packages("installr")
setInternet2(TRUE)
installr::updateR()
~~~

[installr](http://cran.r-project.org/web/packages/installr/) 팩키지가 설치되어 있지 않다면,
설치를 하고, 인터넷 연결을 `setInternet2(TRUE)` 설정하고 나서 `installr::updateR()` 갱신 명령어를 실행한다.
이후 자세한 사항은 [A step by step (screenshots) tutorial for upgrading R on Windows](http://www.r-statistics.com/2015/06/a-step-by-step-screenshots-tutorial-for-upgrading-r-on-windows/) 사이트를 참조한다. 계속 마우스로 누르면 설치가 완료된다.

<img src="fig/library-r-upgrade.png" alt="R 업그레이드" width="50%" />



~~~{.r}
R version 3.2.4 (2016-03-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=Korean_Korea.949  LC_CTYPE=Korean_Korea.949   
[3] LC_MONETARY=Korean_Korea.949 LC_NUMERIC=C                
[5] LC_TIME=Korean_Korea.949    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] tools_3.2.4
~~~

### 참고자료

