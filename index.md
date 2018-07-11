---
layout: page
title: 데이터 과학
---

<img src="fig/ct-unplugged-4th-paradigm-korea.png" width="57%" />

> ### 기계와의 경쟁을 준비하며... {.challenge}
> "The future is here, it's just not evenly distributed yet."  
>                                                           - William Gibson

### R, RStudio, `tidyverse`, 스파크, AWS 와 함께하는 데이터 과학 

1. **[데이터 과학과 R 언어](ds-r-lang.html)**
    - [도와줘요 - `reprex`](ds-r-reprex.html) 
    - [R 환경설정과 업데이트, 파일-객체 크기](ds-r-environment.html) 
    - [R 구문평가 - tidyeval](ds-r-tidyeval.html) 
    - [R 저작권과 라이선스(license)](ds-r-license.html) 
    - [R 프로그래밍 모범사례 - R 함수와 자료구조](ds-writing-fn.html)
    - [통계학 전공자와 데이터 공유 방법](ds-datasharing.html) : [영어원문](https://github.com/jtleek/datasharing), [구글 번역본](ds-datasharing-translation.html) 
    - [스프레드쉬트에서 데이터베이스로](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/)
        - [위기의 스프레드쉬트](ds-why-not-excel.html)
        - [탈옥(jailbreakr) -- 엑셀에서 탈출... 자유](ds-xls.html)    
        - [들어가며](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/01-intro.html)
        - [데이터 추출](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/02-extract.html)
        - [데이터베이스에 데이터 저장](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/03-db.html)
1. [측도와 R 자료구조](ds-data-structure.html)
    - **자료구조**
        - [날짜/시간 데이터](https://statkclee.github.io/finance/): **`2018-06-23`일부터 금융, 시계열로 이동**
        - [요인(Factor) - 범주형 자료형](ds-factor-cdata.html)
            - [요인자료형 달인 - STAT545](ds-factor-stat545.html)
            - [범주형 데이터 시각화 기초](ds-factor-dplyr-mosaic.html)
    - [결측데이터](ds-missing.html)
    - [R과 SQL - `DBI`, `dplyr`](data-handling-sql.html) 
        - [데이터 카펜트리 SQL 학습교재(생태학, ecology)](https://statkclee.github.io/sql-ecology-lesson/)
    - [`dplyr` 데이터베이스](ds-dplyr-sql.html)        
    - [빅데이터 - `tidyverse` 스파크](ds-tidyverse-spark.html)   
        - [대용량 데이터 표본추출](http://statkclee.github.io/ml/ml-random-sampling.html)    
        - [데이터테이블](data-handling-datatable.html)
1. **데이터 정제(Data Cleaning)**
    - [데이터 과학자가 아니라 청소부](ds-janitor.html)
1. [`tidyverse` 데이터 과학 기본체계](ds-tidyverse.html)
    - [데이터분석 파이프라인](data-handling-pipeline.html)
    - [데이터 깔끔화(tidyr)](data-handling-tidyr.html)
    - [데이터 작업 공구(dplyr)](data-handling-dplyr.html)
        - [데이터 병렬 작업 공구(multiplyr)](data-handling-multiplyr.html) 
        - [텍스트 작업 공구(tidytext)](data-handling-tidytext.html) 
        - [시계열 데이터 작업 공구(tidyquant)](data-handling-tidyquant.html) 
    - [두 테이블 동사(dplyr join)](ds-dplyr-join.html)
    - [데이터 내보내기](data-handling-export.html)
    - [데이터 다수 다루기 - 파케이](ds-manip-multiple-data.html)        
1. [깔끔한 데이터와 모형 -- `broom`](ds-broom-tidy-model.html)
    - [UN 투표 데이터를 통해 본 한국과 주변 강대국](ds-viz-un.html) 
1. **R 개발 환경 인프라** [데이터 과학 툴체인 - 파이썬](http://statkclee.github.io/raspberry-pi/raspberry-pi-programming-science.html)
    - **[RStudio 개발환경 - 프로젝트](rstudio-project.html)**
        - [RStudio 개발환경(IDE)과 단축키](rstudio.html)
        - [윈도우 환경 가상 R 개발환경](ds-virtual-window.html)
        - [한글처리 가능한 RStudio 개발환경](toolchain-shiny-rstudio.html)        
    - **[스파크(Spark)](http://statkclee.github.io/parallel-r/spark-mooc.html)**
        - [SparkR 하둡 클러스터 설치](ds-spark-hadoop-install.html)
        - [$H_2 O$ 하둡 스파크 클러스터 설치](ds-h2o-spark-hadoop.html)
    - [도커(Docker) 기초](toolchain-docker-basic.html)
        - [도커(Docker) - Dockerfile](toolchain-docker-dockerfile.html)
        - [데이터 과학 도커 - R](toolchain-docker-r.html)  
        - [데이터 과학 도커 - R 팩키지](toolchain-docker-r-pkgs.html)  
    - [지속적 통합(CI) - Travis](toolchain-ci-travis.html)    
    - [지속적 통합(CI) - GitHub](toolchain-travis-github.html)
    - [윈도우 10 - 우분투 배쉬](ds-windows-bash.html)
1. [R 팩키지 - 헬로우 월드](r-pkg-hello-world.html)
    - [`tidyverse` 기반 R 팩키지와 라이브러리](data-science-library.html)
    - [연관검색어 팩키지 - `suggestK`](r-pkg-suggestK.html)
    - [CRAN 팩키지 제출](r-pkg-cran.html)
1. **[다양한 데이터](https://statkclee.github.io/ingest-data/)**
    - [공간통계 - 지리정보](https://statkclee.github.io/spatial/)
    - **R 눈을 달다**
        - [pdf 파일 데이터 추출](ds-extract-text-from-pdf.html)
        - [PDF 감옥에서 데이터를 탈출시키다.](ds-extract-text-from-pdf-survey.html)
    - [보안 - 패킷분석](ds-packet.html)
1. [정렬(Sort)](data-handling-sorting.html) 


> ## 참고 자료 {.prereq}
> 
> - [컴퓨터 과학 언플러그드](http://unplugged.xwmooc.org)  
> - [리보그](http://reeborg.xwmooc.org)  
>      - [러플](http://rur-ple.xwmooc.org)  
> - [파이썬 거북이](http://swcarpentry.github.io/python-novice-turtles/index-kr.html)  
> - [정보과학을 위한 파이썬](http://python.xwmooc.org)  
> - [소프트웨어 카펜트리 5.3](http://statkclee.github.io/swcarpentry-version-5-3-new/)
>     - [소프트웨어 카펜트리 5.2](http://swcarpentry.xwmooc.org)
> - [R 팩키지](http://r-pkgs.xwmooc.org/)
> - [통계적 사고](http://think-stat.xwmooc.org/)
> - [IoT 라즈베리파이](http://raspberry-pi.xwmooc.org/)
>     - [$100 오픈 컴퓨터](http://computer.xwmooc.org/)   
>     - [$100 오픈 슈퍼컴퓨터](http://computers.xwmooc.org/)
