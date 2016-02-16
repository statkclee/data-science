---
layout: page
title: 데이터 과학
subtitle: 공공 데이터 제품 개발
---

> ## 학습에 들어가기 전 {.prereq}
>
> * 공공 데이터 제품 개발과정을 이해한다.


### 공공데이터

공공데이터는 국가의 모든 기관이 만들어 내는 자료와 이를 가공해서 생산된 정보를 지칭한다. 공공데이터를 적극 개방, 공유하고 정부부처 간에 공유되지 않는 자료와 정보를 공개함으로써 이를 활용하여 정부에 맞춤형 서비스를 제공하고 새로운 부가가치를 창출함을 

- [공공데이터](https://www.data.go.kr/)
    + [서울시 공공데이터](http://data.seoul.go.kr/)
    + [경기도 공공데이터](http://data.gg.go.kr/)
        - [성남 공공데이터](http://data.seongnam.go.kr/main.do) 
- [통계청](http://kostat.go.kr/)
    + [국가통계포털](http://kosis.kr/)    
    + [통계지리정보서비스](http://sgis.kostat.go.kr/)
    + [국가통계 마이크로데이터](http://mdis.kostat.go.kr): 
        - 광업제조업조사 및 경제활동인구조사 등 통계청 통계조사 40종
        - 외래관광객실태조사(문화체육관광부), 서울시도시정책지표조사(서울특별시) 등

국가 및 정부부처내 통계정보를 공유하고 교환하는데 사용되는 표준은 SDMX [^sdmx]를 활용한다.

[^sdmx]: [Statistical Data and Metadata eXchange](https://sdmx.org/)


### 공공데이터 전달 아키텍쳐

정보를 전달하기 위해서 국제표준화기구(OSI)에서 제시한 OSI 모형 (Open Systems Interconnection Reference Model)[^1]을 사용하고 이를 기반으로 응용 프로그램을 웹서비스와 데이터 형식에 과거 **SOAP와 XML** 조합을 많이 사용했다면, 최근에는 **RESTful API와 JSON** 조합을 주로 사용한다. 

<img src="fig/data-product-api.png" width="70%" />


[^1]: [OSI 모형](https://ko.wikipedia.org/wiki/OSI_모형)


### 공공데이터 추출

공공데이터는 다양한 제공방식으로 제공되지만 크게 파일 형식으로 다운로드 받는 방식과 웹서비스 형식으로 전달되는 두가지 방식이 존재한다.

> #### 공공데이터 제공 방식 {.callout}
> 
> - 파일: 엑셀, CSV
> - API: JSON+RESTful, XML+SOAP















