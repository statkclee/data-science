---
layout: page
title: 데이터 과학
subtitle: R 언어
---
> ## 학습 목표 {.objectives}
>
> * R 언어의 역사를 이해한다.
> * 



### 1. R 언어 역사

### 2. R 시작 환경설정 [^r-startup]  [^r-finding-location] [^r-Rprofile-customization]

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


#### 2.1. `.Rprofile`, `Rprofile.site` 예제

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