---
layout: page
title: 데이터 과학
subtitle: tidyverse 스파크
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * 

### 1. `tidyverse` 스파크 데이터 과학 개요.

크기, 다양성, 속도로 특징되는 빅데이터를 데이터과학 기반으로 탐색적 데이터분석, 통계가설검정,
예측모형, 기계학습 등 다양한 방법론을 적용하기 위해서는 다음과 같은 `tidyverse` 스파크 틀(framework)이 요구되고 있다.

<img src="fig/spark-ds-overview.png" alt="스파크 데이터 과학 개요" width="100%" />

#### 1.1. 하드웨어와 데이터

분석할 데이터 혹은 모형을 개발할 데이터 크기를 기준으로 데이터 과학을 위한 하드웨어 환경을 살펴보면 다음과 같다.

- 16 GB 미만의 노트북 혹은 데스크톱 컴퓨터에서 `dplyr` + RDBMS를 설치해서 멀티코어 CPU를 활용하여 
병렬 컴퓨팅을 실행하는 것이 가장 작은 규모의 빅데이터 혹은 스몰데이터를 처리하는 방식이다.
- 2 TB까지 크기를 갖는 데이터를 처리하는데 클라우드 환경에 2TB 주기억장치를 갖는 가상컴퓨터를 생성하여 분석하는 것도 가능한
방법이다.
- 2 TB이상 크기를 갖는 데이터를 처리하는데 스파크+하둡 클러스터를 구축하여 분산처리하는 방식이 가장 많이 사용되는 최근의 추세다.

<img src="fig/spark-ds-hardware-data.png" alt="하드웨어와 데이터" width="77%" />

#### 1.2. R 팩키지 도구상자 -- `tidyverse`

데이터를 담아 적절히 분석할 수 있는 하드웨어 환경이 갖춰지면, 데이터에서 정보를 추출하여 자동화할 수 있는 일반적인 모형을
개발할 적절한 R 팩키지 도구상자가 필요하다. 이를 과거에 `hadleyverse`, 현재는 `tidyverse`라고 부른다.

- **가져오기**
  - readr : 데이터 가져오기
  -DBI : 데이터베이스
  -haven: SPSS, SAS, Stata
  -httr: 웹 APIs
  -jsonlite: JSON
  -readxl: 엑셀
  -rvest: 웹스크래핑
  -xml2: XML
- **데이터정제**
  - dplyr : 데이터 조작
  - tidyr : 데이터 깔끔화
  - purrr : 함수형 프로그래밍
  - tibble : 최신 데이터프레임
- **시각화**
  - ggplot2 : 데이터 시각화
- **모형 자동화**  
  - modelr : 파이프라인 내부 모형개발
  - broom : 모형산출물을 깔끔한 데이터로 변환
- **의사소통**
  - rmakrdown : 마크다운 문서화
  - bookdown : 다양한 출력물 산출(pdf, html, ePub등)
  - shiny : 웹응용프로그램, 동적 대쉬보드
  - flexdashboard : 정적 인터랙티브 대쉬보드

<img src="fig/spark-ds-tidyverse.png" alt="깔끔한 세상" width="77%" />

#### 1.3. R 코드

처음에는 탐색적 자료분석과 임의 데이터 분석으로 R 스크립트가 생성된다. 
작업이 지속적으로 반복되거나, 4번이상 반복되는 것이 느껴질 때 함수를 작성할 시점이 되었다.
특정 작업에 지속적으로 함수가 늘어나고, 이를 조합하여 좀더 복잡한 문제를 해결할 필요성이 느껴질 때가
팩키지를 작성할 시점이 된 것이다. 
R 팩키지는 함수에 대한 단위테스트(`testthat`)와 함수 도움말과 가장 중요한 함수가 포함되어 있다.
물론 어떤 R 팩키지도 독립적으로 존재하지 않기 때문에, 네임스페이스를 통해 팩키지에 대한 의존성 정보도 함께
포함되게 된다.

<img src="fig/spark-ds-code-fn-pkgs.png" alt="코드, 함수, 팩키지" width="77%" />

