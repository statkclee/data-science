# 데이터 과학



> ## 학습 목표 {.objectives}
>
> * IP주소를 사용하여 접속위치를 시각적으로 표현한다.

### 1. 작업 흐름

IP주소 정보가 있으면 [GitHub freegeoip](https://github.com/fiorix/freegeoip) 혹은 
[freegeoip](http://freegeoip.net/) 웹서비스에 제공하는 오픈 API를 활용하여 위경도 정보로 변환하고 이를 
지리정보 시각화 팩키지를 활용하여 기능을 구현한다.

<img src="fig/geo-ip-workflow.png" alt="IP 주소 지리정보 매핑 작업흐름" width="77%" />


### 2. IP 주소에서 지리정보 추출 [^extract-geo-info-from-ip-address]

[^extract-geo-info-from-ip-address]: [Geolocate IP addresses in R](https://heuristically.wordpress.com/2013/05/20/geolocate-ip-addresses-in-r/)

IP 주소에서 지리정보를 추출한 R 함수는 다음과 같다.
`rjson` 팩키지를 사용해서 오픈 API의 정보를 받아오고 이를 데이터프레임으로 결과값을 받아온다.
`ip` 주소가 하나가 아닌 다수의 경우 각각의 정보를 행으로 받아와서 `rbind` 함수로 차곡차곡 쌓는 로직이다.


~~~{.r}
freegeoip <- function(ip, format = ifelse(length(ip)==1,'list','dataframe'))
{
    if (1 == length(ip))
    {
        # a single IP address
        require(rjson)
        url <- paste(c("http://freegeoip.net/json/", ip), collapse='')
        ret <- fromJSON(readLines(url, warn=FALSE))
        if (format == 'dataframe')
            ret <- data.frame(t(unlist(ret)))
        return(ret)
    } else {
        ret <- data.frame()
        for (i in 1:length(ip))
        {
            r <- freegeoip(ip[i], format="dataframe")
            ret <- rbind(ret, r)
        }
        return(ret)
    }
}   

freegeoip('221.153.21.29')
~~~



~~~{.output}
$ip
[1] "221.153.21.29"

$country_code
[1] "KR"

$country_name
[1] "Republic of Korea"

$region_code
[1] "41"

$region_name
[1] "Gyeonggi-do"

$city
[1] "Hwaseong-si"

$zip_code
[1] ""

$time_zone
[1] "Asia/Seoul"

$latitude
[1] 37.2068

$longitude
[1] 126.8169

$metro_code
[1] 0

~~~

### 3. IP 정보를 `leaflet` 팩키지로 시각화

IP 정보를 `leaflet` 팩키지로 시각화하는 코드는 다음과 같다.


~~~{.r}
# 데이터프레임을 생성
ip_df <- data.frame(date=c("2016-01-27", "2016-03-17", "2016-05-25"), ip_addr = c("125.139.114.72", "211.219.36.134", "121.187.179.223"), stringsAsFactors = FALSE)

# 위경도 정보를 오픈 API 요청 및 결과를 데이터프레임으로 저장
ip_geo_df <- freegeoip(ip_df$ip_addr)

#---------------------------------------------------------------------------------------------------
# IP 주소 위경도 정보 시각화
#---------------------------------------------------------------------------------------------------
suppressMessages(library(leaflet))
suppressMessages(library(ggmap))

ip_geo_df$latitude <- as.numeric(ip_geo_df$latitude)
ip_geo_df$longitude <- as.numeric(ip_geo_df$longitude)

m <- leaflet(data = ip_geo_df) %>% addTiles() %>%
  addMarkers(lng=~longitude, lat=~latitude, popup = ~as.character(ip), clusterOptions = markerClusterOptions())
m 
~~~

<!--html_preserve--><div id="htmlwidget-428" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-428">{"x":{"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"maxNativeZoom":null,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"continuousWorld":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap\u003c/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA\u003c/a>"}]},{"method":"addMarkers","args":[[1,2,3],[1,2,3],null,null,null,{"clickable":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["125.139.114.72","211.219.36.134","121.187.179.223"],{"showCoverageOnHover":true,"zoomToBoundsOnClick":true,"spiderfyOnMaxZoom":true,"removeOutsideVisibleBounds":true},null]}],"limits":{"lat":[1,3],"lng":[1,3]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
# library(htmlwidgets)
# saveWidget(widget=m,file="ip_addr_geo_info.html")
~~~
