---
layout: page
title: 데이터 과학
subtitle: R 팩키지
---



> ## 학습 목표  {.objectives}
>
> * 



### 1. R 팩키지 개발

#### 1.1. R 팩키지 개발 툴체인 설치

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


