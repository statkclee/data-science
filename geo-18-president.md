# 데이터 과학



> ## 학습 목표 {.objectives}
>
> * 제18대 대통령선거 투표결과를 시각화하여 이해한다. 

## 제18대 대선 데이터 

2012년도 대통령 선거 투표결과 데이터는 [중앙선거관리위원회](http://www.nec.go.kr/) 홈페이지에서 다운로드 받을 수 있다. 

**중앙선거관리위원회 &rarr; 분야별 정보 &rarr; 선거정보 &rarr; 하단 자료실**

- 제18대 대통령선거 투표구별 개표결과 [다운로드](http://www.nec.go.kr/portal/cmm/fms/FileDown.do?atchFileId=FILE_000000000061613&fileSn=1&bbsId=)
- 제20대 국회의원선거 투표구별 개표결과 자료 [다운로드](http://www.nec.go.kr/portal/cmm/fms/FileDown.do?atchFileId=FILE_000000000146224&fileSn=1&bbsId=)



~~~{.r}
# 2. 데이터 가져오기-------------------------------------------
dat <- read_excel("data/제18대 대선 투표구별 개표자료.xls", sheet="대통령", skip=4)
names(dat) <- c("sido", "sigun", "emd", "vote_station", "polls", "votes", "pgh", "mji","etc_01", "etc_02", "etc_03", "etc_04","subtlt", "invalid", "abstain")

dat <- dat %>% dplyr::filter(sigun !="합계") %>% 
  mutate(emd = na.locf(emd)) %>% 
  dplyr::filter(emd != "소계") %>% 
  mutate(vote_station = ifelse(is.na(vote_station), paste0(emd, "_", sigun), vote_station)) %>% 
  dplyr::filter(vote_station != "소계")
  

by_sido <- dat %>% group_by(sido) %>% 
  summarise(sido_polls_tlt = sum(polls),
            sido_votes_tlt = sum(votes),
            sido_pgh_tlt = sum(pgh),
            sido_mji_tlt = sum(mji),
            sido_invalid_tlt = sum(invalid),
            sido_abstain_tlt = sum(abstain))

names(by_sido) <- c("CTP_KOR_NM", "sido_polls_tlt", "sido_votes_tlt", "sido_pgh_tlt", 
                    "sido_mji_tlt", "sido_invalid_tlt", "sido_abstain_tlt")
~~~



## 행정 지도 데이터

[최신 행정구역(SHP) 다운로드](http://www.gisdeveloper.co.kr/entry/최신신-행정구역도-다운로드)



## 지리정보 시각화


~~~{.r}
korea_sido_shp <-  readShapeSpatial("data/shapefile_sido/TL_SCCO_CTPRVN.shp", verbose=TRUE, 
                                    proj4string=CRS("+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 
                                                     +ellps=GRS80 +units=m +no_defs"))
~~~



~~~{.output}
Shapefile type: Polygon, (5), # of Shapes: 17
Shapefile type: Polygon, (5), # of Shapes: 17

~~~



~~~{.r}
names(korea_sido_shp@data) <- c("CTPRVN_CD", "CTP_ENG_NM", "id")

plot(korea_sido_shp)
~~~

<img src="fig/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

