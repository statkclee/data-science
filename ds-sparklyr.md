---
layout: page
title: 데이터 과학
subtitle: `sparklyr` = 스파크 + `dplyr` 설치
---
> ## 학습 목표 {.objectives}
>
> *  윈도우, 리눅스, 맥 환경에서 `sparklyr` 팩키지를 설치한다.
> *  RStudio 프리뷰 버젼을 설치하여 스파크를 편하게 활용한다.


<img src="fig/ds-sparklyr.png" alt="아파치 sparklyr 소개" width="37%" />

### 1. `sparklyr` 설치 (윈도우) [^sparklyr-windows]

[^sparklyr-windows]: [Running Apache Spark with sparklyr and R in Windows](http://yokekeong.com/running-apache-spark-with-sparklyr-and-r-in-windows/)

`sparklyr`는 `dplyr`을 스파크 환경에서 사용할 수 있도록 구현된 팩키지다.

> ### 윈도우 사전 준비 {.callout}
> 
> 윈도우 환경에서 `sparklyr`을 설치하려면 [Microsoft Visual C++ 2010 SP1 Redistributable Package](https://www.microsoft.com/en-us/download/details.aspx?id=13523)을 다운로드받아 > 설치한다.

1. [Download Apache Spark](http://spark.apache.org/downloads.html) 사이트를 방문하여 스파크-하둡을 다운로드 한다.
    * 스파크 버젼 1.6.2. : `spark-1.6.2-bin-hadoop2.6.tgz` 버전을 다운로드 받아 설치한다.
    * 스파크 버젼 2.0.0. : `spark-2.0.0-bin-hadoop2.7.tgz` 버전은 설치가 안되는 경우가 있다.
1. 다운로드 받은 파일의 압축을 풀게 되면 `spark-1.6.2-bin-hadoop2.6` 디렉토리가 생성된다.
    * 작업하기 편한 장소로 압축 푼 스파크-하둡 디렉토리를 이동시킨다. 예를 들어, `C:/spark-1.6.2-bin-hadoop2.6`
1. RStudio에서 `sparklyr` 팩키지를 설치한다.

~~~ {.r}
# 1. sparklyr 설치
devtools::install_github("rstudio/sparklyr")
library(sparklyr)

# 2. SPARK_HOME 지정
Sys.setenv(SPARK_HOME="C:/spark-1.6.2-bin-hadoop2.6")

# 3. 스파크 클러스터 로컬에 설치 
sc <- spark_connect(master="local")

# 4. iris 데이터셋 작업 준비 완료
library(dplyr)
iris_tbl <- copy_to(sc, iris)
# The following columns have been renamed:
# - "Sepal.Length" => "Sepal_Length" (#1)
# - "Sepal.Width"  => "Sepal_Width"  (#2)
# - "Petal.Length" => "Petal_Length" (#3)
# - "Petal.Width"  => "Petal_Width"  (#4)
src_tbls(sc)
# [1] "iris"
~~~    

### 2. `sparklyr` 설치 유닉스 계열 [^sparklyr]

[^sparklyr]: [sparklyr — R interface for Apache Spark](http://spark.rstudio.com/)

유닉스 계열(맥, 리눅스)에서 `sparklyr` 설치는 더욱 쉽다. [sparklyr - R interface for Apache Spark](http://spark.rstudio.com/) 안내지침에 따라 명령어를 타이핑하거나 복사하여 붙여 넣으면 된다.

~~~ {.r}
# 1. sparklyr 팩키지 설치
install.packages("devtools")
devtools::install_github("rstudio/sparklyr")

# 2. 스파크가 설치되지 않는 경우 설치 (스파크 버젼 1.6.1)
library(sparklyr)
spark_install(version = "1.6.1")

# 3. 스파크 인스턴스 생성
library(sparklyr)
sc <- spark_connect(master = "local")

# 4. 예제 R 데이터프레임을 스파크에 복사
library(dplyr)
iris_tbl <- copy_to(sc, iris)
install.packages("nycflights13")
install.packages("Lahman")
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")

# 5. 데이터 테이블 확인
src_tbls(sc)
# [1] "batting" "flights" "iris"  
~~~

### 3. `sparklyr` RStudio 활용

`sparklyr` RStudio 에서 편한게 사용할 수 있도록 다양한 기능을 제공하고 있다. 이를 위해서 [RStudio v0.99.1273 Preview](https://www.rstudio.com/products/rstudio/download/preview/) 버젼을 다운로드해서 설치한다. **Spark** 탭이 별도로 생성되고 이를 통해 스파크에 대한 전반적인 상황을 확인할 수 있다.

<img src="fig/ds-sparklyr-rstudio.png" alt="RStudio Spark 인터페이스" width="77%" />