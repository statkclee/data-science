---
layout: page
title: 데이터 과학
subtitle: R 환경설정과 업데이트
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * R 시작 환경을 이해한다.
> * R 시작할 때 반복적으로 실행하는 작업을 자동화한다.


### 1. R 시작 환경설정 [^r-startup]  [^r-finding-location] [^r-Rprofile-customization]

R 시작환경을 설정하여 일일이 설정하지 않고, R이 시작될 때 자동으로 실행되어 바로 작업을 수행하게 시키면 처음에는 수고스럽지만 장기적으로 많은 이익이 된다.
자동으로 실행될 정보를 저장할 파일은 크게 두가지로 나뉜다: `.Rprofile`, `Rprofile.site`. 두 파일의 차이점은 `Rprofile.site`는 모든 사용자에게 영향을 미친다는 점이고,
`.Rprofile` 파일은 해당 사용자만 영향을 준다는 점에서 차이가 난다. 먼저 `Rprofile.site` 파일을 찾아본다. `R.home(component = "home")` 명령어를 R 콘솔에서 입력하면 찾는데 도움이 될 수 있다.

* 맥 OS X: `/Library/Frameworks/R.framework/Resources/etc/`
* 윈도우: `C:/Program Files/R/R-3.3.1/etc’ (R 버젼에 따라 차이가 남)
* 리눅스(우분투): `/etc/R/`

~~~ {.r}
$ R.home(component = "home")
[1] "C:/PROGRA~1/R/R-33~1.1"
~~~

`.Rprofile` 파일은 사용자 작업 디렉토리를 통해 확인한다.

~~~ {.r}
$ path.expand("~")
[1] "C:/Users/kcl/Documents"
~~~

그래도 찾을 수 없는 경우 다음 명령어를 통해 해당 파일을 찾아낸다.

~~~ {.r}
$ candidates <- c( Sys.getenv("R_PROFILE"),
...                  file.path(Sys.getenv("R_HOME"), "etc", "Rprofile.site"),
...                  Sys.getenv("R_PROFILE_USER"),
...                  file.path(getwd(), ".Rprofile") )
$ 
$ Filter(file.exists, candidates)
~~~

~~~ {.output}
[1] "C:/PROGRA~1/R/R-33~1.1/etc/Rprofile.site"
~~~

[^r-startup]: [Quick-R - Customizing Startup](http://www.statmethods.net/interface/customizing.html)
[^r-finding-location]: [locate the “.Rprofile” file generating default options](http://stackoverflow.com/questions/13735745/locate-the-rprofile-file-generating-default-options/13736073#13736073)

[^r-Rprofile-customization]: [Fun with .Rprofile and customizing R startup](https://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/)


### 2. `.Rprofile`, `Rprofile.site` 예제

`.Rprofile`, `Rprofile.site` 파일에 적용하고자 하는 부분을 찾아 다음과 같이 설정한다. 자주 사용하는 기능을 넣어 특히, `.First` 함수에 넣어 두어 자동으로 시작되게 하고, `.Last` 함수에는 그와 반대로 R을 끄고 나갈 때 설정한다.

~~~ {.r}
# options(papersize="a4")
# options(editor="notepad")
# options(pager="internal")

# set the default help type
# options(help_type="text")
  options(help_type="html")

# set a site library
# .Library.site <- file.path(chartr("\\", "/", R.home()), "site-library")

# set a CRAN mirror
local({r <- getOption("repos")
      r["CRAN"] <- "https://cran.us.r-project.org"
      options(repos=r)})
 
options(stringsAsFactors=FALSE)
 
options(max.print=100)
 
options(scipen=10)
 
# options(show.signif.stars=FALSE)
 
options(menu.graphics=FALSE)
 
options(prompt="$ ")
options(continue="... ")
 
options(width = 80)
 
utils::rc.settings(ipck=TRUE)
 
.First <- function(){
  if(interactive()){
    library(utils)
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep="")) 
  }
}
 
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}
 
 
sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

pkgs <- c("tidyr", "psych", "readr", "dplyr", "Amelia", "ROCR", "caret", "pscl", "AER", "parallel", "mboost", "earth", "gbm", "randomForest", "devtools", "testthat")
new.pkgs <- setdiff(pkgs, rownames(utils::installed.packages()))
if (length(new.pkgs)) utils::install.packages(new.pkgs, repos = "http://cran.us.r-project.org")
 
auto.loads <- c(pkgs)
 
if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}
 
# welcome <- iconv("기계와 더불어 사는 세상을 상상합니다!!!", to = "UTF-8")
 
message("Yesterday is history\n", "Tomorrow is a mystery\n", "but today is a gift\n", "That is why it is called the present.\n")
~~~

다시 R 세션을 시작하면 출력결과가 다음과 같이 나타난다.

~~~ {.output}
Restarting R session...

Yesterday is history
Tomorrow is a mystery
but today is a gift
That is why it is called the present.

##------ [D:/ds/chatbot] Tue Aug 09 10:36:47 2016 ------##
$ 
~~~

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

#### 3.2. R 엔진 업그레이드 (리눅스)

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


#### 3.2. R 엔진 업그레이드 (윈도우)

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

#### 3.3. 기본 R 쉘 명령어

현재 작업공간을 확인하는 명령어는 `getwd()` 이며, 새로운 작업공간을 설정하는 명령어는 `setwd()` 이다. 
현재 작업공간이 “C:\” 디렉토리인데 `setwd()` 명령어를 통해서 새로운 작업 공간으로 변경을 했다. 
이것이 필요한 이유는 R은 기본적으로 자료처리 언어이기 때문에 데이터의 사전 위치를 파악하여 효율적으로 작업할 수 있다.


~~~{.r}
getwd()
[1] "C:/"
setwd("D:/01. Work/09. Data_Products")
getwd()
[1] "D:/01. Work/09. Data_Products"
system("ls") # 윈도우에서는 shell("dir"), dir()
~~~

### 4. R 팩키지 설치 [^r-packages-install]

[^r-packages-install]: [How should I deal with “package 'xxx' is not available (for R version x.y.z)” warning?](http://stackoverflow.com/questions/25721884/how-should-i-deal-with-package-xxx-is-not-available-for-r-version-x-y-z-wa)

1. R 팩키지명이 제대로 입력되었는지 확인한다.
    * R 팩키지는 대소문자를 구분한다.
1. `setRepositories()` 명령어로 팩키지를 받아올 저장소를 설정한다.
    * `setRepositories(ind = c(1:6, 8))`와 같이 저장소 설정을 `Rprofile.site` 파일에 적용시켜 영구저장한다.
1. 설치하려는 팩키지가 저장소에 없는 경우가 있다.
    * `available.packages()` 명령어로 저장소에서 받아올 수 있는 팩키지를 확인한다.
        * `"ggplot2" %in% rownames(available.packages())`
        * `ap <- available.packages()`, `"ggplot2" %in% rownames(ap)`
    * `chooseCRANmirror()` 명령어로 CRAN 저장소를 설정한다.
1. 팩키지, 라이브러리가 아닌 데이터만 필요한 경우는 다음과 같이 데이터만 뽑아낸다.
    * 현재 팩키지에 설치된 모든 데이터를 살펴본다.
        * `data(package = .packages(all.available = TRUE))`
    * 특정 팩키지에 설치된 데이터만 살펴본다.
        * `data(package = "rpart")`
    * 특정 팩키지에 설치된 데이터를 불러온다.
        * `data(solder, package = "rpart")`        
1. R 코어 엔진의 버젼이 낮은 경우에 팩키지 설치에 문제가 된다.
    * R 팩키지가 설치될 때 최근 R 버젼을 요구하는 경우도 드물지 않다.
    * 윈도우의 경우 다음 명령어로 간단히 처리한다.
        * `library(installr)`, `updateR()`
1. 팩키지가 더이상 유지보수되지 않고 아카이빙되어 더이상 서비스 되지 않는다.
    * `R CMD check` 테스트를 통과하지 못한 경우도 포함된다.
1. 윈도우, 맥(OS X), 리눅스 특정 운영체제에 팩키지가 없다.
    * `CRAN (extras)` 저장소를 찾아본다.
    * 팩키지 소스파일을 구해서 윈도우즈 `Rtools`, 맥 OS X XCode 개발툴로 컴파일한다.
1. 팩키지가 GitHub/Bitbucket/Gitorious 저장소에서 받아오는 경우
    * `library(devtools)` 를 설치한다.
    * `install_github("packageauthor/foobarbaz")` : GitHub에서 설치하는 경우
    * `install_bitbucket("packageauthor/foobarbaz")` : Bitbucket에서 설치하는 경우
    * `install_gitorious("packageauthor/foobarbaz")` : Gitorious에서 설치하는 경우
