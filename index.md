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
    - [데이터 과학 개념도(concept map)](ds-concept-map.html)
    - [**데이터 과학 교육**](ds-education.html)
    - [펭귄 vs 붓꽃 데이터](ds-iris-penguin.html)
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
        - [소프트웨어 카펜트리 워크샵 - googlesheets](ds-googlesheets.html)
    - [SPSS가 죽어가네요!!!](ds-spss-why-not.html)
    - [통계 팩키지](ds-korean-stat-pkg.html)
        - [오픈 통계 팩키지](ds-open-stat-pkg.html)
        - [`tidy blocks`](ds-tidy-blocks.html)
1. [측도와 R 자료구조](ds-data-structure.html)
    - [데이터프레임 스키마(Dataframe Schema)](ds-dataframe-schema.html)
    - [날짜/시간 데이터](https://statkclee.github.io/finance/): **`2018-06-23`일부터 금융, 시계열로 이동**
    - [요인(Factor) - 범주형 자료형](ds-factor-cdata.html)
        - [범주형 변수와 표](ds-categorical-var-table.html)
        - [요인자료형 달인 - STAT545](ds-factor-stat545.html)
        - [범주형 데이터 시각화 기초](ds-factor-dplyr-mosaic.html)
        - [표: `gt`와 `kable`](ds-table-gt-kable.html)
        - [한국 R 컨퍼런스 - 발표자 사진 포함](ds-rconf-profile.html)
    - **결측 데이터(Missing Data)**
        - [결측데이터 - Base R 시각화](ds-missing-base.html)
        - [결측데이터 - `ggplot` 시각화](ds-missing.html)
    - [빅데이터 - `tidyverse` 스파크](ds-tidyverse-spark.html)   
        - [대용량 데이터 표본추출](http://statkclee.github.io/ml/ml-random-sampling.html)    
        - [데이터테이블](data-handling-datatable.html)
    - [**데이터 정제(Data Cleaning)**: 데이터 과학자가 아니라 청소부](ds-janitor.html)
1. [**관계형 데이터베이스(RDBMS)**](ds-rdbms.html)
    - [`dplyr` Database - 헬로월드](ds-dplyr-sql.html)
    - [R 데이터베이스 추상화 - DBI](ds-database-dbi.html)
        - [xwMOOC 딥러닝 - "R 개발자가 알아야 되는 보안, 마리아 DB (MariaDB)"](http://statkclee.github.io/deep-learning/r-security.html#maria-db)
    - [R과 SQL - 소프트웨어 카펜트리](data-handling-sql.html) 
        - [데이터 카펜트리 SQL 학습교재(생태학, ecology)](https://statkclee.github.io/sql-ecology-lesson/)
        - [파이썬 판다스 - SQL](ds-pandas-sql.html)
    - [R 병렬 프로그래밍 - "예측모형 데이터베이스(DBMS) 배포"](https://statkclee.github.io/parallel-r/r-database-tidypredict.html)
    - [`postgreSQL` - DVD 대여 데이터베이스](ds-postgreSQL.html)
    - [DVD 대여 데이터베이스에서 인사이트 도출](ds-postgreSQL-insight.html)
    - [데이터웨어하우스(DW) - `star schema`](ds-dw-star.html): 준비중
1. [`tidyverse` 데이터 사이언스 기본체계](ds-tidyverse.html)
    - [데이터 사이언스 파이프라인 - Base vs. Tidyverse](data-handling-pipeline.html)
    - [데이터프레임(tibble)](data-handling-tibble.html)
    - [데이터 깔끔화(tidyr): `pivot_*`](data-handling-tidyr.html)
    - [데이터 작업 공구(dplyr)](data-handling-dplyr.html)
        - [데이터 병렬 작업 공구(multiplyr)](data-handling-multiplyr.html) 
        - [텍스트 작업 공구(tidytext)](data-handling-tidytext.html) 
        - [시계열 데이터 작업 공구(tidyquant)](data-handling-tidyquant.html) 
    - [두 테이블 동사(dplyr join) - **레고**](ds-dplyr-join.html)
    - [데이터 내보내기](data-handling-export.html)
    - [데이터 다수 다루기 - 파케이](ds-manip-multiple-data.html)        
1. [깔끔한 데이터와 모형 -- `broom`](ds-broom-tidy-model.html)
    - [UN 투표 데이터를 통해 본 한국과 주변 강대국](ds-viz-un.html) 
1. **[데이터 과학 개발 환경: R+파이썬](ds-languages.html)**, [데이터 과학 툴체인 - 파이썬](http://statkclee.github.io/raspberry-pi/raspberry-pi-programming-science.html)
    - [데이터 과학 PC (Java) - 맥(Mac)](ds-mac.html) &larr; 자바(Java)
    - [데이터 과학 PC (Java) - 윈도우)](ds-windows.html) &larr; 자바(Java)    
    - [윈도우 10 - WSL (우분투 배쉬)](ds-windows-bash.html)
    - [`gitlab` 환경설정과 기본사용법](ds-gitlab.html)
    - [RStudio 개발환경 - 프로젝트](rstudio-project.html)
        - [RStudio 개발환경(IDE)과 단축키](rstudio.html)
        - [윈도우 환경 가상 R 개발환경](ds-virtual-window.html)
        - [한글처리 가능한 RStudio 개발환경](toolchain-shiny-rstudio.html)        
    - [빅데이터 - 스파크(Spark)](https://statkclee.github.io/bigdata/) &larr; 하둡/스파크
    - [도커(Docker) 기초](toolchain-docker-basic.html)
        - [도커(Docker) - Dockerfile](toolchain-docker-dockerfile.html)
        - [데이터 과학 도커 - R](toolchain-docker-r.html)  
        - [데이터 과학 도커 - R 팩키지](toolchain-docker-r-pkgs.html)  
    - [지속적 통합(CI) - Travis](toolchain-ci-travis.html)    
    - [지속적 통합(CI) - GitHub](toolchain-travis-github.html)
1. [R 팩키지 - 헬로우 월드](r-pkg-hello-world.html)
    - [`tidyverse` 기반 R 팩키지와 라이브러리](data-science-library.html)
    - [연관검색어 팩키지 - `suggestK`](r-pkg-suggestK.html)
    - [CRAN 팩키지 제출](r-pkg-cran.html)
1. **[다양한 데이터](https://statkclee.github.io/ingest-data/)**
    - [공간통계 - 지리정보](https://statkclee.github.io/spatial/)
    - [보안 - 패킷분석](ds-packet.html)
1. [정렬(Sort)](data-handling-sorting.html) 


### [xwMOOC 오픈 교재](https://statkclee.github.io/xwMOOC/)

- **컴퓨팅 사고력(Computational Thinking)**
    - [컴퓨터 과학 언플러그드](http://statkclee.github.io/unplugged)  
    - [리보그 - 프로그래밍과 문제해결](https://statkclee.github.io/code-perspectives/)  
         - [러플](http://statkclee.github.io/rur-ple/)  
    - [파이썬 거북이](http://swcarpentry.github.io/python-novice-turtles/index-kr.html)  
    - [정보과학을 위한 파이썬](https://statkclee.github.io/pythonlearn-kr/)  
        + [정보 과학을 위한 R - R for Informatics](https://statkclee.github.io/r4inf/)
    - [소프트웨어 카펜트리 5.3](http://statkclee.github.io/swcarpentry-version-5-3-new/)
    - [기호 수학(Symbolic Math)](https://statkclee.github.io/symbolic-math/)
    - [데이터 과학을 위한 R 알고리즘](https://statkclee.github.io/r-algorithm/)
    - [데이터 과학을 위한 저작도구](https://statkclee.github.io/ds-authoring/)
        - [The Official xwMOOC Blog](https://xwmooc.netlify.com/)
    - [비즈니스를 위한 오픈 소스 소프트웨어](http://statkclee.github.io/open-source-for-business/)    
- **데이터 과학**
    - [R 데이터과학](https://statkclee.github.io/data-science/)
    - [시각화](https://statkclee.github.io/viz/)
    - [데이터 과학– 기초 통계](https://statkclee.github.io/statistics/)    
        - [공개 기초 통계학 - OpenIntro Statistics](https://statkclee.github.io/openIntro-statistics-bookdown/)
    - [보안 R](https://statkclee.github.io/security/) - TBA
    - **다양한 데이터**
        + [텍스트 - 자연어처리(NLP)](https://statkclee.github.io/text/)
        + [네트워크(network)](https://statkclee.github.io/network)
        + [공간통계를 위한 데이터 과학](https://statkclee.github.io/spatial/)        
        + [고생대 프로젝트](http://statkclee.github.io/trilobite)
        + [금융(finance)](https://statkclee.github.io/finance/)
        + [자동차 데이터 분석](https://statkclee.github.io/automotive/)
        + 비즈니스 프로세스(Business Process) - bupar
    - [~~R 팩키지~~](http://r-pkgs.xwmooc.org/)
    - [~~통계적 사고~~](http://think-stat.xwmooc.org/)
- **빅데이터**
    - [빅데이터(Big Data)](http://statkclee.github.io/bigdata)
    - [데이터 제품](https://statkclee.github.io/data-product/)
    - [R 도커](http://statkclee.github.io/r-docker/)
- **기계학습, 딥러닝, 인공지능**
    - [고성능 컴퓨팅(HPC)](http://statkclee.github.io/hpc)
    - [기계학습](http://statkclee.github.io/ml)
    - [딥러닝](http://statkclee.github.io/deep-learning)
    - [R 병렬 프로그래밍](http://statkclee.github.io/parallel-r/)
    - [인공지능 연구회](https://statkclee.github.io/ai-lab/)
- [IoT 오픈 하드웨어(라즈베리 파이)](http://statkclee.github.io/raspberry-pi)
    - [$100 오픈 컴퓨터](https://statkclee.github.io/one-page/)   
    - [$100 오픈 슈퍼컴퓨터](https://statkclee.github.io/hpc/)
- [선거와 투표](http://statkclee.github.io/politics)
    - [저녁이 있는 삶과 새판짜기 - 제7공화국](https://statkclee.github.io/hq/)
