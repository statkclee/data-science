---
layout: page
title: 데이터 과학
subtitle: tmap 주제도
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
>  * 
>  * `Kormaps` 지리정보 시각화한다.

### 1. `tmap` 주제도 [^kormaps-01] 

주제도를 그린다.


### `.shp` 파일에서 면(polygon)을 잘라낸다. [^shape-polygon-clipping]

gIntersection(regions, lads, byid = TRUE, drop_lower_td = TRUE)

### `.shp` 파일에서 다각형(polygon)을 합친다.. [^shape-polygon-dissolving]

[^shape-polygon-clipping]: [Clipping polygons in R](https://philmikejones.wordpress.com/2015/09/01/clipping-polygons-in-r/)
[^shape-polygon-dissolving]: [Dissolve polygons in R](https://philmikejones.wordpress.com/2015/09/01/clipping-polygons-in-r/)



### 

Shapefile은 확장자로 `.shp`을 갖고, 벡터방식으로 공간정보를 저장한다.
`.shp` 파일은 점, 선, 면(Polygon) 중 하나의 속성을 갖는다.

