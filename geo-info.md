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

#### R 데이터 가져오기

R로 데이터를 불러와야만 자료분석을 시작이 시작된다.  전통적인 방법으로 자료분석(로컬 컴퓨터에 파일형태로 저장된 다양한 파일을 불러오는 방법)을 시작할 수 있는 방법이 [statmethods.net](http://www.statmethods.net/input/importingdata.html) 사이트에 소개되어 있다.

- CSV : `.csv` 파일
- Excel : `.xlsx` 파일
- 통계 팩키지
    - SPSS : `.por` 파일
    - SAS : `xpt` 파일
    - 미니탭 : `.mtp` 파일

다양한 데이터를 R로 불러와서 작업하는 방법은 [Datacamp 블로그](http://blog.datacamp.com/)와 [r-bloggers](http://www.r-bloggers.com/)에서 확인이 가능하다.

- [This R Data Import Tutorial Is Everything You Need](http://blog.datacamp.com/r-data-import-tutorial/)
- [Importing Data Into R – Part Two](http://www.r-bloggers.com/importing-data-into-r-part-two/)

##### GIS 데이터

지리정보시스템(GIS) 데이터 처리를 위한 기본 R 팩키지를 설치한다.

[rgdal](http://www.rdocumentation.org/packages/rgdal), [raster](http://www.rdocumentation.org/packages/raster), [sp](http://www.rdocumentation.org/packages/sp)를 3종세트로 GIS 데이터 처리를 시작해 본다.

~~~ {.r}
install.packages("raster") # Geographic data analysis and modeling
install.packages("rgdal") # Bindings for the Geospatial Data Abstraction Library
install.packages("sp") # Classes and Methods for Spatial Data
~~~

~~~ {.r}
#===========================
# 필요한 라이브러리를 메모리에 적재한다.
#===========================
library("sp ", "rgdal", "raster")

#===========================
# 지리정보 데이터 정보
# ㄴ 원본 .sph 데이터: http://biogeo.ucdavis.edu/data/gadm2/shp/KOR_adm.zip
#===========================


#===========================
# 작업 디렉토리를 생성한다.
#===========================
localDir <- 'KOR_GIS_data'
if (!file.exists(localDir)) {
    dir.create(localDir)
}

#===========================
# 데이터를 불러와서 압축을 푼다.
#===========================
url <- 'http://biogeo.ucdavis.edu/data/gadm2/shp/KOR_adm.zip'
file <- paste(localDir,basename(url),sep='/')
if (!file.exists(file)) {
    download.file(url, file)
    unzip(file,exdir=localDir)
}

# list.files(localDir)

#===========================
# 계층을 설정하고, 내부정보를 살펴본다.
#===========================

# .shp 파일에서 파일 확장자를 제거한 계층명칭이된다.
layer_KOR_adm0 <- "KOR_adm0"  
layer_KOR_adm1 <- "KOR_adm1"  
layer_KOR_adm2 <- "KOR_adm2"  

# 데이터를 불러온다.
KOR_adm0_projected <- readOGR(dsn=localDir, layer=layer_KOR_adm0) 
KOR_adm1_projected <- readOGR(dsn=localDir, layer=layer_KOR_adm1) 
KOR_adm2_projected <- readOGR(dsn=localDir, layer=layer_KOR_adm2) 

#class(KOR_adm0_projected)
#slotNames(KOR_adm0_projected)

# 행정구역 정보 시각화
par(mfrow=c(1,3))
plot(KOR_adm0_projected)
plot(KOR_adm1_projected)
plot(KOR_adm2_projected)
~~~

<img src="fig/korea-admin-level.png" alt="대한민국 행정구역" width="70%" /> 

[Using R - Working with Geospatial Data](http://mazamascience.com/WorkingWithData/?p=1277)
[Raster Data in R - The Basics](http://neondataskills.org/R/Raster-Data-In-R/)


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
