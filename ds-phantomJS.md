# xwMOOC 데이터 과학
xwMOOC  
`r Sys.Date()`  




## 1. 팬텀JS (PhantomJS) {#about-phantomJS} [^datacamp-phantomJS]

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



## 2. KT 주식데이터 팬텀 JS로 가져오기 {#kt-phantomJS} 

### 2.1. 다음 주식 데이터 긁어오기 {#kt-phantomJS-crawl} 

`phantomjs` 를 쉘명령으로 실행해서 로컬 컴퓨터에 `data/daum_kt_stock.html` 파일로 저장한다.
저장된 `.html` 파일 중 특정 표(테이블)만 가져온다.


> ### `scrape_daum_kt_stock.js` 파일 {.callout}
> 
> 
> ~~~{.r}
> var webPage = require('webpage');
> var page = webPage.create();
> 
> var fs = require('fs');
> var path = 'data/daum_kt_stock.html';
> 
> page.open('http://finance.daum.net/item/quote.daum?code=030200', function (status) {
>   var content = page.content;
>   page.render('fig/daum_kt_stock.png');
>   fs.write(path, content, 'w');
>   phantom.exit();
> });
> ~~~

~~~{.r}
# 0. 환경설정 --------------------------

# library(rvest)
# library(stringr)
# library(tidyverse)

# 1. 팬텀JS 헬로우 월드 --------------------------

# 2. 데이터 긁어오기 --------------------------
system("phantomjs ./code/scrape_daum_kt_stock.js")

# Sys.setlocale("LC_ALL", "C")

kt_price_raw <- read_html("data/daum_kt_stock.html") %>%
  html_nodes(xpath='//*[@id="contentWrap"]/div[5]/table') %>% 
  html_table(fill = TRUE) %>% 
  .[[1]]

# Sys.setlocale("LC_ALL", "Korean")

kt_price_raw
~~~



~~~{.output}
               X1          X2         X3         X4
1          현재가      32,600       시가     32,000
2          전일비        ▲800       고가     32,700
3       등락률(%)      +2.52%       저가     31,600
4          거래량     392,413       매도     32,600
5  거래대금(백만)      12,650       매수     32,550
6          상한가      41,300  52주 고가     35,550
7          하한가      22,300  52주 저가     28,850
8     연중 최고가      35,550  50일 고가     35,550
9     연중 최저가      28,850  50일 저가     31,550
10   시가총액(억)      85,122 자본금(억)     15,645
11     상장주식수 261,111,808     액면가      5,000
12         결산월        12월     상장일 1998.12.23
13    업종PER(배)       12.45    PER(배)       12.0

~~~

### 2.2. 다음 KT 주식 데이터 시각화 {#kt-phantomJS-viz} 

시각화학 가능한 형태로 데이터를 변환시킨다.


~~~{.r}
# 3. 시세 분석 --------------------------
## 3.1. 데이터 정제 ---------------------
kt_price_part_1 <- kt_price_raw %>% select(key = X1, value = X2)
kt_price_part_2 <- kt_price_raw %>% select(key = X3, value = X4)

kt_price_df <- bind_rows(kt_price_part_1, kt_price_part_2)

kt_date <- kt_price_df %>% 
  filter(key == "상장일") %>% 
  mutate(상장일 = (str_replace_all(value, "\\.", "-")))  %>% 
  select(상장일)

kt_price_ochl_df <- kt_price_df %>% 
  filter(key  %in% c("상한가", "하한가", "시가", "고가", "저가", "현재가")) %>% 
  mutate(value = as.numeric(str_replace_all(value, ",", ""))) %>% 
  spread(key, value) %>% bind_cols(kt_date)

## 3.2. 시각화 ---------------------

kt_price_ochl_df %>% 
  DT::datatable() %>% 
  DT::formatCurrency(c(1:6), currency="", digits=0, interval =3 )
~~~

<!--html_preserve--><div id="htmlwidget-9951f78f2ed08f7a3dfd" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9951f78f2ed08f7a3dfd">{"x":{"filter":"none","data":[["1"],[32700],[41300],[32000],[31600],[22300],[32600],["1998-12-23"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>고가<\/th>\n      <th>상한가<\/th>\n      <th>시가<\/th>\n      <th>저가<\/th>\n      <th>하한가<\/th>\n      <th>현재가<\/th>\n      <th>상장일<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4,5,6]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false,"rowCallback":"function(row, data) {\nDTWidget.formatCurrency(this, row, data, 1, '', 0, 3, ',', '.', true);\nDTWidget.formatCurrency(this, row, data, 2, '', 0, 3, ',', '.', true);\nDTWidget.formatCurrency(this, row, data, 3, '', 0, 3, ',', '.', true);\nDTWidget.formatCurrency(this, row, data, 4, '', 0, 3, ',', '.', true);\nDTWidget.formatCurrency(this, row, data, 5, '', 0, 3, ',', '.', true);\nDTWidget.formatCurrency(this, row, data, 6, '', 0, 3, ',', '.', true);\n}"}},"evals":["options.rowCallback"],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
ggplot(data=kt_price_ochl_df, aes(x=상장일)) +
  theme_bw() +
  geom_linerange(aes(ymin=저가, ymax=고가)) +
  geom_segment(aes(y = 시가, yend = 현재가, xend = 상장일), size =3, color = "blue") +
  labs(x="", y="") +
  scale_y_continuous(labels = scales::comma)
~~~

<img src="fig/crawl-kt-viz-2.png" style="display: block; margin: auto;" />
