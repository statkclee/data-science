---
layout: page
title: 데이터 과학
subtitle: 지리정보 시각화 - ggmap
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---

``` {r, include=FALSE}
source("tools/chunk-options.R")
```

> ## 학습 목표 {.objectives}
>
> * `ggmap`


대한민국 경도범위는 124 -- 132, 위도범위는 33 -- 43 이다. 

> ### 대한민국 위도와 경도 [^kor-lonlat] {.callout}
>
> #### 대한민국 전체
> - 극동: 경상북도 울릉군의 독도 동단 동경 131° 52′20", 
> - 극서: 평안북도 용천군 신도면 마안도 서단 동경 124° 11′45"
> - 극남: 제주도 남제주군 대정읍 마라도 남단 북위 33° 06′40"
> - 극북: 함경북도 온성군 남양면 북단 북위 43° 00′35"
>
> #### 북한 제외
> - 극동: 경상북도 울릉군의 독도(獨島)로 동경 131° 52′, 
> - 극서: 전라남도 신안군의 소흑산도(小黑山島)로 동경 125° 04′, 
> - 극북: 강원도 고성군 현내면 송현진으로 북위 38° 27′, 
> - 극남: 제주도 남제주군 마라도(馬羅島)로 북위 33° 06′이다.


[^kor-lonlat]: [대한민국의 위도와 경도를 알고 싶어요](http://tip.daum.net/question/3092152)

``` {r message=FALSE, warning=FALSE, comment=FALSE}
# 위치를 지정한다.
krLocation <- c(124.11, 33.06, 131.52, 43.00) #좌측하단경도, 좌측하단위도, 우측상단경도, 우측상단위도
southKrLocation <- c(125.04, 33.06, 131.52, 38.27)
#krLocation <- c(lon=126, lat=37) # 대한민국 서울
krMap <- get_map(location=krLocation, source="stamen", maptype="toner", crop=FALSE) #terrain, toner, watercolor
ggmap(krMap)
```

`googlemap`이 위도경도 지도중앙, `stamen`, `openstreetmap`, `cloudmade`는 
위도경도 상자표기를 권장한다.

``` {r message=FALSE, warning=FALSE, comment=FALSE, eval=FALSE}
krMap <- get_map(location=krLocation, source="stamen", maptype="toner", crop=FALSE) #terrain, toner, watercolor
ggmap(krMap)

krMap <- get_map(location=krLocation, source="stamen", maptype="watercolor", crop=FALSE) #terrain, toner, watercolor
ggmap(krMap)

krMap <- get_map(location=krLocation, source="google", maptype="terrain", crop=FALSE) #terrain, satellite, roadmap, hybrid
ggmap(krMap)

krMap <- get_map(location=krLocation, source="google", maptype="satellite", crop=FALSE) #terrain, satellite, roadmap, hybrid
ggmap(krMap)

krMap <- get_map(location=krLocation, source="google", maptype="roadmap", crop=FALSE) #terrain, satellite, roadmap, hybrid
ggmap(krMap)
```

krMap <- get_map(location=krLocation, source="google", maptype="hybrid", crop=FALSE) #terrain, satellite, roadmap, hybrid
ggmap(krMap)


### 팩키지 설치 방법

R 저장소 안정된 버젼을 다운로드 받는 경우.

- install.packages("mapmisc")

R 저장소 최신 버젼을 다운로드 받는 경우.

- `install.packages("mapmisc", repos="http://R-Forge.R-project.org")`



