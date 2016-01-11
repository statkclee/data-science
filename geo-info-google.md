---
layout: page
title: 데이터 과학
subtitle: 지리정보 시각화 - 구글
---
> ## 학습 목표 {.objectives}
>
> *  구글 지리정보 툴체인을 활용한다.

### GoogleVis [^1] , plotGoogleMaps

**데이터셋** : 전세계 원자력 발전소 위치 [^2]
**방법 1** : ``GoogleVis`` 에 위도:경도 형식으로 자료를 준비해서 넣어준다.

~~~ {.r}
install.packages("googleVis")
library(googleVis)

NucData <- read.csv("./Nuclear power stations worldwide.csv")
NucData$Location <- gsub(",",":", NucData$Location)
require(googleVis)
placeNames <- as.character(NucData$Name)
plotData<-data.frame(name=placeNames,latLong=unlist(NucData$Location))
sites <- gvisMap(plotData,locationvar="latLong",tipvar="name", 
               options=list(displayMode = "Markers", mapType='normal', colorAxis = "{colors:['red', 'grey']}",
                            useMapTypeControl=TRUE, enableScrollWheel='TRUE'))
plot(sites)
~~~

**데이터셋** : Meuse 강 데이터
**방법 2** : ``plotGoogleMaps`` 팩키지 활용


~~~ {.r}
install.packages("plotGoogleMaps")
library(plotGoogleMaps)

data(meuse)
coordinates(meuse)<-~x+y # convert to SPDF
proj4string(meuse) <- CRS('+init=epsg:28992')
# Adding Coordinate Referent Sys.
# Create web map of Point data
m<-plotGoogleMaps(meuse,filename='myMap1.htm')
# Plotting another map with icons as pie chart
m<-segmentGoogleMaps(meuse, zcol=c('zinc','dist.m'),
                     mapTypeId='ROADMAP', filename='myMap4.htm',
                     colPalette=c('#E41A1C','#377EB8'), strokeColor='black')
~~~


[^1]: [Plotting geo-spatial data on Google Maps in R](http://diggdata.in/post/51396519384/plotting-geo-spatial-data-on-google-maps-in-r)
[^2]: [Nuclear Power plants](https://www.google.com/fusiontables/exporttable?query=select%20*%20from%201u4krB7NJ0Ppwzcd5h7uwOak3Reja4A7yVFIklw)
