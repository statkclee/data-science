# xwMOOC 데이터 과학
xwMOOC  
`r Sys.Date()`  




## 1. 팬텀JS (PhantomJS) [^datacamp-phantomJS] {#about-phantomJS}

[^datacamp-phantomJS]: [Web Scraping with R and PhantomJS](https://www.datacamp.com/community/tutorials/scraping-javascript-generated-data-with-r)

### 1.1. 팬텀JS 설치 {#install-phantomJS}

가능하면 RStudio 환경에서 모든 작업이 가능하도록 팬텀JS를 설치하고 나서 이를 윈도우 환경경로에 설정한다.

- [phantomjs.org](http://phantomjs.org/) 웹사이트에서 [팬텀JS 다운로드](http://phantomjs.org/download.html)를 다운로드한다.
- 팬텀JS 윈도우 환경 경로에 추가한다.
    - 다운로드 받은 `phantomjs-2.1.1-windows.zip` 파일 압축을 푼다.
    - `\phantomjs-2.1.1-windows\bin` 절대 경로명을 복사하여 윈도우 환경설정 경로에 추가한다.
        - 예를 들어, `C:\Users\.....\phantomjs-2.1.1-windows\bin`

<img src="fig/phantomJS_config.png" alt="팬텀JS 환경설정" width="77%" />

상기 작업을 수행하게 되면, 팬텀JS가 설치된 `C:\Users\.....\phantomjs-2.1.1-windows\bin` 경로에 상관없이 임의 디렉토리에서 `phantomjs` 명령어를 실행해도 명령이 실행된다.


~~~{.r}
D:\>phantomJS --version
2.1.1
~~~

자세한 사항은 다음 동영상을 참조한다.

<iframe width="300" height="180" src="https://www.youtube.com/embed/L8Lw53MjDdY" frameborder="0" allowfullscreen></iframe>

### 1.2. R 팬텀JS 테스트 {#phantomJS-test-on-R} [^phantomjs-hello-world]

[^phantomjs-hello-world]: [How to Install PhantomJS on Windows](https://www.joecolantonio.com/2014/10/14/how-to-install-phantomjs/)

윈도우 쉘환경에서 팬텀JS가 정상적으로 설치된 것이 확인되면 다음 단계로 운영체제에 맞는 `system`, `system2`, `shell` 등의 명령어로 
R 환경에서 쉘명령을 직접 실행해본다.

> ### `xwMOOC.js` 파일 {.callout}
> 
> 
> ~~~{.r}
> var page = require('webpage').create();
> 
> var url = 'http://statkclee.github.io/xwMOOC/';
> 
> page.open(url, function (status) {
>   console.log(status);
>   phantom.exit();
> });
> ~~~



~~~{.r}
> system("phantomjs --version")
2.1.1

> system("phantomjs ./code/xwMOOC.js")
success
~~~

## 2. 방송 3 사 8시 뉴스 혈투와 JTBC의 고민 {#news-viewer-ratings} 

### 2.1. 다음에서 방송 3사 시청률 데이터를 긁어온다.  {#stations} 

방송 3 사 8시 뉴스 혈투를 살펴보면 흥미로운 사실이 통계분석을 통해 나타난다.
이를 위해서 `scrape_daum_jtbc.js` 파일에 [다음 JTBC 뉴스룸](http://movie.daum.net/tv/ratings?tvProgramId=66868) 시청률 정보를 가져오는데,
[다음 SBS 8시 뉴스](http://movie.daum.net/tv/ratings?tvProgramId=48152), [다음 MBC 뉴스데스크](http://movie.daum.net/tv/ratings?tvProgramId=48135)도 
방송 시청률 데이터를 끌어오는 작업을 수행한다.

> ### `scrape_daum_jtbc.js` 파일 {.callout}
> 
> 
> ~~~{.r}
> var webPage = require('webpage');
> var page = webPage.create();
> 
> var fs = require('fs');
> var path = 'data/daum_jtbc.html';
> 
> page.open('http://movie.daum.net/tv/ratings?tvProgramId=66868', function (status) {
>   var content = page.content;
>   page.render('fig/daum_jtbc.png');
>   fs.write(path, content, 'w');
>   phantom.exit();
> });
> ~~~


~~~{.r}
# 0. 환경설정 --------------------------
# library(rvest)
# library(stringr)
# library(tidyverse)
# library(gganimate)
# library(ggthemes)
# library(extrafont)
# loadfonts()

# 1. 데이터 긁어오기 --------------------------
system("phantomjs ./code/scrape_daum_jtbc.js")
system("phantomjs ./code/scrape_daum_sbs.js")
system("phantomjs ./code/scrape_daum_mbc.js")

Sys.setlocale("LC_ALL", "C")
~~~



~~~{.output}
[1] "C"

~~~



~~~{.r}
jtbc_raw <- read_html("data/daum_jtbc.html") %>%
  html_nodes(xpath='//*[@id="menuSlide"]/div[2]/div[1]/table[2]') %>% 
  html_table(fill = TRUE) %>% 
  .[[1]]

sbs_raw <- read_html("data/daum_sbs.html") %>%
  html_nodes(xpath='//*[@id="menuSlide"]/div[2]/div[1]/table[2]') %>% 
  html_table(fill = TRUE) %>% 
  .[[1]]

mbc_raw <- read_html("data/daum_mbc.html") %>%
  html_nodes(xpath='//*[@id="menuSlide"]/div[2]/div[1]/table[2]') %>% 
  html_table(fill = TRUE) %>% 
  .[[1]]

Sys.setlocale("LC_ALL", "Korean")
~~~



~~~{.output}
[1] "LC_COLLATE=Korean_Korea.949;LC_CTYPE=Korean_Korea.949;LC_MONETARY=Korean_Korea.949;LC_NUMERIC=C;LC_TIME=Korean_Korea.949"

~~~

### 2.2. 데이터 정제  {#stations-data-wrangling} 

웹에서 긁어온 방송 3사 데이터를 데이터 분석이 가능하고, 시각화가 가능한 형태로 데이터를 가공한다.
특히, 주별 사이클이 확연히 존재하기 때문에 이를 최대한 파악하기 용이한 형태로 작업한다.


~~~{.r}
# 2. 데이터 정제 ---------------------
jtbc_df <- jtbc_raw %>% 
  mutate(방송사 = "JTBC", 
         시청률 = as.numeric(str_replace(시청률, "%", "")) / 100,
         날짜 = lubridate::ymd(str_replace(str_sub(날짜, 1, 10), "\\.", "-"))) %>% 
  select(방송사, 날짜, 시청률)

sbs_df <- sbs_raw %>% 
  mutate(방송사 = "SBS", 
            시청률 = as.numeric(str_replace(시청률, "%", "")) / 100,
            날짜 = lubridate::ymd(str_replace(str_sub(날짜, 1, 10), "\\.", "-"))) %>% 
  select(방송사, 날짜, 시청률)

mbc_df <- mbc_raw %>% 
  mutate(방송사 = "MBC", 
            시청률 = as.numeric(str_replace(시청률, "%", "")) / 100,
            날짜 = lubridate::ymd(str_replace(str_sub(날짜, 1, 10), "\\.", "-"))) %>% 
  select(방송사, 날짜, 시청률)

station_df <- bind_rows(jtbc_df, sbs_df) %>% 
  bind_rows(mbc_df) %>% 
  mutate(방송사 = factor(방송사, levels=c("JTBC", "SBS", "MBC")))

station_df %>% spread(방송사, 시청률) %>% 
  mutate(요일 = lubridate::wday(날짜, label=TRUE)) %>% 
  select(날짜, 요일, everything()) %>% 
  DT::datatable() %>% 
  DT::formatPercentage(c(2,3,4), digits=1)
~~~

<!--html_preserve--><div id="htmlwidget-0083812dd404e8838713" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0083812dd404e8838713">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54"],["2017-07-02","2017-07-04","2017-07-05","2017-07-06","2017-07-07","2017-07-08","2017-07-09","2017-07-10","2017-07-11","2017-07-12","2017-07-13","2017-07-14","2017-07-15","2017-07-16","2017-07-17","2017-07-18","2017-07-19","2017-07-20","2017-07-21","2017-07-22","2017-07-23","2017-07-24","2017-07-25","2017-07-26","2017-07-27","2017-07-28","2017-07-29","2017-07-30","2017-07-31","2017-08-01","2017-08-02","2017-08-03","2017-08-04","2017-08-05","2017-08-06","2017-08-07","2017-08-08","2017-08-09","2017-08-10","2017-08-11","2017-08-12","2017-08-13","2017-08-14","2017-08-15","2017-08-16","2017-08-17","2017-08-18","2017-08-19","2017-08-20","2017-08-21","2017-08-22","2017-08-23","2017-08-24","2017-08-25"],["Sun","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri","Sat","Sun","Mon","Tues","Wed","Thurs","Fri"],[null,null,null,null,0.04193,0.02548,0.0302,0.06212,0.04781,0.04979,0.04743,0.04964,0.02797,0.03232,0.05798,0.05295,0.05629,0.05055,0.04086,0.02499,0.03163,0.05771,0.05243,0.04848,0.0538,0.04022,0.02324,0.02703,0.05539,0.04704,0.05401,0.04619,0.04096,0.02552,0.02961,0.06197,0.05209,0.05638,0.05143,0.043,0.02751,0.02761,0.06049,0.06071,0.05125,0.05842,0.04378,0.02902,0.03015,0.06233,0.05897,0.05486,0.05856,0.04535],[null,0.043,0.046,0.037,0.053,0.048,0.054,0.049,0.036,0.035,0.04,0.045,0.047,0.049,0.045,0.039,0.035,0.044,0.041,0.045,0.055,0.042,0.037,null,0.036,0.038,0.043,0.046,null,0.038,0.045,0.044,0.041,0.037,0.054,0.048,0.04,0.049,0.044,0.041,0.047,0.048,0.051,null,0.043,0.041,0.039,0.048,0.061,0.044,0.038,0.043,0.041,0.039],[0.044,0.05,0.047,0.046,0.048,0.056,0.043,0.053,0.037,0.044,0.039,0.045,0.05,0.055,0.051,0.043,0.042,0.038,0.048,0.052,0.053,0.05,0.041,0.037,0.043,0.04,0.047,0.045,0.053,0.045,null,0.046,null,0.04,0.048,0.051,0.042,0.048,0.043,0.044,0.046,0.04,0.046,0.05,0.045,0.041,null,0.05,0.086,0.045,0.046,0.041,0.039,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>날짜<\/th>\n      <th>요일<\/th>\n      <th>JTBC<\/th>\n      <th>SBS<\/th>\n      <th>MBC<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[3,4,5]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false,"rowCallback":"function(row, data) {\nDTWidget.formatPercentage(this, row, data, 2, 1);\nDTWidget.formatPercentage(this, row, data, 3, 1);\nDTWidget.formatPercentage(this, row, data, 4, 1);\n}"}},"evals":["options.rowCallback"],"jsHooks":[]}</script><!--/html_preserve-->

### 2.3. 방송 3사 시청률 시각화  {#stations-static-view} 

방송 3사 최근 약 2개월 방송 시청률을 보면 손석희 앵커가 진행하는 주중에는 확연한 JTBC 우위,
손석희 앵커가 빠지는 금요일부터 토요일 일요일은 MBC와 SBS가 경쟁하는 추세가 명확히 확인된다.


~~~{.r}
# 3. 데이터 시각화 ---------------------
## 3.1. 정적 시각화
station_colors <- c("#d60cbb", "#1187c6", "#465977")

station_df %>% 
  ggplot(aes(x=날짜, y=시청률, color=방송사)) +
  geom_line(size=1.1, alpha=0.3) +
  geom_point(size=1.5, alpha=0.7) +
  theme_tufte(base_family = "NanumGothic") +
  labs(x="", y="시청률", title="방송3사 8시 뉴스 혈투") +
  scale_y_continuous(labels=scales::percent) +
  scale_x_date(date_labels = "%m-%d-%A", 
               breaks = seq(min(station_df$날짜), max(station_df$날짜), by="week")) +
  scale_fill_manual(values= station_colors) +
  theme(legend.position = "top",
        axis.text.x=element_text(angle=90,hjust=1))
~~~

<img src="fig/viz-news-viewer-ratings-1.png" style="display: block; margin: auto;" />

### 2.3. 방송 3사 시청률 변화  {#stations-animation} 

`gganimate` 팩키지를 활용하여 시각화할 경우 손석희 앵커의 주중 효과에 대해서 좀더 명확히 확인할 수 있다.


~~~{.r}
## 3.2. 동적 시각화

station_gg <- ggplot(station_df, aes(x=날짜, y=시청률, color=방송사)) +
    geom_line(size=1.1, alpha=0.3) +
    geom_point(aes(frame=날짜), size=3.7, alpha=0.7) +
    theme_tufte(base_family = "NanumGothic") +
    labs(x="", y="시청률", title="방송3사 8시 뉴스 혈투") +
    scale_y_continuous(labels=scales::percent) +
    scale_x_date(date_labels = "%m-%d-%A", 
                 breaks = seq(min(station_df$날짜), max(station_df$날짜), by="week")) +
    scale_fill_manual(values= station_colors) +
    theme(legend.position = "top",
          axis.text.x=element_text(angle=90,hjust=1))

gganimate(station_gg, "fig/jtbc_sbs_mbc.gif", ani.width = 800, ani.height = 600)
~~~

<img src="fig/jtbc_sbs_mbc.gif" alt="시청률 애니메이션" width="100%" />
