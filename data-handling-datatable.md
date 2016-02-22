---
layout: page
title: 데이터 과학
subtitle: 데이터테이블
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * dplyr 과 hflights 팩키지 [^data-camp-dplyr]

### 데이터 분석 시작

`dplyr`, `hflights` 팩키지를 불러와서 `head`와 `summary` 명령어로 데이터를 살펴본다.


~~~{.r}
library(dplyr)
library(hflights)
head(hflights)
~~~



~~~{.output}
FALSE      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
FALSE 5424 2011     1          1         6    1400    1500            AA
FALSE 5425 2011     1          2         7    1401    1501            AA
FALSE 5426 2011     1          3         1    1352    1502            AA
FALSE 5427 2011     1          4         2    1403    1513            AA
FALSE 5428 2011     1          5         3    1405    1507            AA
FALSE 5429 2011     1          6         4    1359    1503            AA
FALSE      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
FALSE 5424       428  N576AA                60      40      -10        0    IAH
FALSE 5425       428  N557AA                60      45       -9        1    IAH
FALSE 5426       428  N541AA                70      48       -8       -8    IAH
FALSE 5427       428  N403AA                70      39        3        3    IAH
FALSE 5428       428  N492AA                62      44       -3        5    IAH
FALSE 5429       428  N262AA                64      45       -7       -1    IAH
FALSE      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
FALSE 5424  DFW      224      7      13         0                         0
FALSE 5425  DFW      224      6       9         0                         0
FALSE 5426  DFW      224      5      17         0                         0
FALSE 5427  DFW      224      9      22         0                         0
FALSE 5428  DFW      224      9       9         0                         0
FALSE 5429  DFW      224      6      13         0                         0

~~~



~~~{.r}
summary(hflights)
~~~



~~~{.output}
FALSE       Year          Month          DayofMonth      DayOfWeek    
FALSE  Min.   :2011   Min.   : 1.000   Min.   : 1.00   Min.   :1.000  
FALSE  1st Qu.:2011   1st Qu.: 4.000   1st Qu.: 8.00   1st Qu.:2.000  
FALSE  Median :2011   Median : 7.000   Median :16.00   Median :4.000  
FALSE  Mean   :2011   Mean   : 6.514   Mean   :15.74   Mean   :3.948  
FALSE  3rd Qu.:2011   3rd Qu.: 9.000   3rd Qu.:23.00   3rd Qu.:6.000  
FALSE  Max.   :2011   Max.   :12.000   Max.   :31.00   Max.   :7.000  
FALSE                                                                 
FALSE     DepTime        ArrTime     UniqueCarrier        FlightNum   
FALSE  Min.   :   1   Min.   :   1   Length:227496      Min.   :   1  
FALSE  1st Qu.:1021   1st Qu.:1215   Class :character   1st Qu.: 855  
FALSE  Median :1416   Median :1617   Mode  :character   Median :1696  
FALSE  Mean   :1396   Mean   :1578                      Mean   :1962  
FALSE  3rd Qu.:1801   3rd Qu.:1953                      3rd Qu.:2755  
FALSE  Max.   :2400   Max.   :2400                      Max.   :7290  
FALSE  NA's   :2905   NA's   :3066                                    
FALSE    TailNum          ActualElapsedTime    AirTime         ArrDelay      
FALSE  Length:227496      Min.   : 34.0     Min.   : 11.0   Min.   :-70.000  
FALSE  Class :character   1st Qu.: 77.0     1st Qu.: 58.0   1st Qu.: -8.000  
FALSE  Mode  :character   Median :128.0     Median :107.0   Median :  0.000  
FALSE                     Mean   :129.3     Mean   :108.1   Mean   :  7.094  
FALSE                     3rd Qu.:165.0     3rd Qu.:141.0   3rd Qu.: 11.000  
FALSE                     Max.   :575.0     Max.   :549.0   Max.   :978.000  
FALSE                     NA's   :3622      NA's   :3622    NA's   :3622     
FALSE     DepDelay          Origin              Dest              Distance     
FALSE  Min.   :-33.000   Length:227496      Length:227496      Min.   :  79.0  
FALSE  1st Qu.: -3.000   Class :character   Class :character   1st Qu.: 376.0  
FALSE  Median :  0.000   Mode  :character   Mode  :character   Median : 809.0  
FALSE  Mean   :  9.445                                         Mean   : 787.8  
FALSE  3rd Qu.:  9.000                                         3rd Qu.:1042.0  
FALSE  Max.   :981.000                                         Max.   :3904.0  
FALSE  NA's   :2905                                                            
FALSE      TaxiIn           TaxiOut         Cancelled       CancellationCode  
FALSE  Min.   :  1.000   Min.   :  1.00   Min.   :0.00000   Length:227496     
FALSE  1st Qu.:  4.000   1st Qu.: 10.00   1st Qu.:0.00000   Class :character  
FALSE  Median :  5.000   Median : 14.00   Median :0.00000   Mode  :character  
FALSE  Mean   :  6.099   Mean   : 15.09   Mean   :0.01307                     
FALSE  3rd Qu.:  7.000   3rd Qu.: 18.00   3rd Qu.:0.00000                     
FALSE  Max.   :165.000   Max.   :163.00   Max.   :1.00000                     
FALSE  NA's   :3066      NA's   :2947                                         
FALSE     Diverted       
FALSE  Min.   :0.000000  
FALSE  1st Qu.:0.000000  
FALSE  Median :0.000000  
FALSE  Mean   :0.002853  
FALSE  3rd Qu.:0.000000  
FALSE  Max.   :1.000000  
FALSE 

~~~

### 데이터프레임을 데이터테이블로 변환

`tbl_df` 함수를 사용해서 데이터프레임(data.frame)을 데이터테이블(data.table)로 변환한다. 
데이터테이블은 내부를 살펴보면 데이터프레임을 기본으로 개발자 관점에서 더욱 쉽고, 빠르고, 직관적으로
데이터를 처리할 수 있는 자료형이다.


~~~{.r}
hflights <- tbl_df(hflights)

hflights
~~~



~~~{.output}
FALSE Source: local data frame [227,496 x 21]
FALSE 
FALSE     Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
FALSE    (int) (int)      (int)     (int)   (int)   (int)         (chr)
FALSE 1   2011     1          1         6    1400    1500            AA
FALSE 2   2011     1          2         7    1401    1501            AA
FALSE 3   2011     1          3         1    1352    1502            AA
FALSE 4   2011     1          4         2    1403    1513            AA
FALSE 5   2011     1          5         3    1405    1507            AA
FALSE 6   2011     1          6         4    1359    1503            AA
FALSE 7   2011     1          7         5    1359    1509            AA
FALSE 8   2011     1          8         6    1355    1454            AA
FALSE 9   2011     1          9         7    1443    1554            AA
FALSE 10  2011     1         10         1    1443    1553            AA
FALSE ..   ...   ...        ...       ...     ...     ...           ...
FALSE Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
FALSE   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
FALSE   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
FALSE   CancellationCode (chr), Diverted (int)

~~~



~~~{.r}
carriers <- hflights$UniqueCarrier
~~~

### 변수값 재부호화(recoding)

데이터 작업 중에 가장 많이 수행하는 작업 중 하나가 변수내부 값을 다른 값으로 재부호화하는 것이다.
예를 들어, `남자`를 `Male`, `여자`를 `Female`처럼 한국어를 영어로 재부호화하거나,
`KO`를 `한국`, `CN`을 `중국`처럼 코드화된 것을 개발자가 이해하기 새롭게 재부호화하는 것이다.
`car` 라이브러리 `recode` 함수 등 다양한 재부호화 함수가 존재한다. 

데이터프레임의 재부호화하는 방법을 살펴보자. 초간략 코드화된 항공사 코드를 개발자가 이해하기 쉬운
코드로 바꿔보자.


~~~{.r}
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")
hflights$UniqueCarrier <- lut[hflights$UniqueCarrier]         
glimpse(hflights)
~~~



~~~{.output}
FALSE Observations: 227,496
FALSE Variables: 21
FALSE $ Year              (int) 2011, 2011, 2011, 2011, 2011, 2011, 2011, 20...
FALSE $ Month             (int) 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
FALSE $ DayofMonth        (int) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1...
FALSE $ DayOfWeek         (int) 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6,...
FALSE $ DepTime           (int) 1400, 1401, 1352, 1403, 1405, 1359, 1359, 13...
FALSE $ ArrTime           (int) 1500, 1501, 1502, 1513, 1507, 1503, 1509, 14...
FALSE $ UniqueCarrier     (chr) "American", "American", "American", "America...
FALSE $ FlightNum         (int) 428, 428, 428, 428, 428, 428, 428, 428, 428,...
FALSE $ TailNum           (chr) "N576AA", "N557AA", "N541AA", "N403AA", "N49...
FALSE $ ActualElapsedTime (int) 60, 60, 70, 70, 62, 64, 70, 59, 71, 70, 70, ...
FALSE $ AirTime           (int) 40, 45, 48, 39, 44, 45, 43, 40, 41, 45, 42, ...
FALSE $ ArrDelay          (int) -10, -9, -8, 3, -3, -7, -1, -16, 44, 43, 29,...
FALSE $ DepDelay          (int) 0, 1, -8, 3, 5, -1, -1, -5, 43, 43, 29, 19, ...
FALSE $ Origin            (chr) "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", "I...
FALSE $ Dest              (chr) "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", "D...
FALSE $ Distance          (int) 224, 224, 224, 224, 224, 224, 224, 224, 224,...
FALSE $ TaxiIn            (int) 7, 6, 5, 9, 9, 6, 12, 7, 8, 6, 8, 4, 6, 5, 6...
FALSE $ TaxiOut           (int) 13, 9, 17, 22, 9, 13, 15, 12, 22, 19, 20, 11...
FALSE $ Cancelled         (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
FALSE $ CancellationCode  (chr) "", "", "", "", "", "", "", "", "", "", "", ...
FALSE $ Diverted          (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...

~~~

결과를 일별하는데 `glimpse` 함수가 요긴하게 사용될 수 있다.
또다른 사례로 운항취소 코드를 개발자가 이애하기 쉬운 코드로 재부호화해보자.


~~~{.r}
lut = c("A"="carrier", "B"="weather", "C"="FFA", "D"="security","E"="not cancelled")

hflights$CancellationCode <- lut[hflights$CancellationCode]

glimpse(hflights)
~~~



~~~{.output}
FALSE Observations: 227,496
FALSE Variables: 21
FALSE $ Year              (int) 2011, 2011, 2011, 2011, 2011, 2011, 2011, 20...
FALSE $ Month             (int) 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
FALSE $ DayofMonth        (int) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1...
FALSE $ DayOfWeek         (int) 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6,...
FALSE $ DepTime           (int) 1400, 1401, 1352, 1403, 1405, 1359, 1359, 13...
FALSE $ ArrTime           (int) 1500, 1501, 1502, 1513, 1507, 1503, 1509, 14...
FALSE $ UniqueCarrier     (chr) "American", "American", "American", "America...
FALSE $ FlightNum         (int) 428, 428, 428, 428, 428, 428, 428, 428, 428,...
FALSE $ TailNum           (chr) "N576AA", "N557AA", "N541AA", "N403AA", "N49...
FALSE $ ActualElapsedTime (int) 60, 60, 70, 70, 62, 64, 70, 59, 71, 70, 70, ...
FALSE $ AirTime           (int) 40, 45, 48, 39, 44, 45, 43, 40, 41, 45, 42, ...
FALSE $ ArrDelay          (int) -10, -9, -8, 3, -3, -7, -1, -16, 44, 43, 29,...
FALSE $ DepDelay          (int) 0, 1, -8, 3, 5, -1, -1, -5, 43, 43, 29, 19, ...
FALSE $ Origin            (chr) "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", "I...
FALSE $ Dest              (chr) "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", "D...
FALSE $ Distance          (int) 224, 224, 224, 224, 224, 224, 224, 224, 224,...
FALSE $ TaxiIn            (int) 7, 6, 5, 9, 9, 6, 12, 7, 8, 6, 8, 4, 6, 5, 6...
FALSE $ TaxiOut           (int) 13, 9, 17, 22, 9, 13, 15, 12, 22, 19, 20, 11...
FALSE $ Cancelled         (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
FALSE $ CancellationCode  (chr) NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
FALSE $ Diverted          (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...

~~~


[^data-camp-dplyr]: [Data Manipulation in R with dplyr](https://www.datacamp.com/courses/dplyr-data-manipulation-r-tutorial)
