---
layout: page
title: 데이터 과학
---

<img src="fig/ct-unplugged-4th-paradigm-korea.png" width="57%" />

> ### 기계와의 경쟁을 준비하며... {.challenge}
> "The future is here, it's just not evenly distributed yet."  
>                                                           - William Gibson

### R, RStudio, `tidyverse`, 스파크, AWS 와 함께하는 데이터 과학 

1. **[R 언어](ds-r-lang.html)**
    - [R 환경설정과 업데이트](ds-r-environment.html) 
    - [R 프로그래밍 모범사례 - R 함수와 자료구조](ds-writing-fn.html)
    - [통계학 전공자와 데이터 공유 방법](ds-datasharing.html) [영어원문](https://github.com/jtleek/datasharing) [구글 번역본](ds-datasharing-translation.html) 
1. [측도와 R 자료구조](ds-data-structure.html)
    - **자료구조**
        - [시간데이터](data-handling-timendate.html)
        - [요인(Factor) - 범주형 자료형](ds-factor-cdata.html)
            - [요인자료형 달인 - STAT545](ds-factor-stat545.html)
        - [데이터테이블](data-handling-datatable.html)
        - [정렬(Sort)](data-handling-sorting.html)         
	- [스프레드쉬트에서 데이터베이스로](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/)
    	- [위기의 스프레드쉬트](ds-why-not-excel.html)
    	- [탈옥(jailbreakr) -- 엑셀에서 탈출... 자유](ds-xls.html)    
    	- [들어가며](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/01-intro.html)
    	- [데이터 추출](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/02-extract.html)
    	- [데이터베이스에 데이터 저장](http://statkclee.github.io/capstone-novice-spreadsheet-biblio/03-db.html)
    - [결측데이터](ds-missing.html)
    - [SQL](data-handling-sql.html)    
         - [데이터 카펜트리 SQL 학습교재(생태학, ecology)](https://statkclee.github.io/sql-ecology-lesson/)
    - [`dplyr` 데이터베이스](ds-dplyr-sql.html)        
    - [빅데이터 - `tidyverse` 스파크](ds-tidyverse-spark.html)   
        - [대용량 데이터 표본추출](http://statkclee.github.io/ml/ml-random-sampling.html)    
1. [깔끔한 데이터와 모형 -- `broom`](ds-broom-tidy-model.html)
1. [함수형 프로그래밍 -- `purrr`](ds-fp.html)
    - [R 함수 작성](ds-fp-write-fn.html)
    - [R 함수형 프로그래밍](ds-fp-purrr.html)
1. **R 개발 환경 인프라** [데이터 과학 툴체인 - 파이썬](http://statkclee.github.io/raspberry-pi/raspberry-pi-programming-science.html)
    - [윈도우 환경 가상 R 개발환경](ds-virtual-window.html)
    - [한글처리 가능한 RStudio 개발환경](toolchain-shiny-rstudio.html)    
    - [RStudio 개발환경(IDE)과 단축키](rstudio.html)
    - **[스파크(Spark)](http://statkclee.github.io/parallel-r/spark-mooc.html)**
        - [`sparklyr` = 스파크 + `dplyr` 설치](ds-sparklyr.html)
        - [SparkR 하둡 클러스터 설치](ds-spark-hadoop-install.html)
        - [$H_2 O$ 하둡 스파크 클러스터 설치](ds-h2o-spark-hadoop.html)
    - [도커(Docker) 기초](toolchain-docker-basic.html)
        - [도커(Docker) - Dockerfile](toolchain-docker-dockerfile.html)
        - [데이터 과학 도커 - R](toolchain-docker-r.html)  
        - [데이터 과학 도커 - R 팩키지](toolchain-docker-r-pkgs.html)  
    - [지속적 통합(CI) - Travis](toolchain-ci-travis.html)    
    - [지속적 통합(CI) - GitHub](toolchain-travis-github.html)
    - [윈도우 10 - 우분투 배쉬](ds-windows-bash.html)
    - [AWS RStudio 서버](ds-aws-rstudio-server.html)
1. [`tidyverse` 데이터 과학 기본체계](ds-tidyverse.html)
    - [데이터분석 파이프라인](data-handling-pipeline.html)
    - [데이터 가져오기](data-handling-import.html)    
    - [데이터 깔끔화(tidyr)](data-handling-tidyr.html)
    - [데이터 작업(dplyr)](data-handling-dplyr.html)
    - [데이터 내보내기](data-handling-export.html)
    - [데이터 다수 다루기 - 파케이](ds-manip-multiple-data.html)
1. [R 팩키지](ds-r-pkgs.html)    
    - [`tidyverse` 기반 R 팩키지와 라이브러리](data-science-library.html)  
1. **다양한 데이터**
	- [시각화](viz.html)
    	- [R 과 색상](viz-r-colors.html)
    	- [ggplot2 색상 제어](viz-ggplot2-control.html)
    	- [행복한 시각화 생활을 위한 비밀](viz-secret.html)
    	- [그래프 한장에 찍기](viz-multiple-plots.html)
    	- [그림을 파일에 저장](viz-save-plot.html) 
    	- [데이터 시각화(ggplot2, ggvis)](viz-ggplot2.html)
    	- [R 시각화 카탈로그](http://shiny.stat.ubc.ca/r-graph-catalog/)
    	- [ggvis](viz-ggvis.html)
	- [지리정보](geo-info.html)
    	- [주소와 위도경도](geo-info-lonlat.html)
    	- [Kormaps, leaflet 지리정보 시각화 기초](geo-info-kormaps.html)
    	- [우편번호 지리정보 시각화](geo-info-postcode.html)
    	- [단계구분도(choropleth) 지리정보 시각화](geo-info-choropleth.html)
    	- [생활안전 - 보호관찰소와 범죄](geo-info-crime.html)     
    	- [.shp 지도 일부 추출](geo-info-shapefile.html)
    	- [IP 주소 지리정보 시각화](geo-info-ip-address.html)
    - **웹 데이터**
        - [웹 스크래핑(Web Scraping)](data-scraping.html)
        - [웹에 있는 데이터 작업 - 파이썬](http://statkclee.github.io/web-data-python/)
            - [데이터 입수](http://statkclee.github.io/web-data-python/01-getdata.html)
            - [CSV 데이터 처리](http://statkclee.github.io/web-data-python/02-csv.html)
            - [오류(Error) 처리와 일반화](http://statkclee.github.io/web-data-python/03-generalize.html)
            - [시각화](http://statkclee.github.io/web-data-python/04-visualize.html)
            - [데이터 게시](http://statkclee.github.io/web-data-python/05-makedata.html)
            - [데이터를 찾을 수 있게 만들기](http://statkclee.github.io/web-data-python/06-findable.html)
    - **R 눈을 갖다**
        - [pdf 파일 데이터 추출](ds-extract-text-from-pdf.html)
1. [Shiny 웹앱](shiny-overview.html)
    - [Shiny 웹앱 개발](shiny-app.html)    
    - [Shiny 반응형 웹앱 개발](shiny-reactive.html)    
    - [Shiny 프론트엔트 개발](shiny-frontend.html)
1. [보고서 작성 자동화(30분)](ds-report-automation.html)
1. [R로 전자우편 자동 전송](ds-gmail.html)        
1. [데이터 제품](data-product.html)
    - [공공 데이터 제품](data-product-civic-hacking.html)
1. [야구 MLB](ds-baseball-mlb.html)    



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
