---
layout: page
title: 데이터 과학
subtitle: 지리정보 시각화
---
> ## 학습 목표 {.objectives}
>
> *  지리정보를 시각화한다.

[지도학(Cartography)](https://en.wikipedia.org/wiki/Cartography)는 지도를 제작하는 방식이다.

특정한 목적에 따라 특수한 주제 혹은 내용만을 나타내어 그린 지도를 [주제도(Thematic Map)](https://ko.wikipedia.org/wiki/지도의_종류)라고 한다.  어느 시점에서의 일기 상황을 나타낸 기상도, 운전할 때 쓰이는 도로도, 항해할 때 쓰이는 해도, 통계값을 지도에 그려 넣은 통계 지도 등이 좋은 사례다.

### 지리정보 파일(SHP)

대한민국 센서스용 행정구역경계(시군구) 자료는 [통계지리정보서비스](http://sgis.kostat.go.kr/html/index.html) 사이트에서 자료신청을 하면 얻을 수 있다. 그리고, 제공되는 자세한 형식에 대한 정보는 *자료신청* &rarr; *자료제공목록*을 참조한다. 

혹은 [GADM](http://www.gadm.org/) 데이터베이스에서 *Country*에서 **South Korea*을 선택하고, *File Format*에서 *Shapefile*을 선택하여 다운로드한다.

- [통계지역경계](http://sgis.kostat.go.kr/contents/shortcut/shortcut_05.jsp)
- [Global Administrative Areas](http://www.gadm.org/country)
- [팀 포퐁 GitHub](https://github.com/southkorea/southkorea-maps)

~~~ {.python}
FILEMAP = {
    'shp': [('skorea-shp.zip','http://biogeo.ucdavis.edu/data/gadm2/shp/KOR_adm.zip')],
    'kmz': [('skorea.kmz','http://biogeo.ucdavis.edu/data/gadm2/kmz/KOR_adm0.kmz'),
            ('skorea-provinces.kmz','http://biogeo.ucdavis.edu/data/gadm2/kmz/KOR_adm1.kmz'),
            ('skorea-municipalities.kmz','http://biogeo.ucdavis.edu/data/gadm2/kmz/KOR_adm2.kmz')],
    'r'  : [('skorea.RData','http://biogeo.ucdavis.edu/data/gadm2/R/KOR_adm0.RData'),
            ('skorea-provinces.RData','http://biogeo.ucdavis.edu/data/gadm2/R/KOR_adm1.RData'),
            ('skorea-municipalities.RData','http://biogeo.ucdavis.edu/data/gadm2/R/KOR_adm2.RData')]
~~~

### 주제도(Thematic Map)

#### Choropleth map

Unclassed Maps
Classed Maps

#### Graduated/Proportional Symbol

#### Cartogram

#### Heat Maps

#### Flow Maps


### Spatialization

MDS 혹은 코호넨 네트워크

#### Implicit Spatialization

#### Explicit Spatialization

- 미국 빈곤율 정보 시각화 [The Topography of Poverty in the United States](http://www.cdc.gov/pcd/issues/2007/oct/07_0091.htm)
- [http://indiemapper.com/](http://indiemapper.com/app/learnmore.php?l=choropleth)

- 미국 대선(2012) [뉴욕타임즈 President Map](http://elections.nytimes.com/2012/results/president)

### 지리정보처리 툴체인 [^1]

<img src="fig/R_SAGA_GE_logo.jpg" alt="LAMP와 Docker가 설치된 우분투 공용 이미지" width="40%" /> 

[^1]: http://spatial-analyst.net/wiki/index.php?title=Main_Page

- 오픈 GIS 소프트웨어
    - [System for Automated Geoscientific Analyses (SAGA GIS)](https://en.wikipedia.org/wiki/SAGA_GIS)
    - [Geographic Resources Analysis Support System (GRASS GIS)](https://en.wikipedia.org/wiki/GRASS_GIS)
- [TileMill](https://www.mapbox.com/tilemill/)
- KML 마크업 언어
    - [Keyhole Markup Language, KML](https://en.wikipedia.org/wiki/Keyhole_Markup_Language)



### 참고자료

- [Thematic Cartography and Geovisualization](http://www.amazon.com/Thematic-Cartography-Geovisualization-3rd-Edition/dp/0132298341)
- [Web Cartography: Map Design for Interactive and Mobile Devices](https://www.crcpress.com/Web-Cartography-Map-Design-for-Interactive-and-Mobile-Devices/Muehlenhaus/9781439876220)
- [R Development Translation Team (Korean)](http://www.openstatistics.net/)

### R 언어 참고 웹사이트

- [spatial.ly](http://spatial.ly/r/)
- [Spatial data in R: Using R as a GIS](https://pakillo.github.io/R-GIS-tutorial/)
- [Introduction to Spatial Data and ggplot2](http://rpubs.com/RobinLovelace/intro-spatial)
- [Spatial analysis in R: 랭커스터 대학](http://www.maths.lancs.ac.uk/~rowlings/Teaching/- Sheffield2013/index.html)
- [Notes on Spatial Data Operations in R](https://dl.dropboxusercontent.com/u/9577903/- broomspatial.pdf)
- [Making maps with R](http://www.molecularecologist.com/2012/09/making-maps-with-r/)
