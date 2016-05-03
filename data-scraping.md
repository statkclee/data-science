# 데이터 과학
 


> ## 학습 목표 {.objectives}
>
>  * 웹 페이지에서 데이터를 추출한다.

### 위키사전 데이터 추출 [^wiki-scraping] 

[^wiki-scraping]: [Using rvest to Scrape an HTML Table](http://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/)

마음에 드는 웹페이지에서 데이터를 발견했을 때, 데이터를 복사하여 붙여넣기 신공을 하지 않고, 데이터를 깔끔하게 뽑아내는 방법을 살펴본다.
먼저, 마음에 드는 웹페이지를 방문하고 나서, 웹브라우져(크롬 기준)에서 마우스 우클릭으로 **검사** 를 클릭한다.
그리고 나서 해당 데이터가 보관되어 있는 위치로 이동한다. (여기서는 20대 총선 정당별 지지율 추이표)
해당하는 곳에 마우스를 올리거나, `검사창` 에서 해당 `<table>` 태그를 찾아 마우스 우클릭하고 **Copy** 메뉴의
**Copy XPath** 를 클릭해서 `XPath`를 복사하고 나서 다음 R 스크립트에 복사해서 붙여넣는다.

제 20 대 총선 위키페이지 url은 다음과 같다.

- url : [https://ko.wikipedia.org/wiki/대한민국_제20대_국회의원_선거](https://ko.wikipedia.org/wiki/대한민국_제20대_국회의원_선거)
- XPath: //*[@id="mw-content-text"]/table[8]


~~~{.r}
library(rvest)
library(dplyr)
url <- "https://ko.wikipedia.org/wiki/대한민국_제20대_국회의원_선거"
url
~~~



~~~{.output}
FALSE [1] "https://ko.wikipedia.org/wiki/대한민국_제20대_국회의원_선거"

~~~



~~~{.r}
survey <- url %>%
  html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[8]') %>%
  html_table()
~~~



~~~{.output}
FALSE Error: Table has inconsistent number of columns. Do you want fill = TRUE?

~~~



~~~{.r}
survey <- survey[[1]]
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): 객체 'survey'를 찾을 수 없습니다

~~~



~~~{.r}
head(survey)
~~~



~~~{.output}
FALSE Error in head(survey): 객체 'survey'를 찾을 수 없습니다

~~~

### 스크래핑한 데이터 정제

### 선거 지지도 데이터 통계 분석


