# 데이터 과학




## 1. 웹에서 구할 수 있는 데이터 [^webcrawling-law]{#webdata}

[^webcrawling-law]: [ZDNet, 2017-09-27, "경쟁사 웹사이트 무단 크롤링은 데이터베이스권 침해"](http://www.zdnet.co.kr/news/news_view.asp?artice_id=20170927180839)

웹에서 구할 수 있는 데이터는 형태가 다양하다. 파일형태로 지정된 것부터 시작해서 로그인을 하고 들어가서
스크래핑(Scraping)해서 가져와야 되는 것까지 정보도 많지만 다양한 기술도 필요하다.
결국 데이터를 분석하기 위해서는 R 데이터프레임으로 변환을 시켜야 한다. 
하지만, 인터넷에 널려있는 데이터는 크게 3가지 범주로 나눠볼 수 있다.

- 파일: `.csv`, `.xlsx`, `.zip`, ...
- 웹 API: JSON, XML
- 웹페이지: html 

<img src="fig/ds-webdata-overview.png" alt="웹 데이터 개요" width="77%" />

파일형태 인터넷 데이터를 R로 가져오는 방법은 `read_csv()`, `read_delim()` 함수를 활용하는 방법이 있는데,
파일이 큰 경우 중간에 네트워크 장애등으로 날아갈 수 있음으로 안전하게 `download.file()` 함수로 파일을 
작업 컴퓨터에 저장한 후에 작업을 수행한다. 통상적으로 `download.file()` 함수를 사용하는 경우 
파일크기가 커서 압축되어 있는 경우가 대부분이다. 이런 경우 `unzip()` 등 압축을 풀어 R 데이터프레임으로 가져온다.

웹 API를 통해 데이터를 가져오는 경우는 `httr` 팩키지의 기본 `GET()`, `POST()`함수가 바탕이 되는데 통상 
각 API에 대응되는 R 팩키지가 개발되어 있는 경우가 많아 개발자가 아니면 굳이 웹 API에서 바로 받는 코드를 작성할 필요는 없고,
대신에 CRAN, GitHub 등에서 팩키지를 설치하고 사용한다. Google Vision API에 대응되는 `RoogleVision`,
Open Weather Map API에 대응되는 ROpenWeatherMap 등 수많은 API 대응 R팩키지가 존재한다.

웹페이지만 공개된 경우 크롤링(crawling)을 통해서 데이터를 가져와야하는데 `rvest`를 통해서 기본적인 웹프로그래밍 지식을 바탕으로
필요한 정보만을 추출하여 R 데이터프레임으로 변환하여 작업을 수행한다.

| 데이터 형태 |     파일 자료 형태        |         R 함수/팩키지           |
|-------------|---------------------------|---------------------------------|
| 파일        |  `.csv`, `.xlsx`, `.zip`, | `read_csv()`, `download.file()` |
| 웹 API      |         JSON, XML         | `httr` + API 대응 R 팩키지      | 
| 웹페이지    |           html            |            `rvest`              |

## 2. 파일 데이터 가져오기 [^download-and-unzip] {#webdata-file}

[^download-and-unzip]: [Downloading, extracting and reading files in R](http://hydroecology.net/downloading-extracting-and-reading-files-in-r/)

[https://vincentarelbundock.github.io/Rdatasets/datasets.html](https://vincentarelbundock.github.io/Rdatasets/datasets.html)
웹사이트에 가장 많이 활발히 사용되는 데이터셋이 인터넷에 공개되어 있다.
이런 데이터를 마우스 우클릭하지 않고 바로 데이터 분석 작업을 수행하는 
R 데이터프레임으로 가져오는 방법은 다음과 같다.

`tidyverse` 팩키지를 설치하면 `read_csv()` 함수를 활용하여 해당 `url`을 인자로 넣어주면 
웹서버에 저장된 데이터를 로컬 작업 컴퓨터에 가져오게 된다.


~~~{.r}
# 1. CSV 파일 가져오기 -----------------------------------------
# library(tidyverse)

iris_df <- read_csv("https://raw.github.com/vincentarelbundock/Rdatasets/master/csv/datasets/iris.csv")
head(iris_df)
~~~



~~~{.output}
# A tibble: 6 x 6
     X1 Sepal.Length Sepal.Width Petal.Length Petal.Width Species
  <int>        <dbl>       <dbl>        <dbl>       <dbl>   <chr>
1     1          5.1         3.5          1.4         0.2  setosa
2     2          4.9         3.0          1.4         0.2  setosa
3     3          4.7         3.2          1.3         0.2  setosa
4     4          4.6         3.1          1.5         0.2  setosa
5     5          5.0         3.6          1.4         0.2  setosa
6     6          5.4         3.9          1.7         0.4  setosa

~~~

웹 파일이 중소규모 데이터를 가져올 때 `read_csv` 함수가 적합하고, 파일이 큰 경우 대부분 압축되어 있어
우선 `download.file()` 함수로 로컬 파일로 가져오고 나서, `unzip` 함수를 통해 압축을 풀어 분석작업을 이어나간다.


~~~{.r}
# 2. 압축파일 다운로드 후 가져오기 -----------------------------------------

activity_url <- "https://github.com/rdpeng/RepData_PeerAssessment1/raw/master/activity.zip"
download.file(activity_url, destfile = "data/activity.zip", method = "libcurl", mode = "wb")

# 압축파일 내부 첫번째 파일명 
fname <- unzip(zipfile = "data/activity.zip", list=TRUE)$Name[1]

unzip(zipfile="data/activity.zip", exdir="data", files="activity.csv", overwrite=TRUE)
activity_df <- read_csv("data/activity.csv")
head(activity_df)
~~~



~~~{.output}
# A tibble: 6 x 3
  steps       date interval
  <int>     <date>    <int>
1    NA 2012-10-01        0
2    NA 2012-10-01        5
3    NA 2012-10-01       10
4    NA 2012-10-01       15
5    NA 2012-10-01       20
6    NA 2012-10-01       25

~~~

## 3. 웹 API {#webdata-webapi}

### 3.1. 공개 웹 API {#webdata-webapi-wikipedia}

웹페이지 정보를 API 형태로 제공할 경우 오남용하는 경우가 많다. 
그래서 인증키 `api_key`, `token`을 발행하여 인증키를 갖고 있는 사용자만 웹 API를 통해 
데이터에 대한 접근을 허용하는 경우도 많지만, 위키백과사전과 같이 
인증키 조차도 필요없이 데이터를 제공하는 경우도 많다. 

앞서 언급했듯이 인기 있는 대부분의 API는 R 팩키지를 통해서 제공되는 경우가 많아 
API로 데이터를 바로 받아오는 것보다 API를 팩키지화한 것을 R에서 설치하여 활용하는 것이 
경우에 따라서는 더 유용하다.

[WikipediR: A MediaWiki API Wrapper](https://cran.r-project.org/web/packages/WikipediR/)은 
위키백과사전에서 제공하는 API를 통해 R에서 바로 데이터를 가져올 수 있도록 지원하고 있다.
`devtools::install_github("Ironholds/WikipediR")` 명령어로 설치를 하고 나서, 
예를 들어 **통계학** 이라는 검색어로 백과사전을 검색하게 되면 통계학에 대한 페이지 정보를 
포함하여 어느 범주에 포함되어 있고, 통계학을 역참조한 링크는 무엇이며 통계학 페이지 내부에 
포함된 링크를 포함하여 다양한 정보를 확인할 수 있다.


### 3.1. 공개 웹 API {#webdata-webapi-wikipedia}


~~~{.r}
# 1. 팩키지 설치 및 환경설정 ----------------------
# devtools::install_github("Ironholds/WikipediR")
# library(WikipediR)

# 2. 위키사전 API 활용 ----------------------------
## 2.1. 통계학 위키 페이지 정보
stat_page_metadata <- page_info("ko","wikipedia", page = "통계학")
listviewer::jsonedit(stat_page_metadata)
~~~

<!--html_preserve--><div id="htmlwidget-41e2dbb0edd70a80a4cb" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-41e2dbb0edd70a80a4cb">{"x":{"data":{"batchcomplete":"","query":{"pages":{"141":{"pageid":141,"ns":0,"title":"통계학","contentmodel":"wikitext","pagelanguage":"ko","pagelanguagehtmlcode":"ko","pagelanguagedir":"ltr","touched":"2017-09-23T18:40:15Z","lastrevid":19479350,"length":21677,"protection":[],"restrictiontypes":["edit","move"],"talkid":286257,"fullurl":"https://ko.wikipedia.org/wiki/%ED%86%B5%EA%B3%84%ED%95%99","editurl":"https://ko.wikipedia.org/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&action=edit","canonicalurl":"https://ko.wikipedia.org/wiki/%ED%86%B5%EA%B3%84%ED%95%99","displaytitle":"통계학"}}}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
## 2.2. 통계학 위키 페이지
stat_content <- page_content("ko","wikipedia", page_name = "통계학")
listviewer::jsonedit(stat_content)
~~~

<!--html_preserve--><div id="htmlwidget-7ef781229fe1b977480f" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-7ef781229fe1b977480f">{"x":{"data":{"parse":{"title":"통계학","pageid":141,"revid":19479350,"text":{"*":"<div class=\"mw-parser-output\"><div class=\"thumb tright\">\n<div class=\"thumbinner\" style=\"width:202px;\"><a href=\"/wiki/%ED%8C%8C%EC%9D%BC:Oldfaithful3.png\" class=\"image\"><img alt=\"Oldfaithful3.png\" src=\"//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Oldfaithful3.png/200px-Oldfaithful3.png\" width=\"200\" height=\"200\" class=\"thumbimage\" srcset=\"//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Oldfaithful3.png/300px-Oldfaithful3.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Oldfaithful3.png/400px-Oldfaithful3.png 2x\" data-file-width=\"401\" data-file-height=\"400\" /><\/a>\n<div class=\"thumbcaption\">\n<div class=\"magnify\"><a href=\"/wiki/%ED%8C%8C%EC%9D%BC:Oldfaithful3.png\" class=\"internal\" title=\"실제 크기로\"><\/a><\/div>\n<\/div>\n<\/div>\n<\/div>\n<p><b>통계학<\/b>(統計學, <span style=\"font-size: smaller;\"><a href=\"/wiki/%EC%98%81%EC%96%B4\" title=\"영어\">영어<\/a>:<\/span> <span lang=\"en\" xml:lang=\"en\">statistics<\/span>)은 수량적 비교를 기초로 하여, 많은 사실을 통계적으로 관찰하고 처리하는 방법을 연구하는 학문이다. 근대 과학으로서의 통계학은 19세기 중반 벨기에의 케틀레가 독일의 \"국상학(國狀學, Staatenkunde, 넓은 의미의 국가학)\"과 영국의 \"정치 산술(Political Arithmetic, 정치 사회에 대한 수량적 연구 방법)\"을 자연과학의 \"확률 이론\"과 결합하여, 수립한 학문에서 발전되었다.<sup id=\"cite_ref-1\" class=\"reference\"><a href=\"#cite_note-1\">[1]<\/a><\/sup><sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-0\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup><\/p>\n<p><\/p>\n<div id=\"toc\" class=\"toc\">\n<div class=\"toctitle\">\n<h2>목차<\/h2>\n<\/div>\n<ul>\n<li class=\"toclevel-1 tocsection-1\"><a href=\"#.EA.B0.9C.EC.9A.94\"><span class=\"tocnumber\">1<\/span> <span class=\"toctext\">개요<\/span><\/a>\n<ul>\n<li class=\"toclevel-2 tocsection-2\"><a href=\"#.EC.88.98.EB.A6.AC_.ED.86.B5.EA.B3.84.ED.95.99\"><span class=\"tocnumber\">1.1<\/span> <span class=\"toctext\">수리 통계학<\/span><\/a><\/li>\n<li class=\"toclevel-2 tocsection-3\"><a href=\"#.EC.96.B4.EC.9B.90\"><span class=\"tocnumber\">1.2<\/span> <span class=\"toctext\">어원<\/span><\/a><\/li>\n<li class=\"toclevel-2 tocsection-4\"><a href=\"#.EC.97.AD.ED.95.A0\"><span class=\"tocnumber\">1.3<\/span> <span class=\"toctext\">역할<\/span><\/a><\/li>\n<\/ul>\n<\/li>\n<li class=\"toclevel-1 tocsection-5\"><a href=\"#.EC.9A.A9.EC.96.B4\"><span class=\"tocnumber\">2<\/span> <span class=\"toctext\">용어<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-6\"><a href=\"#.ED.86.B5.EA.B3.84.EC.A0.81_.EB.B0.A9.EB.B2.95\"><span class=\"tocnumber\">3<\/span> <span class=\"toctext\">통계적 방법<\/span><\/a>\n<ul>\n<li class=\"toclevel-2 tocsection-7\"><a href=\"#.EC.8B.A4.ED.97.98_.EA.B3.84.ED.9A.8D\"><span class=\"tocnumber\">3.1<\/span> <span class=\"toctext\">실험 계획<\/span><\/a><\/li>\n<li class=\"toclevel-2 tocsection-8\"><a href=\"#.EC.84.A4.EB.AC.B8.EC.A7.80_.EC.9E.91.EC.84.B1\"><span class=\"tocnumber\">3.2<\/span> <span class=\"toctext\">설문지 작성<\/span><\/a><\/li>\n<li class=\"toclevel-2 tocsection-9\"><a href=\"#.EC.B6.94.EB.A1.A0_.ED.86.B5.EA.B3.84\"><span class=\"tocnumber\">3.3<\/span> <span class=\"toctext\">추론 통계<\/span><\/a><\/li>\n<li class=\"toclevel-2 tocsection-10\"><a href=\"#.EA.B8.B0.EC.88.A0_.ED.86.B5.EA.B3.84\"><span class=\"tocnumber\">3.4<\/span> <span class=\"toctext\">기술 통계<\/span><\/a><\/li>\n<\/ul>\n<\/li>\n<li class=\"toclevel-1 tocsection-11\"><a href=\"#.ED.86.B5.EA.B3.84.EB.B6.84.EC.84.9D_.EC.86.8C.ED.94.84.ED.8A.B8.EC.9B.A8.EC.96.B4\"><span class=\"tocnumber\">4<\/span> <span class=\"toctext\">통계분석 소프트웨어<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-12\"><a href=\"#.ED.86.B5.EA.B3.84.ED.95.99_.EA.B4.80.EB.A0.A8_.ED.95.99.EB.AC.B8\"><span class=\"tocnumber\">5<\/span> <span class=\"toctext\">통계학 관련 학문<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-13\"><a href=\"#.ED.86.B5.EA.B3.84.ED.95.99.EC.9D.98_.EB.B3.80.ED.99.94\"><span class=\"tocnumber\">6<\/span> <span class=\"toctext\">통계학의 변화<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-14\"><a href=\"#.EA.B0.81.EC.A3.BC\"><span class=\"tocnumber\">7<\/span> <span class=\"toctext\">각주<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-15\"><a href=\"#.EA.B0.99.EC.9D.B4_.EB.B3.B4.EA.B8.B0\"><span class=\"tocnumber\">8<\/span> <span class=\"toctext\">같이 보기<\/span><\/a><\/li>\n<li class=\"toclevel-1 tocsection-16\"><a href=\"#.EC.99.B8.EB.B6.80_.EB.A7.81.ED.81.AC\"><span class=\"tocnumber\">9<\/span> <span class=\"toctext\">외부 링크<\/span><\/a><\/li>\n<\/ul>\n<\/div>\n<p><\/p>\n<h2><span id=\"개요\"><\/span><span class=\"mw-headline\" id=\".EA.B0.9C.EC.9A.94\">개요<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=1\" title=\"부분 편집: 개요\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<p>통계학은 관찰 및 조사로 얻을 수 있는 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>로부터, 응용 수학의 기법을 이용해 수치상의 성질, 규칙성 또는 불규칙성을 찾아낸다. 통계적 기법은, 실험 계획, <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>의 요약이나 해석을 실시하는데 있어서의 근거를 제공하는 학문이며, 폭넓은 분야에서 응용되어 실생활에 적용되고 있다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-1\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup> 통계학은 실증적인 뿌리를 가지고 있으며, 응용에 초점을 맞추고 있기 때문에 일반적으로 <a href=\"/wiki/%EC%88%98%ED%95%99\" title=\"수학\">수학<\/a>과는 다른 별개의 수리과학으로 여겨지고 있다. 통계학을 배움으로써 발표된 수치들을 왜곡하여 해석하는 것을 막고 통계 연구를 바탕으로 합리적인 의사결정을 할 수 있다. <sup id=\"cite_ref-3\" class=\"reference\"><a href=\"#cite_note-3\">[3]<\/a><\/sup><sup id=\"cite_ref-4\" class=\"reference\"><a href=\"#cite_note-4\">[4]<\/a><\/sup> 통계학은 과학, 산업, 또는 사회의 문제에 적용되며 모집단을 연구하는 과정이 우선시된다. 모집단은 \"한나라 안에 사는 모든 사람\" 또는 \"크리스탈을 구성하는 모든 원자\"와 같이 일정한 특성을 지닌 집단이면 어느 것이든 가능하다. 통계학자들은 전체인구(인구조사를 하는 기업)에 대한 데이터를 편집한다. 이것은 정부의 통계관련 법률요약집같은 조직화된 방법으로 수행될 수도 있다. 기술통계학은 모집단의 데이터를 요약하는데 사용된다. 도수 및 비율 (경주 등) 범주 형 데이터를 설명하는 측면에서 더 유용할 동안 수치 기술자는 연속적인 데이터 유형 (소득 등)에 대한 평균과 표준 편차를 포함한다. 데이터 분석 방법 엄청난 자료가 연구되는 현대 사회에서 경제지표연구, 마케팅, 여론조사, 농업, 생명과학, 의료의 임상연구 등 다양한 분야에서 응용되고 있는 통계는 단연 우리 사회에서 가장 필요하고 실용적인 학문이라고 할 수 있다.<\/p>\n<h3><span id=\"수리_통계학\"><\/span><span class=\"mw-headline\" id=\".EC.88.98.EB.A6.AC_.ED.86.B5.EA.B3.84.ED.95.99\">수리 통계학<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=2\" title=\"부분 편집: 수리 통계학\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p>수리 통계학은 수학의 방법을 통계학에 적용한 것이다. 통계학은 원래 국가에 대한 과학으로 생각되었는데 즉, 국가의 땅, 경제, 군력, 인구 등에 관한 사실을 수집하고 분석하는 것이었다. 사용되는 수학적 방법은 해석학, 선형 대수학, 확률분석, 미분 방정식과 측도 이론적 확률이론 등을 포함한다.<\/p>\n<h3><span id=\"어원\"><\/span><span class=\"mw-headline\" id=\".EC.96.B4.EC.9B.90\">어원<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=3\" title=\"부분 편집: 어원\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p><a href=\"/wiki/%EC%98%81%EC%96%B4\" title=\"영어\">영어<\/a>의 <i>statistics<\/i>(통계학, 통계)는 확률을 뜻하는 <a href=\"/wiki/%EB%9D%BC%ED%8B%B4%EC%96%B4\" title=\"라틴어\">라틴어<\/a>의 <i>statisticus<\/i>(확률) 또는 <i>statisticum<\/i>(상태), <a href=\"/wiki/%EC%9D%B4%ED%83%88%EB%A6%AC%EC%95%84%EC%96%B4\" title=\"이탈리아어\">이탈리아어<\/a>의 <i>statista<\/i>(나라, 정치가) 등에서 유래했다고 한다. 특히 국가라는 의미가 담긴 이탈리아 어 <i>statista<\/i>의 영향을 받아, 국가의 인력, 재력 등 국가적 자료를 비교 검토하는 학문을 의미하게 되었다. 근대에서의 통계학은 벨기에의 천문학자이자 사회학자이며 근대 통계학을 확립한 인물로 평가 받는 케틀레(Lambert Adolphe Jacques Quetelet)가 벨기에의 브뤼셀에서 통계학자들로 구성된 9개의 회의를 소집한 것을 기원으로 하고 있다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-2\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup> 수집되고 분류된 숫자 데이터\"라는 의미로 사용된 것은 1829년부터이고, 약자로 stats가 처음 기록된 것은 1961년부터이다. 또, 통계학자의 의미인 statistician이 사용된 것은 1825년부터이다.<\/p>\n<h3><span id=\"역할\"><\/span><span class=\"mw-headline\" id=\".EC.97.AD.ED.95.A0\">역할<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=4\" title=\"부분 편집: 역할\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p>매우 다양한 분야의 연구에서 주어진 문제에 대하여 적절한 <a href=\"/wiki/%EC%A0%95%EB%B3%B4\" title=\"정보\">정보<\/a>를 수집하고 분석하여 해답을 구하는 과정은 아주 중요하다. 이런 방법을 연구하는 과학의 한 분야가 통계학이다. 통계학을 필요로 하는 연구분야는 농업, 생명과학, 환경과학, 산업연구, 품질보증, 시장조사 등 매우 많다. 또한 이러한 연구방식은 기업체와 정부의 의사결정과정에서 현저하게 나타난다. 주어진 문제에 대하여 필요한 자료의 형태, 자료를 수집하는 방법, 문제에 대한 최선의 답을 구하기 위한 분석방법을 결정하는 것이 통계학자의 역할이다.<\/p>\n<p>자료는 어떤 특정한 현상(주제, 사실)을 조사하기 위하여 설계하고 계획한 실험에서 나온다. 이런 종류의 자료, 즉 실험자료는 농업연구와 같은 분야에 흔히 있다. 통계학자들은 이미 나온 실험자료를 분석하는데만 관심이 있지않고, 자원을 효과적으로 사용하고 주어진 문제를 실험으로 해결하기 위하여 처음부터 실험을 계획하는데 관심이 있다.또 다른 형태의 자료를 관측으로부터 얻는다. 조사자들은 연구실 밖으로 나가서 실제로 존재하는 것을 조사한다. 이런 예로는 인구 및 주택센서스와 같은 전수조사, 여론조사, 교통량조사 등등이 있다. 이 경우 조사방법과 설문지 작성은 매우 중요한 문제가 된다. 설문지 조사에 있어서 가장 핵심적인 부분은 설문지 작성 요령이다. 묻고자 하는 질문을 짧고 명확하게 물어야 하고 응답자가 고민을 하지 않고 바로 대답할 수 있도록 구성해야 한다. 설문지는 묻고자 하는 질문이면 무엇이든지 다 물을 수 있는 것이 아니라 문제의 핵심적 내용을 담고 있어야 한다.<\/p>\n<h2><span id=\"용어\"><\/span><span class=\"mw-headline\" id=\".EC.9A.A9.EC.96.B4\">용어<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=5\" title=\"부분 편집: 용어\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<ul>\n<li><a href=\"/wiki/%EB%AA%A8%EC%A7%91%EB%8B%A8\" title=\"모집단\">모집단<\/a>&#160;: 조사의 대상이 되는 자료 전체이다.<sup id=\"cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-0\" class=\"reference\"><a href=\"#cite_note-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD-5\">[5]<\/a><\/sup><\/li>\n<li><a href=\"/wiki/%EC%A0%84%EC%88%98%EC%A1%B0%EC%82%AC\" title=\"전수조사\">전수조사<\/a>&#160;: 조사의 대상이 되는 자료 전체를 빠짐없이 조사하는 것이다.(모집단 전체를 조사).<sup id=\"cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-1\" class=\"reference\"><a href=\"#cite_note-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD-5\">[5]<\/a><\/sup><\/li>\n<li><a href=\"/w/index.php?title=%ED%91%9C%EB%B3%B8%EC%A1%B0%EC%82%AC&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"표본조사 (없는 문서)\">표본조사<\/a>&#160;: 조사의 대상이 되는 자료의 일부만을 택하여 조사함으로써 전체를 추측하는 조사이다..<sup id=\"cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-2\" class=\"reference\"><a href=\"#cite_note-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD-5\">[5]<\/a><\/sup><\/li>\n<li><a href=\"/wiki/%ED%91%9C%EB%B3%B8\" title=\"표본\">표본<\/a>: 모집단에서 추출된 자료의 집합이다.<\/li>\n<li><a href=\"/w/index.php?title=%EB%B2%94%EC%9C%84&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"범위 (없는 문서)\">범위<\/a>: 가장 큰 측정값에서 가장 작은 측정값을 뺀 값이다.<\/li>\n<li><a href=\"/w/index.php?title=%EC%B8%A1%EC%A0%95%EC%88%98%EC%A4%80&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"측정수준 (없는 문서)\">측정수준<\/a>\n<dl>\n<dd>자료의 측정수준은 다음과 같이 분류된다. 측정수준에 따라 통계에 이용해야 할 요약 통계량이나 통계 검정법이 다르다.<\/dd>\n<\/dl>\n<ul>\n<li><a href=\"/w/index.php?title=%EB%B6%84%EB%A5%98_%EC%9E%90%EB%A3%8C&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"분류 자료 (없는 문서)\">분류 자료<\/a>&#160;: 수치로 측정이 불가능한 자료이다. 질적 자료라고도 한다.\n<ul>\n<li><a href=\"/wiki/%EB%AA%85%EB%AA%A9%EC%B2%99%EB%8F%84\" title=\"명목척도\">명목척도<\/a>： 단순한 번호로 차례의 의미는 없다. (예: <a href=\"/wiki/%EC%A0%84%ED%99%94%EB%B2%88%ED%98%B8\" title=\"전화번호\">전화번호<\/a>, <a href=\"/wiki/%EB%93%B1%EB%B2%88%ED%98%B8\" title=\"등번호\">등번호<\/a>, <a href=\"/wiki/%EC%84%B1%EB%B3%84\" title=\"성별\">성별<\/a>, <a href=\"/wiki/%ED%98%88%EC%95%A1%ED%98%95\" title=\"혈액형\">혈액형<\/a>, <a href=\"/wiki/%EC%A3%BC%EC%86%8C\" title=\"주소\">주소<\/a> 등.)<\/li>\n<li><a href=\"/w/index.php?title=%EC%88%9C%EC%84%9C%EC%B2%99%EB%8F%84(%EC%84%9C%EC%97%B4%EC%B2%99%EB%8F%84)&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"순서척도(서열척도) (없는 문서)\">순서척도(서열척도)<\/a>： 순서가 의미를 가지는 번호. (예: 계급, <a href=\"/wiki/%EC%88%9C%EC%9C%84\" title=\"순위\">순위<\/a>, <a href=\"/wiki/%EB%93%B1%EA%B8%89\" title=\"등급\">등급<\/a> 등.)<\/li>\n<\/ul>\n<\/li>\n<li><a href=\"/w/index.php?title=%EC%88%98%EB%9F%89_%EC%9E%90%EB%A3%8C&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"수량 자료 (없는 문서)\">수량 자료<\/a>&#160;: 수치로 측정이 가능한 자료이다. 양적 자료라고도 한다.\n<ul>\n<li><a href=\"/w/index.php?title=%EA%B5%AC%EA%B0%84%EC%B2%99%EB%8F%84&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"구간척도 (없는 문서)\">구간척도<\/a>： 순서뿐만 아니라 그 간격에도 의미가 있으나, 0에 절대적인 의미는 없다. (예: <a href=\"/wiki/%EC%98%A8%EB%8F%84\" title=\"온도\">온도<\/a>, <a href=\"/wiki/%EC%A7%80%EB%8A%A5%EC%A7%80%EC%88%98\" class=\"mw-redirect\" title=\"지능지수\">지능지수<\/a> 등.)<\/li>\n<li><a href=\"/w/index.php?title=%EB%B9%84%EC%9C%A8%EC%B2%99%EB%8F%84&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"비율척도 (없는 문서)\">비율척도<\/a>： 0을 기준으로 하는 절대적 척도로, 간격뿐만이 아니라 비율에도 의미가 있다. (예: <a href=\"/wiki/%EC%A0%88%EB%8C%80%EC%98%A8%EB%8F%84\" class=\"mw-redirect\" title=\"절대온도\">절대온도<\/a>, <a href=\"/w/index.php?title=%EA%B8%88%EC%95%A1&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"금액 (없는 문서)\">금액<\/a>, <a href=\"/wiki/%EB%AA%B8%EB%AC%B4%EA%B2%8C\" title=\"몸무게\">몸무게<\/a>, <a href=\"/w/index.php?title=%EC%82%AC%EB%9E%8C%EC%9D%98_%ED%82%A4&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"사람의 키 (없는 문서)\">키<\/a> 등.)<\/li>\n<\/ul>\n<\/li>\n<\/ul>\n<\/li>\n<li><a href=\"/w/index.php?title=%EC%A7%91%EC%A4%91%ED%99%94&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"집중화 (없는 문서)\">집중화<\/a>\n<dl>\n<dd><a href=\"/wiki/%ED%8F%89%EA%B7%A0%EA%B0%92\" class=\"mw-redirect\" title=\"평균값\">평균값<\/a>, <a href=\"/wiki/%EC%B5%9C%EB%B9%88%EA%B0%92\" title=\"최빈값\">최빈값<\/a>, <a href=\"/wiki/%EC%A4%91%EC%95%99%EA%B0%92\" title=\"중앙값\">중앙값<\/a>(<a href=\"/wiki/%EC%A4%91%EC%9C%84%EC%88%98\" class=\"mw-redirect\" title=\"중위수\">중위수<\/a>)<\/dd>\n<\/dl>\n<\/li>\n<li><a href=\"/w/index.php?title=%EC%82%B0%ED%8F%AC%EB%8F%84&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"산포도 (없는 문서)\">산포도<\/a>\n<dl>\n<dd><a href=\"/w/index.php?title=%EB%B2%94%EC%9C%84&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"범위 (없는 문서)\">범위<\/a>, <a href=\"/wiki/%EB%B6%84%EC%82%B0\" title=\"분산\">분산<\/a>, <a href=\"/wiki/%ED%91%9C%EC%A4%80%ED%8E%B8%EC%B0%A8\" title=\"표준편차\">표준편차<\/a><sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-3\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup><\/dd>\n<\/dl>\n<\/li>\n<\/ul>\n<p>변인&#160;: 연구의 대상이 되고 있는 일련의 개체<\/p>\n<p>독립변인&#160;: 다른 변인에게 작용하거나 다른 변인을 예언하거나 설명해 주는 변인. 실험연구의 경우는 독립변인은 실험자에 의하여 임의로 통제되고 조작된다. 따라서 실험변인(experimental variable) 또는 처치변인(處置變因, treatment variable)이라고도 한다.<\/p>\n<p>종속변인: 독립변인의 조작결과(操作結果)에 의존하며 이의 효과를 판단하는 준거가 되는 변인. 실험의 기본적인 형태는 어떤 변인이 다른 어떤 변인에 어떠한 영향을 미치는지를 알아보고자 한다.<\/p>\n<p>매개변인&#160;: 종속변인에 영향을 주는 독립변인 이외의 변인으로서 연구에 통제되어야 할 변인<\/p>\n<p>양적변인&#160;: 양의 크기를 나타내기 위하여 수량으로 표시돠는 변인<\/p>\n<p>질적변인&#160;: 변인이 가지고 있는 속성을 수량화할 수 없는 변인<\/p>\n<p>연속변인&#160;: 주어진 범위 내에서는 어떤 값도 가질 수 있는 변인<\/p>\n<p>비연속변인&#160;: 특정 수치만을 가진 변인<\/p>\n<h2><span id=\"통계적_방법\"><\/span><span class=\"mw-headline\" id=\".ED.86.B5.EA.B3.84.EC.A0.81_.EB.B0.A9.EB.B2.95\">통계적 방법<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=6\" title=\"부분 편집: 통계적 방법\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<h3><span id=\"실험_계획\"><\/span><span class=\"mw-headline\" id=\".EC.8B.A4.ED.97.98_.EA.B3.84.ED.9A.8D\">실험 계획<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=7\" title=\"부분 편집: 실험 계획\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p>조직적인 통계 조사가 이뤄지기 전까지는 질문서를 만들어 선정된 가구에 배포하는 방식을 이용했다.<sup id=\"cite_ref-yun_6-0\" class=\"reference\"><a href=\"#cite_note-yun-6\">[6]<\/a><\/sup> 실험계획은 자료수집전에 미리 어떻게 실험할것인지 계획하여, 원하는 자료를 정확하게 수집하고 기록할 수 있도록 하는 과정이다. 자료 수집의 규모와 대상, 할당 방법을 바르게 결정하고 정당한 자료를 수집할 수 있도록 검토한다. 설문지 작성법 등도 여기에 포함된다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-4\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup><\/p>\n<h3><span id=\"설문지_작성\"><\/span><span class=\"mw-headline\" id=\".EC.84.A4.EB.AC.B8.EC.A7.80_.EC.9E.91.EC.84.B1\">설문지 작성<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=8\" title=\"부분 편집: 설문지 작성\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p>설문지 작성은 실험계획의 일부이기도 하지만, 대개 별개의 실습을 통해 체득하여야 한다. 설문지는 \"앙케이트(Enquete)\"라고도 하며 통계 자료에 필요한 자료를 수집하기 위해 필요한 질문들을 기록하는 하나의 서식이다. 이를 이용해 설문지 작성자, 응답자들의 객관적인 생각, 각자의 가치와 신념, 태도 등과 같은 여러 정보를 수집할 수있다. 설문지는 가능한 표준화 되도록 작성해야한다. 필요한 정보를 더욱 포괄적으로 획득하기 위해 설문지는 다섯 가지 요소 응답자에 대한 협조요청, 식별자료, 지시사항, 설문문항, 응답자의 분류를 위한 자료로 구성된다. 설문지는 여러 번 수정, 검토 과정을 거쳐야 의도한 자료의 수집이 가능하다. 설문지를 이용한 통계자료 수집은 비교적 비용이 적게들고 큰 표본에도 쉽게 적용이 가능하다는 장점이 있다. 그러나 다른 자료수집 방법에 비해 무응답률이 높은 편이며 응답에 대한 보충설명의 기회가 주어지지 않는다는 단점이 있다.<\/p>\n<h3><span id=\"추론_통계\"><\/span><span class=\"mw-headline\" id=\".EC.B6.94.EB.A1.A0_.ED.86.B5.EA.B3.84\">추론 통계<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=9\" title=\"부분 편집: 추론 통계\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p><a href=\"/wiki/%EC%B6%94%EB%A1%A0_%ED%86%B5%EA%B3%84\" class=\"mw-redirect\" title=\"추론 통계\">추론 통계<\/a>는 기술통계로 어떤 모집단에서 구한 표본정보를 가지고 그 모집단의 특성 및 가능성 등을 추론해내는 통계적 방법이다. 보통 수집된 자료는 어떻게 분석해야 할지 미리 정해져 있기도 하지만, 대부분 획득한 자료(모집단)을 가지고 여러 그래프를 그려보는 와중에 또다른 별개의 분석방법을 추가로 채택할 필요성을 느끼게 된다. 이러한 모집단에 대한 전체적 조감을 해보고 또다른 분석방향을 모색해 보는 과정에 해당한다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-5\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup> 추론 통계는 바탕인 기술 통계량이 있어야 한다. 이 추론 통계를 하는 이유는 모든 사람을 대상으로 검사를 하는 것은 비합리적이고 대규모 집단을 가지고 연구하는 것이 소수의 집단을 가지고 연구하는 것보다 훨씬 경제적이고 효율적이기 때문이다. 추론 통계는 기술 통계량의 정확성을 유지하는 작업으로서 사용한다. 보통 일반적인 추론은 실험 결과가 기존의 방식, 또는 다른 품종간 비교 등에서 차이점이 유의한지를 검증하는 것이다.<\/p>\n<h3><span id=\"기술_통계\"><\/span><span class=\"mw-headline\" id=\".EA.B8.B0.EC.88.A0_.ED.86.B5.EA.B3.84\">기술 통계<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=10\" title=\"부분 편집: 기술 통계\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h3>\n<p>기술(記述) 통계는 <a href=\"/wiki/%EC%B8%A1%EC%A0%95\" title=\"측정\">측정<\/a>이나 <a href=\"/wiki/%EC%8B%A4%ED%97%98\" title=\"실험\">실험<\/a>에서 수집한 자료의 정리, 표현, 요약, 해석 등을 통해 자료의 특성을 규명하는 통계적 방법이다. 기술통계에는 분석방향에 따라 여러가지가 있다. 단순한 평균 분산 등의 상투적인 분석 이외에, 모집단에서 어떤인자들이 있는지 뽑아내보는 인자분석과, 특정표본이 어떤모집단에 속하는지(원 모집단을 어떻게 여러 집단으로 나눠야 하는지) 판단하는 판별분석, 두 인자간의 상호관계에 대한 정준상관분석, 인자들의 숫자를 줄여 단순화 하는 주성분분석, 그 외 군집분석 등, 다양한 분석방법이 존재한다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-6\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup><\/p>\n<h2><span id=\"통계분석_소프트웨어\"><\/span><span class=\"mw-headline\" id=\".ED.86.B5.EA.B3.84.EB.B6.84.EC.84.9D_.EC.86.8C.ED.94.84.ED.8A.B8.EC.9B.A8.EC.96.B4\">통계분석 소프트웨어<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=11\" title=\"부분 편집: 통계분석 소프트웨어\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<ul>\n<li>SAS (Statistical Analysis System) - 기업체에서 주로 쓰는 대표적 프로그램이다. 큰 규모의 자료를 편리하게 다룰 수 있으나 각종 통계 분석 결과를 왜곡해서 보여준다는 비판을 받기도 한다.<sup id=\"cite_ref-7\" class=\"reference\"><a href=\"#cite_note-7\">[7]<\/a><\/sup><\/li>\n<li><a href=\"/wiki/R_(%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D_%EC%96%B8%EC%96%B4)\" title=\"R (프로그래밍 언어)\">R (프로그래밍 언어)<\/a>은 무료 공개 통계 프로그래밍 환경이다. S 언어에 바탕을 두고 개발되었으며, 학술적 목적으로 널리 사용된다. 새로 개발된 분석 방법들이 확장 패키지를 통해 공개되고 있다.<\/li>\n<li><a href=\"/wiki/SPSS\" title=\"SPSS\">SPSS<\/a> (Statistical Package for the Social Sciences)는 1995 년 윈도 버전이 출시되었다.<\/li>\n<\/ul>\n<p>다양한 통계분석을 할 수 있고 사회과학, 의학 등 전 분야에서 다양하게 쓰이는 프로그램이나 계산 속도가 느려 큰 규모의 자료를 다루기에는 편리하지 않다.<\/p>\n<ul>\n<li>MINITAB - 학교와 기업에서 품질관리와 통계학 교육용으로 많이 사용되는 프로그램이다.<\/li>\n<\/ul>\n<h2><span id=\"통계학_관련_학문\"><\/span><span class=\"mw-headline\" id=\".ED.86.B5.EA.B3.84.ED.95.99_.EA.B4.80.EB.A0.A8_.ED.95.99.EB.AC.B8\">통계학 관련 학문<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=12\" title=\"부분 편집: 통계학 관련 학문\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<p>통계학은 <a href=\"/wiki/%EC%BB%B4%ED%93%A8%ED%84%B0_%EA%B3%BC%ED%95%99\" title=\"컴퓨터 과학\">컴퓨터 과학<\/a>, <a href=\"/wiki/%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D_%EC%96%B8%EC%96%B4\" title=\"프로그래밍 언어\">프로그래밍 언어<\/a>, <a href=\"/wiki/%EC%84%A0%ED%98%95%EB%8C%80%EC%88%98%ED%95%99\" title=\"선형대수학\">선형대수학<\/a>, <a href=\"/wiki/%ED%95%B4%EC%84%9D%ED%95%99_(%EC%88%98%ED%95%99)\" title=\"해석학 (수학)\">해석학<\/a>, <a href=\"/wiki/%EB%B6%84%ED%8F%AC_(%ED%95%B4%EC%84%9D%ED%95%99)\" title=\"분포 (해석학)\">분포론<\/a>, <a href=\"/wiki/%EC%88%98%EC%B9%98_%ED%95%B4%EC%84%9D\" class=\"mw-redirect\" title=\"수치 해석\">수치해석<\/a>, <a href=\"/wiki/%ED%99%95%EB%A5%A0%EB%A1%A0\" title=\"확률론\">확률론<\/a> 등 여러 학문과 관련되어 있다.<\/p>\n<p>통계학과 사회과학의 발전에 따라 회귀분석, 인과분석 등과 같은 평가모형들이 발전되고, 이들이 정책평가에 응용됨으로써 정책영향의 평가에 공헌을 하고 있으며, 아직도 계속 발전되어 가는 과정에 있다.<\/p>\n<p>특히 정보화사회와 빅데이터 시대를 맞아 다양한 사회정보의 수집·분석·활용을 담당하는 새로운 직종으로 기업, 정당, 지방자치단체, 중앙정부 등 각종 단체의 시장조사 및 여론조사 등에 대한 계획을 수립하고 조사를 수행하며 그 결과를 체계적으로 분석, 보고서를 작성하는 관련 학문이 필요하게 되어 사회조사분석학이 등장하게 된다.<\/p>\n<p><a href=\"/wiki/%EC%82%AC%ED%9A%8C%EC%A1%B0%EC%82%AC%EB%B6%84%EC%84%9D%EC%82%AC\" title=\"사회조사분석사\">사회조사분석사<\/a>란 기업이나 정당, 지자체, 중앙정부 등 각종 단체가 필요로 하는 조사를 수행해 분석, 보고하는 전문 인력군이다. 주로 경영, 조사기획, 자료분석, 마케팅 분야에서 일하므로 조사방법론, 사회통계, SPSS 통계분석 실무 등의 지식을 필요로 한다.<\/p>\n<h2><span id=\"통계학의_변화\"><\/span><span class=\"mw-headline\" id=\".ED.86.B5.EA.B3.84.ED.95.99.EC.9D.98_.EB.B3.80.ED.99.94\">통계학의 변화<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=13\" title=\"부분 편집: 통계학의 변화\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<p>현대에 들어와 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 과학자들로 구성된 통계 조직은 기관과 단체 그리고 기업의 수익에 영향을 미치는 다양한 데이터를 입체적으로 분석하고 결론을 얻어낸다. 미래를 예측해 더 나은 결과물을 처방한다. 수많은 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 가운데 의미 있는 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>를 찾아냄으로써 더 나은 의사결정을 돕는 작업이 있는데 데이터 클리닝, <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A7%88%EC%9D%B4%EB%8B%9D\" class=\"mw-redirect\" title=\"데이터마이닝\">데이터 마이닝<\/a> 등이다.<\/p>\n<p>기업과 기관마다 부르는 이름은 다르지만, 생산·판매와 서비스 등 핵심 직무에서 영업력 개선과 사원 복지 등 전 영역에 걸쳐 이같은 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 과학 조직의 역할은 전방위로 확대되고 있다. 업계에서는 주요 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>에 대한 분석과 통계가 이뤄지는 비즈니스인텔리전스(BI) 조직이라 부른다. <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 분석 조직을 운영하는 IT 조직은 시스템에서 나오는 각종 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>를 분석해 기업의 핵심 영역에 가치를 더하는 조직으로 변모 중이다.<\/p>\n<p><a href=\"/wiki/%EC%A0%84%EC%82%AC%EC%A0%81_%EC%9E%90%EC%9B%90_%EA%B4%80%EB%A6%AC\" title=\"전사적 자원 관리\">전사자원관리<\/a>(<a href=\"/wiki/%EC%A0%84%EC%82%AC%EC%A0%81_%EC%9E%90%EC%9B%90_%EA%B4%80%EB%A6%AC\" title=\"전사적 자원 관리\">ERP<\/a>)&#160;<span style=\"font-weight:bold;\">·<\/span> <a href=\"/wiki/%EA%B3%A0%EA%B0%9D_%EA%B4%80%EA%B3%84_%EA%B4%80%EB%A6%AC\" title=\"고객 관계 관리\">고객관계관리<\/a>(<a href=\"/wiki/%EA%B3%A0%EA%B0%9D_%EA%B4%80%EA%B3%84_%EA%B4%80%EB%A6%AC\" title=\"고객 관계 관리\">CRM<\/a>)&#160;<span style=\"font-weight:bold;\">·<\/span> <a href=\"/w/index.php?title=%EC%83%9D%EC%82%B0%EA%B4%80%EB%A6%AC%EC%8B%9C%EC%8A%A4%ED%85%9C&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"생산관리시스템 (없는 문서)\">생산관리시스템<\/a>(<a href=\"/w/index.php?title=%EC%83%9D%EC%82%B0%EA%B4%80%EB%A6%AC%EC%8B%9C%EC%8A%A4%ED%85%9C&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"생산관리시스템 (없는 문서)\">MES<\/a>)&#160;<span style=\"font-weight:bold;\">·<\/span> <a href=\"/wiki/%EA%B2%BD%EC%98%81_%EC%A0%95%EB%B3%B4_%EC%8B%9C%EC%8A%A4%ED%85%9C\" title=\"경영 정보 시스템\">경영 정보 시스템<\/a>(<a href=\"/wiki/%EA%B2%BD%EC%98%81_%EC%A0%95%EB%B3%B4_%EC%8B%9C%EC%8A%A4%ED%85%9C\" title=\"경영 정보 시스템\">MIS<\/a>)&#160;<span style=\"font-weight:bold;\">·<\/span> <a href=\"/wiki/%EC%A0%84%EB%9E%B5%EC%A0%81_%EA%B8%B0%EC%97%85_%EA%B2%BD%EC%98%81\" title=\"전략적 기업 경영\">전략적 기업 경영<\/a>(<a href=\"/wiki/%EC%A0%84%EB%9E%B5%EC%A0%81_%EA%B8%B0%EC%97%85_%EA%B2%BD%EC%98%81\" title=\"전략적 기업 경영\">SEM<\/a>) 등 각종 시스템에서 쏟아지는 수많은 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>에 대한 분석능력이 미래를 예측하는 핵심 경쟁력인 시대, 이른바 `데이터 경영` 시대의 개막이 시작되었다. 이러한 시대를 ‘<a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a>’ 기술의 시대라고 하는데 <a href=\"/wiki/%EB%AF%B8%EA%B5%AD\" title=\"미국\">미국<\/a>의 유명 경제 출판 및 미디어 기업인 <a href=\"/wiki/%ED%8F%AC%EB%B8%8C%EC%8A%A4\" title=\"포브스\">포브스<\/a>도 미래의 유망직업 중 하나로 '데이터 마이너(정보수집 분석가)'를 선정하기도 했다.<\/p>\n<p><a href=\"/wiki/%ED%8F%AC%EB%B8%8C%EC%8A%A4\" title=\"포브스\">포브스<\/a>에 의하면 <a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a>(Big Data) <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A7%88%EC%9D%B4%EB%8B%9D\" class=\"mw-redirect\" title=\"데이터마이닝\">데이터 마이닝<\/a>이란 기존 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4\" title=\"데이터베이스\">데이터베이스<\/a> 관리도구의 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 수집·저장·관리·분석의 역량을 넘어서는 대량의 정형 또는 비정형 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a> 세트 및 이러한 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0\" class=\"mw-redirect\" title=\"데이터\">데이터<\/a>로부터 가치를 추출하고 결과를 분석하는 기술로 수집되는 ‘<a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a>’를 보완, 마케팅, 시청률조사, 경영 등으로부터 체계화해 분류, 예측, 연관분석 등의 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A7%88%EC%9D%B4%EB%8B%9D\" class=\"mw-redirect\" title=\"데이터마이닝\">데이터 마이닝<\/a>을 거쳐 통계학적으로 결과를 도출해 내고 있다.<sup id=\"cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-7\" class=\"reference\"><a href=\"#cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\">[2]<\/a><\/sup><sup id=\"cite_ref-8\" class=\"reference\"><a href=\"#cite_note-8\">[8]<\/a><\/sup><sup id=\"cite_ref-9\" class=\"reference\"><a href=\"#cite_note-9\">[9]<\/a><\/sup><\/p>\n<p><a href=\"/wiki/%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD\" title=\"대한민국\">대한민국<\/a>에서는 <a href=\"/wiki/2000%EB%85%84\" title=\"2000년\">2000년<\/a>부터 <a href=\"/wiki/%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD_%EC%A0%95%EB%B3%B4%ED%86%B5%EC%8B%A0%EB%B6%80\" title=\"대한민국 정보통신부\">정보통신부<\/a>의 산하단체로 <a href=\"/wiki/%EC%82%AC%EB%8B%A8%EB%B2%95%EC%9D%B8\" title=\"사단법인\">사단법인<\/a> <a href=\"/wiki/%ED%95%9C%EA%B5%ADBI%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A7%88%EC%9D%B4%EB%8B%9D%ED%95%99%ED%9A%8C\" title=\"한국BI데이터마이닝학회\">한국BI데이터마이닝학회<\/a>가 설립되어 <a href=\"/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A7%88%EC%9D%B4%EB%8B%9D\" class=\"mw-redirect\" title=\"데이터마이닝\">데이터 마이닝<\/a>에 관한 학술과 기술을 발전, 보급, 응용하고 있다. ‎또한 국내·외 통계분야에서 서서히 <a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a> 활용에 대한 관심과 필요성이 커지고 있는 가운데 국가통계 업무를 계획하고 방대한 통계자료를 처리하는 국가기관인 <a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%B2%AD\" class=\"mw-redirect\" title=\"통계청\">통계청<\/a>이 <a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a>를 연구하고 활용방안을 모색하기 위한 '빅 데이터 연구회'를 발족하였다.<sup id=\"cite_ref-10\" class=\"reference\"><a href=\"#cite_note-10\">[10]<\/a><\/sup> 하지만 업계에 따르면, <a href=\"/wiki/%EB%AF%B8%EA%B5%AD\" title=\"미국\">미국<\/a>과 <a href=\"/wiki/%EC%98%81%EA%B5%AD\" title=\"영국\">영국<\/a>, <a href=\"/wiki/%EC%9D%BC%EB%B3%B8\" title=\"일본\">일본<\/a> 등 선진국들은 이미 <a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a>를 다각적으로 분석해 조직의 전략방향을 제시하는 데이터과학자 양성에 사활을 걸고 있다. 그러나 한국은 정부와 일부 기업이 데이터과학자 양성을 위한 프로그램을 진행 중에 있어 아직 걸음마 단계인 것으로 알려져 있다.<sup id=\"cite_ref-11\" class=\"reference\"><a href=\"#cite_note-11\">[11]<\/a><\/sup><\/p>\n<h2><span id=\"각주\"><\/span><span class=\"mw-headline\" id=\".EA.B0.81.EC.A3.BC\">각주<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=14\" title=\"부분 편집: 각주\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<ol class=\"references\">\n<li id=\"cite_note-1\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-1\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation news\"><a rel=\"nofollow\" class=\"external text\" href=\"http://news.khan.co.kr/kh_news/khan_art_view.html?artid=201301182111155&amp;code=900308\">“명저 새로 읽기, 이언 해킹 \"우연을 길들이다<span style=\"padding-right:0.2em;\">\"<\/span>”<\/a>. 경향신문. 2013년 1월 18일<span class=\"reference-accessdate\">. 2013년 3월 5일에 확인함<\/span>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.atitle=%EB%AA%85%EC%A0+%EC%83%88%EB%A1%9C+%EC%9D%BD%EA%B8%B0%2C+%EC%9D%B4%EC%96%B8+%ED%95%B4%ED%82%B9+%22%EC%9A%B0%EC%97%B0%EC%9D%84+%EA%B8%B8%EB%93%A4%EC%9D%B4%EB%A4%22&amp;rft.date=2013-01-18&amp;rft.genre=article&amp;rft_id=http%3A%2F%2Fnews.khan.co.kr%2Fkh_news%2Fkhan_art_view.html%3Fartid%3D201301182111155%26code%3D900308&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span> <span style=\"display:none;font-size:100%\" class=\"error citation-comment\">지원되지 않는 변수 무시됨: <code style=\"color:inherit; border:inherit; padding:inherit;\">|성명=<\/code> (<a href=\"/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC:%EC%9D%B8%EC%9A%A9_%EC%98%A4%EB%A5%98_%EB%8F%84%EC%9B%80%EB%A7%90#parameter_ignored\" title=\"위키백과:인용 오류 도움말\">도움말<\/a>)<\/span><\/span><\/li>\n<li id=\"cite_note-.ED.86.B5.EA.B3.84.ED.95.99-2\"><span class=\"mw-cite-backlink\">↑ <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-0\">가<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-1\">나<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-2\">다<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-3\">라<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-4\">마<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-5\">바<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-6\">사<\/a><\/sup> <sup><a href=\"#cite_ref-.ED.86.B5.EA.B3.84.ED.95.99_2-7\">아<\/a><\/sup><\/span> <span class=\"reference-text\"><cite class=\"citation book\">정상윤, 오경환 (2012). 《알기 쉬운 기초통계학》. 형설출판사. <a href=\"/wiki/%EA%B5%AD%EC%A0%9C_%ED%91%9C%EC%A4%80_%EB%8F%84%EC%84%9C_%EB%B2%88%ED%98%B8\" title=\"국제 표준 도서 번호\">ISBN<\/a>&#160;<a href=\"/wiki/%ED%8A%B9%EC%88%98:%EC%B1%85%EC%B0%BE%EA%B8%B0/9788947271820\" title=\"특수:책찾기/9788947271820\">9788947271820<\/a>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.au=%EC%A0%95%EC%83%81%EC%9C%A4%2C+%EC%98%A4%EA%B2%BD%ED%99%98&amp;rft.btitle=%EC%95%8C%EA%B8%B0+%EC%89%AC%EC%9A%B4+%EA%B8%B0%EC%B4%88%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.date=2012&amp;rft.genre=book&amp;rft.isbn=9788947271820&amp;rft.pub=%ED%98%95%EC%84%A4%EC%B6%9C%ED%8C%90%EC%82%AC&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span> <span style=\"display:none;font-size:100%\" class=\"error citation-comment\">지원되지 않는 변수 무시됨: <code style=\"color:inherit; border:inherit; padding:inherit;\">|꺾쇠표=<\/code> (<a href=\"/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC:%EC%9D%B8%EC%9A%A9_%EC%98%A4%EB%A5%98_%EB%8F%84%EC%9B%80%EB%A7%90#parameter_ignored\" title=\"위키백과:인용 오류 도움말\">도움말<\/a>)<\/span><\/span><\/li>\n<li id=\"cite_note-3\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-3\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation book\">Moore, David (1992). 〈Teaching Statistics as a Respectable Subject〉. F. Gordon and S. Gordon. 《Statistics for the Twenty-First Century》. Washington, DC: The Mathematical Association of America. 14–25쪽. <a href=\"/wiki/%EA%B5%AD%EC%A0%9C_%ED%91%9C%EC%A4%80_%EB%8F%84%EC%84%9C_%EB%B2%88%ED%98%B8\" title=\"국제 표준 도서 번호\">ISBN<\/a>&#160;<a href=\"/wiki/%ED%8A%B9%EC%88%98:%EC%B1%85%EC%B0%BE%EA%B8%B0/978-0-88385-078-7\" title=\"특수:책찾기/978-0-88385-078-7\">978-0-88385-078-7<\/a>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.atitle=Teaching+Statistics+as+a+Respectable+Subject&amp;rft.aufirst=David&amp;rft.aulast=Moore&amp;rft.btitle=Statistics+for+the+Twenty-First+Century&amp;rft.date=1992&amp;rft.genre=bookitem&amp;rft.isbn=978-0-88385-078-7&amp;rft.pages=14-25&amp;rft.place=Washington%2C+DC&amp;rft.pub=The+Mathematical+Association+of+America&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span><\/span><\/li>\n<li id=\"cite_note-4\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-4\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation book\">Chance, Beth L.; Rossman, Allan J. (2005). 〈Preface〉. <a rel=\"nofollow\" class=\"external text\" href=\"http://www.rossmanchance.com/iscam/preface.pdf\">《Investigating Statistical Concepts, Applications, and Methods》<\/a> <span style=\"font-size:85%;\">(PDF)<\/span>. Duxbury Press. <a href=\"/wiki/%EA%B5%AD%EC%A0%9C_%ED%91%9C%EC%A4%80_%EB%8F%84%EC%84%9C_%EB%B2%88%ED%98%B8\" title=\"국제 표준 도서 번호\">ISBN<\/a>&#160;<a href=\"/wiki/%ED%8A%B9%EC%88%98:%EC%B1%85%EC%B0%BE%EA%B8%B0/978-0-495-05064-3\" title=\"특수:책찾기/978-0-495-05064-3\">978-0-495-05064-3<\/a>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.atitle=Preface&amp;rft.au=Rossman%2C+Allan+J.&amp;rft.aufirst=Beth+L.&amp;rft.aulast=Chance&amp;rft.btitle=Investigating+Statistical+Concepts%2C+Applications%2C+and+Methods&amp;rft.date=2005&amp;rft.genre=bookitem&amp;rft.isbn=978-0-495-05064-3&amp;rft.pub=Duxbury+Press&amp;rft_id=http%3A%2F%2Fwww.rossmanchance.com%2Fiscam%2Fpreface.pdf&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span><\/span><\/li>\n<li id=\"cite_note-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD-5\"><span class=\"mw-cite-backlink\">↑ <sup><a href=\"#cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-0\">가<\/a><\/sup> <sup><a href=\"#cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-1\">나<\/a><\/sup> <sup><a href=\"#cite_ref-.EA.B0.9C.EB.85.90.EC.9B.90.EB.A6.AC_.EC.A0.81.EB.B6.84.EA.B3.BC.ED.86.B5.EA.B3.84.2C_.EC.9D.B4.ED.99.8D.EC.84.AD_5-2\">다<\/a><\/sup><\/span> <span class=\"reference-text\">개념원리 적분과통계, 이홍섭<\/span><\/li>\n<li id=\"cite_note-yun-6\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-yun_6-0\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation book\">윤석범. <a rel=\"nofollow\" class=\"external text\" href=\"http://www6.aladin.co.kr/shop/UsedShop/wuseditemall.aspx?ItemId=65585929&amp;TabType=1\">《새거시경제학》<\/a>. 144쪽.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.au=%EC%9C%A4%EC%84%9D%EB%B2%94&amp;rft.btitle=%EC%83%88%EA%B1%B0%EC%9C%EA%B2%BD%EC%A0%9C%ED%95%99&amp;rft.genre=book&amp;rft.pages=144&amp;rft_id=http%3A%2F%2Fwww6.aladin.co.kr%2Fshop%2FUsedShop%2Fwuseditemall.aspx%3FItemId%3D65585929%26TabType%3D1&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span><\/span><\/li>\n<li id=\"cite_note-7\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-7\">↑<\/a><\/span> <span class=\"reference-text\"><a rel=\"nofollow\" class=\"external text\" href=\"http://www.stats.ox.ac.uk/pub/MASS3/Exegeses.pdf\">Exegeses on Linear Models<\/a><\/span><\/li>\n<li id=\"cite_note-8\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-8\">↑<\/a><\/span> <span class=\"reference-text\"><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b><a rel=\"nofollow\" class=\"external text\" href=\"http://kostat.go.kr/portal/korea/index.action\">통계청<\/a> 안내 참조<\/span><\/li>\n<li id=\"cite_note-9\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-9\">↑<\/a><\/span> <span class=\"reference-text\"><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b><a rel=\"nofollow\" class=\"external text\" href=\"http://sa.stat.or.kr/\">사회조사분석사<\/a> 안내 참조<\/span><\/li>\n<li id=\"cite_note-10\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-10\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation news\"><a rel=\"nofollow\" class=\"external text\" href=\"http://www.dt.co.kr/contents.html?article_no=2012110902010860600002\">“통계청 `빅데이터 연구회` 발족, 통계정보국 직원 중심 자체 결성… 동향 분석ㆍ활용방안 모색”<\/a>. 디지털타임스. 2012년 11월 8일<span class=\"reference-accessdate\">. 2013년 3월 20일에 확인함<\/span>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.atitle=%ED%86%B5%EA%B3%84%EC%B2+%60%EB%B9%85%EB%B0%EC%9D%B4%ED%84%B0+%EC%97%B0%EA%B5%AC%ED%9A%8C%60+%EB%B0%9C%EC%A1%B1%2C+%ED%86%B5%EA%B3%84%EC%A0%95%EB%B3%B4%EA%B5+%EC%A7%81%EC%9B%90+%EC%A4%91%EC%AC+%EC%9E%90%EC%B2%B4+%EA%B2%B0%EC%84%B1%A6+%EB%8F%99%ED%96%A5+%EB%B6%84%EC%84%9D%E3%86%ED%99%9C%EC%9A%A9%EB%B0%A9%EC%95%88+%EB%AA%A8%EC%83%89&amp;rft.date=2012-11-08&amp;rft.genre=article&amp;rft_id=http%3A%2F%2Fwww.dt.co.kr%2Fcontents.html%3Farticle_no%3D2012110902010860600002&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span> <span style=\"display:none;font-size:100%\" class=\"error citation-comment\">지원되지 않는 변수 무시됨: <code style=\"color:inherit; border:inherit; padding:inherit;\">|성명=<\/code> (<a href=\"/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC:%EC%9D%B8%EC%9A%A9_%EC%98%A4%EB%A5%98_%EB%8F%84%EC%9B%80%EB%A7%90#parameter_ignored\" title=\"위키백과:인용 오류 도움말\">도움말<\/a>)<\/span><\/span><\/li>\n<li id=\"cite_note-11\"><span class=\"mw-cite-backlink\"><a href=\"#cite_ref-11\">↑<\/a><\/span> <span class=\"reference-text\"><cite class=\"citation news\"><a rel=\"nofollow\" class=\"external text\" href=\"http://weekly2.cnbnews.com/category/read.html?bcode=10087\">““빅테이터가 기업미래 좌우””<\/a>. CNB저널. 2013년 2월 12일<span class=\"reference-accessdate\">. 2013년 3월 20일에 확인함<\/span>.<\/cite><span title=\"ctx_ver=Z39.88-2004&amp;rfr_id=info%3Asid%2Fko.wikipedia.org%3A%ED%86%B5%EA%B3%84%ED%95%99&amp;rft.atitle=%9C%EB%B9%85%ED%85%8C%EC%9D%B4%ED%84%B0%EA%B0+%EA%B8%B0%EC%97%85%EB%AF%B8%EB%9E%98+%EC%A2%8C%EC%9A%B0%9D&amp;rft.date=2013-02-12&amp;rft.genre=article&amp;rft_id=http%3A%2F%2Fweekly2.cnbnews.com%2Fcategory%2Fread.html%3Fbcode%3D10087&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal\" class=\"Z3988\"><span style=\"display:none;\">&#160;<\/span><\/span> <span style=\"display:none;font-size:100%\" class=\"error citation-comment\">지원되지 않는 변수 무시됨: <code style=\"color:inherit; border:inherit; padding:inherit;\">|성명=<\/code> (<a href=\"/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC:%EC%9D%B8%EC%9A%A9_%EC%98%A4%EB%A5%98_%EB%8F%84%EC%9B%80%EB%A7%90#parameter_ignored\" title=\"위키백과:인용 오류 도움말\">도움말<\/a>)<\/span><\/span><\/li>\n<\/ol>\n<h2><span id=\"같이_보기\"><\/span><span class=\"mw-headline\" id=\".EA.B0.99.EC.9D.B4_.EB.B3.B4.EA.B8.B0\">같이 보기<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=15\" title=\"부분 편집: 같이 보기\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<ul>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%97%AD%ED%95%99\" title=\"통계역학\">통계역학<\/a><\/li>\n<li><a href=\"/w/index.php?title=%EC%9D%91%EC%9A%A9%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;redlink=1\" class=\"new\" title=\"응용통계학 (없는 문서)\">응용통계학<\/a>(Application Statistics)<\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%A0%81_%EC%9C%A0%EC%9D%98%EC%84%B1\" title=\"통계적 유의성\">통계적 유의성<\/a><\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%A0%81_%EA%B0%80%EC%84%A4\" class=\"mw-redirect\" title=\"통계적 가설\">통계적 가설<\/a><\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%A0%81_%EC%B6%94%EB%A1%A0\" title=\"통계적 추론\">통계적 추론<\/a><\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EC%B2%AD\" class=\"mw-redirect\" title=\"통계청\">통계청<\/a><\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EA%B5%90%EC%9C%A1%EC%9B%90\" title=\"통계교육원\">통계교육원<\/a><\/li>\n<li><a href=\"/wiki/%ED%86%B5%EA%B3%84%EA%B0%9C%EB%B0%9C%EC%9B%90\" title=\"통계개발원\">통계개발원<\/a><\/li>\n<li><a href=\"/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0\" title=\"빅 데이터\">빅 데이터<\/a><\/li>\n<li><a href=\"/wiki/%EA%B5%AC%EC%A1%B0%EB%B0%A9%EC%A0%95%EC%8B%9D_%EB%AA%A8%EB%8D%B8%EB%A7%81\" title=\"구조방정식 모델링\">구조방정식 모델링<\/a>(SEM)<\/li>\n<li><a href=\"/wiki/%EA%B0%9C%EB%85%90%EC%A0%81_%EB%AA%A8%ED%98%95\" title=\"개념적 모형\">개념적 모형<\/a><\/li>\n<\/ul>\n<h2><span id=\"외부_링크\"><\/span><span class=\"mw-headline\" id=\".EC.99.B8.EB.B6.80_.EB.A7.81.ED.81.AC\">외부 링크<\/span><span class=\"mw-editsection\"><span class=\"mw-editsection-bracket\">[<\/span><a href=\"/w/index.php?title=%ED%86%B5%EA%B3%84%ED%95%99&amp;action=edit&amp;section=16\" title=\"부분 편집: 외부 링크\">편집<\/a><span class=\"mw-editsection-bracket\">]<\/span><\/span><\/h2>\n<table class=\"metadata mbox-small plainlinks\" style=\"border:1px solid #aaa; background-color:#f9f9f9;\">\n<tr>\n<td class=\"mbox-image\"><img alt=\"\" src=\"//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Wikiversity-logo.svg/40px-Wikiversity-logo.svg.png\" width=\"40\" height=\"32\" srcset=\"//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Wikiversity-logo.svg/60px-Wikiversity-logo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/91/Wikiversity-logo.svg/80px-Wikiversity-logo.svg.png 2x\" data-file-width=\"1000\" data-file-height=\"800\" /><\/td>\n<td class=\"mbox-text plainlist\" style=\"\"><b><a href=\"/wiki/%EC%9C%84%ED%82%A4%EB%B0%B0%EC%9B%80%ED%84%B0\" title=\"위키배움터\">위키배움터<\/a><\/b>에 관련된 강좌가 있습니다.\n<div style=\"padding-left:1em;\"><b><a href=\"https://ko.wikiversity.org/wiki/%ED%86%B5%EA%B3%84%ED%95%99\" class=\"extiw\" title=\"v:통계학\">통계학<\/a><\/b><\/div>\n<\/td>\n<\/tr>\n<\/table>\n<ul>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://kostat.go.kr/portal/korea/index.action\">통계청 홈페이지<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://www.kss.or.kr\">한국통계학회 홈페이지<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://www.kasr.org\">한국조사연구학회 홈페이지<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://www.stat.or.kr/main.jsp\">한국통계진흥원 홈페이지<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://sa.stat.or.kr/\">사회조사분석사<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://stat.snu.ac.kr/sri/\">서울대학교 통계연구소<\/a><\/li>\n<li><b><span style=\"color: #555; font-size: smaller;\" title=\"언어: 한국어\">(한국어)<\/span><\/b> <a rel=\"nofollow\" class=\"external text\" href=\"http://cafe.daum.net/statsas\">통계분석연구회<\/a><\/li>\n<\/ul>\n<table class=\"navbox collapsible autocollapse nowraplinks\" style=\"background:white;background:white;\">\n<tr>\n<th colspan=\"2\" style=\"text-align:center;width:100%;\">\n<div style=\"float:left; width:6em; text-align:left;\"><span class=\"noprint plainlinks plainlinksneverexpand\" style=\"white-space:nowrap; font-weight:normal; font-size:smaller;&#160;;\"><a href=\"/wiki/%ED%8B%80:%EC%88%98%ED%95%99_%EB%B6%84%EC%95%BC\" title=\"틀:수학 분야\"><span title=\"이 틀을 보기\" style=\";\">v<\/span><\/a>&#160;<span style=\"font-size:smaller;\">•<\/span>&#160;<a href=\"/wiki/%ED%8B%80%ED%86%A0%EB%A1%A0:%EC%88%98%ED%95%99_%EB%B6%84%EC%95%BC\" title=\"틀토론:수학 분야\"><span title=\"이 틀에 대한 토론\" style=\";\">d<\/span><\/a>&#160;<span style=\"font-size:smaller;\">•<\/span>&#160;<a class=\"external text\" href=\"//ko.wikipedia.org/w/index.php?title=%ED%8B%80:%EC%88%98%ED%95%99_%EB%B6%84%EC%95%BC&amp;action=edit\"><span title=\"이 틀을 편집할 수 있습니다. 단, 저장하기 전에 미리 보기로 결과를 확인하여 주십시오.\" style=\";\">e<\/span><\/a>&#160;<span style=\"font-size:smaller;\">•<\/span>&#160;<a class=\"external text\" href=\"//ko.wikipedia.org/w/index.php?title=%ED%8B%80:%EC%88%98%ED%95%99_%EB%B6%84%EC%95%BC&amp;action=history\"><span title=\"이 틀의 역사를 볼 수 있습니다.\" style=\";\">h<\/span><\/a><\/span><\/div>\n<a href=\"/wiki/%EC%88%98%ED%95%99\" title=\"수학\">수학<\/a>의 주요 분야<\/th>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EC%88%98%EB%A1%A0\" class=\"mw-redirect\" title=\"수론\">수론<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EB%8C%80%EC%88%98%EC%A0%81_%EC%88%98%EB%A1%A0\" title=\"대수적 수론\">대수적 수론<\/a><\/li>\n<li><a href=\"/wiki/%ED%95%B4%EC%84%9D%EC%A0%81_%EC%88%98%EB%A1%A0\" title=\"해석적 수론\">해석적 수론<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EB%8C%80%EC%88%98%ED%95%99\" title=\"대수학\">대수학<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;background:#f7f7f7;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EC%84%A0%ED%98%95%EB%8C%80%EC%88%98%ED%95%99\" title=\"선형대수학\">선형대수학<\/a><\/li>\n<li><a href=\"/wiki/%EC%B6%94%EC%83%81%EB%8C%80%EC%88%98%ED%95%99\" title=\"추상대수학\">추상대수학<\/a><\/li>\n<li><a href=\"/wiki/%EA%B5%B0%EB%A1%A0\" title=\"군론\">군론<\/a><\/li>\n<li><a href=\"/wiki/%ED%99%98%EB%A1%A0\" title=\"환론\">환론<\/a><\/li>\n<li><a href=\"/wiki/%EA%B0%80%ED%99%98%EB%8C%80%EC%88%98%ED%95%99\" title=\"가환대수학\">가환대수학<\/a><\/li>\n<li><a href=\"/wiki/%ED%98%B8%EB%AA%B0%EB%A1%9C%EC%A7%80_%EB%8C%80%EC%88%98%ED%95%99\" title=\"호몰로지 대수학\">호몰로지 대수학<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%ED%95%B4%EC%84%9D%ED%95%99_(%EC%88%98%ED%95%99)\" title=\"해석학 (수학)\">해석학<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EB%AF%B8%EC%A0%81%EB%B6%84%ED%95%99\" title=\"미적분학\">미적분학<\/a><\/li>\n<li><a href=\"/wiki/%EC%8B%A4%ED%95%B4%EC%84%9D%ED%95%99\" title=\"실해석학\">실해석학<\/a><\/li>\n<li><a href=\"/wiki/%EB%B3%B5%EC%86%8C%ED%95%B4%EC%84%9D%ED%95%99\" title=\"복소해석학\">복소해석학<\/a><\/li>\n<li><a href=\"/wiki/%EC%88%98%EC%B9%98%ED%95%B4%EC%84%9D%ED%95%99\" title=\"수치해석학\">수치해석학<\/a><\/li>\n<li><a href=\"/wiki/%EC%B8%A1%EB%8F%84%EB%A1%A0\" class=\"mw-redirect\" title=\"측도론\">측도론<\/a><\/li>\n<li><a href=\"/wiki/%ED%95%A8%EC%88%98%ED%95%B4%EC%84%9D%ED%95%99\" title=\"함수해석학\">함수해석학<\/a><\/li>\n<li><a href=\"/wiki/%EC%A1%B0%ED%99%94%ED%95%B4%EC%84%9D%ED%95%99\" title=\"조화해석학\">조화해석학<\/a><\/li>\n<li><a href=\"/wiki/%EB%B9%84%ED%91%9C%EC%A4%80_%ED%95%B4%EC%84%9D%ED%95%99\" title=\"비표준 해석학\">비표준 해석학<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EA%B8%B0%ED%95%98%ED%95%99\" title=\"기하학\">기하학<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;background:#f7f7f7;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EB%8C%80%EC%88%98%EA%B8%B0%ED%95%98%ED%95%99\" title=\"대수기하학\">대수기하학<\/a><\/li>\n<li><a href=\"/wiki/%EA%B3%84%EC%82%B0%EA%B8%B0%ED%95%98%ED%95%99\" title=\"계산기하학\">계산기하학<\/a><\/li>\n<li><a href=\"/wiki/%ED%95%B4%EC%84%9D%EA%B8%B0%ED%95%98%ED%95%99\" title=\"해석기하학\">해석기하학<\/a><\/li>\n<li><a href=\"/wiki/%EB%AF%B8%EB%B6%84%EA%B8%B0%ED%95%98%ED%95%99\" title=\"미분기하학\">미분기하학<\/a><\/li>\n<li><a href=\"/wiki/%EB%A6%AC%EB%A7%8C_%EA%B8%B0%ED%95%98%ED%95%99\" title=\"리만 기하학\">리만 기하학<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EC%9C%84%EC%83%81%EC%88%98%ED%95%99\" title=\"위상수학\">위상수학<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EC%9D%BC%EB%B0%98%EC%9C%84%EC%83%81%EC%88%98%ED%95%99\" title=\"일반위상수학\">일반위상수학<\/a><\/li>\n<li><a href=\"/wiki/%EB%8C%80%EC%88%98%EC%A0%81_%EC%9C%84%EC%83%81%EC%88%98%ED%95%99\" title=\"대수적 위상수학\">대수적 위상수학<\/a><\/li>\n<li><a href=\"/wiki/%EB%AF%B8%EB%B6%84%EC%9C%84%EC%83%81%EC%88%98%ED%95%99\" title=\"미분위상수학\">미분위상수학<\/a><\/li>\n<li><a href=\"/wiki/%EB%A7%A4%EB%93%AD_%EC%9D%B4%EB%A1%A0\" title=\"매듭 이론\">매듭 이론<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EC%88%98%ED%95%99%EA%B8%B0%EC%B4%88%EB%A1%A0\" title=\"수학기초론\">수학기초론<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;background:#f7f7f7;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EC%88%98%EB%A6%AC%EB%85%BC%EB%A6%AC%ED%95%99\" title=\"수리논리학\">수리논리학<\/a><\/li>\n<li><a href=\"/wiki/%EB%AA%A8%ED%98%95_%EC%9D%B4%EB%A1%A0\" title=\"모형 이론\">모형 이론<\/a><\/li>\n<li><a href=\"/wiki/%EC%A6%9D%EB%AA%85_%EC%9D%B4%EB%A1%A0\" title=\"증명 이론\">증명 이론<\/a><\/li>\n<li><a href=\"/wiki/%EA%B3%84%EC%82%B0_%EA%B0%80%EB%8A%A5%EC%84%B1_%EC%9D%B4%EB%A1%A0\" title=\"계산 가능성 이론\">계산 가능성 이론<\/a><\/li>\n<li><a href=\"/wiki/%EC%A7%91%ED%95%A9%EB%A1%A0\" title=\"집합론\">집합론<\/a><\/li>\n<li><a href=\"/wiki/%EB%B2%94%EC%A3%BC%EB%A1%A0\" title=\"범주론\">범주론<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\"><a href=\"/wiki/%EC%9D%B4%EC%82%B0%EC%88%98%ED%95%99\" title=\"이산수학\">이산수학<\/a><\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%EA%B3%84%EC%82%B0_%EC%9D%B4%EB%A1%A0\" title=\"계산 이론\">계산 이론<\/a><\/li>\n<li><a href=\"/wiki/%EA%B3%84%EC%82%B0_%EB%B3%B5%EC%9E%A1%EB%8F%84_%EC%9D%B4%EB%A1%A0\" title=\"계산 복잡도 이론\">계산 복잡도 이론<\/a><\/li>\n<li><a href=\"/wiki/%EC%95%94%ED%98%B8%ED%95%99\" title=\"암호학\">암호학<\/a><\/li>\n<li><a href=\"/wiki/%EC%A1%B0%ED%95%A9%EB%A1%A0\" title=\"조합론\">조합론<\/a><\/li>\n<li><a href=\"/wiki/%EA%B7%B8%EB%9E%98%ED%94%84_%EC%9D%B4%EB%A1%A0\" title=\"그래프 이론\">그래프 이론<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<tr>\n<th style=\"white-space:nowrap;background:#ddddff;text-align:right;\">확률과 통계<\/th>\n<td colspan=\"1\" style=\"text-align:left;width:100%;background:#f7f7f7;\" class=\"navbox-list hlist\">\n<div>\n<ul>\n<li><a href=\"/wiki/%ED%99%95%EB%A5%A0%EB%A1%A0\" title=\"확률론\">확률론<\/a><\/li>\n<li><a class=\"mw-selflink selflink\">통계학<\/a><\/li>\n<li><a href=\"/wiki/%ED%99%95%EB%A5%A0%EB%AF%B8%EC%A0%81%EB%B6%84%ED%95%99\" title=\"확률미적분학\">확률미적분학<\/a><\/li>\n<li><a href=\"/wiki/%EA%B2%8C%EC%9E%84_%EC%9D%B4%EB%A1%A0\" title=\"게임 이론\">게임 이론<\/a><\/li>\n<li><a href=\"/wiki/%EA%B2%B0%EC%A0%95%EC%9D%B4%EB%A1%A0\" title=\"결정이론\">결정이론<\/a><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<\/table>\n<table class=\"navbox\" style=\"border-spacing:0\">\n<tr>\n<td style=\"padding:2px\">\n<table class=\"nowraplinks hlist navbox-inner\" style=\"border-spacing:0;background:transparent;color:inherit\">\n<tr>\n<th scope=\"row\" class=\"navbox-group\"><a href=\"/wiki/%EC%A0%84%EA%B1%B0_%ED%86%B5%EC%A0%9C\" title=\"전거 통제\">전거 통제<\/a><\/th>\n<td class=\"navbox-list navbox-odd\" style=\"text-align:left;border-left-width:2px;border-left-style:solid;width:100%;padding:0px\">\n<div style=\"padding:0em 0.25em\">\n<ul>\n<li><a href=\"/wiki/%EA%B2%8C%EB%A7%88%EC%9D%B8%EC%9E%90%EB%A9%94_%EB%85%B8%EB%A6%84%EB%8B%A4%ED%83%80%EC%9D%B4\" title=\"게마인자메 노름다타이\">GND<\/a>: <span class=\"uid\"><a rel=\"nofollow\" class=\"external text\" href=\"http://d-nb.info/gnd/4056995-0\">4056995-0<\/a><\/span><\/li>\n<li><a href=\"/wiki/%EA%B5%AD%EB%A6%BD%EA%B5%AD%ED%9A%8C%EB%8F%84%EC%84%9C%EA%B4%80\" class=\"mw-redirect\" title=\"국립국회도서관\">NDL<\/a>: <span class=\"uid\"><a rel=\"nofollow\" class=\"external text\" href=\"http://id.ndl.go.jp/auth/ndlna/00573173\">00573173<\/a><\/span><\/li>\n<\/ul>\n<\/div>\n<\/td>\n<\/tr>\n<\/table>\n<\/td>\n<\/tr>\n<\/table>\n\n\n<!-- \nNewPP limit report\nParsed by mw1161\nCached time: 20170923184503\nCache expiry: 1900800\nDynamic content: false\nCPU time usage: 0.312 seconds\nReal time usage: 0.369 seconds\nPreprocessor visited node count: 5264/1000000\nPreprocessor generated node count: 0/1500000\nPost‐expand include size: 38201/2097152 bytes\nTemplate argument size: 5097/2097152 bytes\nHighest expansion depth: 13/40\nExpensive parser function count: 0/500\nLua time usage: 0.085/10.000 seconds\nLua memory usage: 2.75 MB/50 MB\n-->\n<!--\nTransclusion expansion time report (%,ms,calls,template)\n100.00%  314.178      1 -total\n 28.30%   88.908      1 틀:수학_분야\n 27.76%   87.202      1 틀:둘러보기_상자\n 19.84%   62.320      1 틀:둘러보기_상자/핵심\n 16.95%   53.256      3 틀:뉴스_인용\n 13.63%   42.828      9 틀:언어링크\n 12.05%   37.863      1 틀:Authority_control\n 11.94%   37.513     18 틀:언어_이름\n  8.41%   26.434      4 틀:서적_인용\n  7.69%   24.155      1 틀:Llang\n-->\n<\/div>\n<!-- Saved in parser cache with key kowiki:pcache:idhash:141-0!canonical and timestamp 20170923184503 and revision id 19479350\n -->\n"}}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
## 2.3. 위키 사전 통계학 분류
stat_cats <- categories_in_page("ko", "wikipedia", pages = "통계학")
listviewer::jsonedit(stat_cats)
~~~

<!--html_preserve--><div id="htmlwidget-452ff64b81ec1336b5eb" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-452ff64b81ec1336b5eb">{"x":{"data":{"batchcomplete":"","query":{"pages":{"141":{"pageid":141,"ns":0,"title":"통계학","categories":[{"ns":14,"title":"분류:통계학","sortkey":"200aed86b5eab384ed9599","sortkeyprefix":" ","timestamp":"2011-01-11T18:12:02Z"}]}}}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
## 2.4. 위키 사전 통계학 백링크 
stat_backlink <- page_backlinks("ko", "wikipedia", page = "통계학")
listviewer::jsonedit(stat_backlink)
~~~

<!--html_preserve--><div id="htmlwidget-388ff4d4bfc9a08fa8f0" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-388ff4d4bfc9a08fa8f0">{"x":{"data":{"batchcomplete":"","continue":{"blcontinue":"0|51546","continue":"-||"},"query":{"backlinks":[{"pageid":9,"ns":0,"title":"수학"},{"pageid":20,"ns":0,"title":"나라 목록"},{"pageid":97,"ns":0,"title":"정규분포"},{"pageid":143,"ns":0,"title":"컴퓨터 과학"},{"pageid":181,"ns":0,"title":"대수학"},{"pageid":182,"ns":0,"title":"군론"},{"pageid":361,"ns":0,"title":"선형대수학"},{"pageid":370,"ns":0,"title":"프랙털"},{"pageid":623,"ns":0,"title":"언어학"},{"pageid":2129,"ns":0,"title":"미적분학"},{"pageid":2846,"ns":0,"title":"경제학"},{"pageid":3745,"ns":0,"title":"암호학"},{"pageid":3768,"ns":0,"title":"앨런 튜링"},{"pageid":4947,"ns":0,"title":"에르되시 수"},{"pageid":5611,"ns":0,"title":"통신공학"},{"pageid":6539,"ns":0,"title":"추상대수학"},{"pageid":7007,"ns":0,"title":"존 폰 노이만"},{"pageid":7278,"ns":0,"title":"그래프 이론"},{"pageid":7953,"ns":0,"title":"카를 프리드리히 가우스"},{"pageid":8149,"ns":0,"title":"환 (수학)"},{"pageid":8393,"ns":0,"title":"확률론"},{"pageid":9846,"ns":0,"title":"통계 이론","redirect":""},{"pageid":10935,"ns":0,"title":"위상수학"},{"pageid":12397,"ns":0,"title":"통계역학"},{"pageid":14560,"ns":0,"title":"정수론"},{"pageid":14670,"ns":0,"title":"기하학"},{"pageid":15144,"ns":14,"title":"분류:통계학"},{"pageid":15516,"ns":0,"title":"데이터 마이닝"},{"pageid":15567,"ns":0,"title":"생물정보학"},{"pageid":15872,"ns":0,"title":"비유클리드 기하학"},{"pageid":19896,"ns":0,"title":"수치해석학"},{"pageid":23363,"ns":4,"title":"위키백과:모든 언어의 위키백과마다 꼭 있어야 하는 문서 목록"},{"pageid":29393,"ns":0,"title":"이항 계수"},{"pageid":29567,"ns":0,"title":"대수기하학"},{"pageid":29589,"ns":0,"title":"해석학 (수학)"},{"pageid":29968,"ns":0,"title":"스티븐 제이 굴드"},{"pageid":30871,"ns":0,"title":"밀턴 프리드먼"},{"pageid":33925,"ns":0,"title":"자유도"},{"pageid":35273,"ns":0,"title":"호몰로지 대수학"},{"pageid":38331,"ns":0,"title":"거짓 양성"},{"pageid":43535,"ns":0,"title":"수리물리학"},{"pageid":44222,"ns":0,"title":"계산 이론"},{"pageid":44482,"ns":0,"title":"범주론"},{"pageid":45556,"ns":0,"title":"스와스모어 대학교"},{"pageid":46950,"ns":0,"title":"아드리앵마리 르장드르"},{"pageid":48961,"ns":0,"title":"계산 가능성 이론"},{"pageid":49022,"ns":0,"title":"적률생성함수"},{"pageid":49038,"ns":0,"title":"레일리 분포"},{"pageid":49056,"ns":0,"title":"오차 함수"},{"pageid":50751,"ns":0,"title":"증명 이론"}]}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
## 2.5. 위키 사전 통계학 페이지 내부링크
stat_links <- page_links("ko","wikipedia", page = "통계학")
listviewer::jsonedit(stat_links)
~~~

<!--html_preserve--><div id="htmlwidget-0774c7c6f32890b721f0" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-0774c7c6f32890b721f0">{"x":{"data":{"continue":{"plcontinue":"141|0|비율척도","continue":"||"},"query":{"pages":{"141":{"pageid":141,"ns":0,"title":"통계학","links":[{"ns":0,"title":"2000년"},{"ns":0,"title":"R (프로그래밍 언어)"},{"ns":0,"title":"SPSS"},{"ns":0,"title":"가환대수학"},{"ns":0,"title":"개념적 모형"},{"ns":0,"title":"게마인자메 노름다타이"},{"ns":0,"title":"게임 이론"},{"ns":0,"title":"결정이론"},{"ns":0,"title":"경영 정보 시스템"},{"ns":0,"title":"계산 가능성 이론"},{"ns":0,"title":"계산 복잡도 이론"},{"ns":0,"title":"계산 이론"},{"ns":0,"title":"계산기하학"},{"ns":0,"title":"고객 관계 관리"},{"ns":0,"title":"구간척도"},{"ns":0,"title":"구조방정식 모델링"},{"ns":0,"title":"국립국회도서관"},{"ns":0,"title":"국제 표준 도서 번호"},{"ns":0,"title":"군론"},{"ns":0,"title":"그래프 이론"},{"ns":0,"title":"금액"},{"ns":0,"title":"기하학"},{"ns":0,"title":"대수기하학"},{"ns":0,"title":"대수적 수론"},{"ns":0,"title":"대수적 위상수학"},{"ns":0,"title":"대수학"},{"ns":0,"title":"대한민국"},{"ns":0,"title":"대한민국 정보통신부"},{"ns":0,"title":"데이터"},{"ns":0,"title":"데이터마이닝"},{"ns":0,"title":"데이터베이스"},{"ns":0,"title":"등급"},{"ns":0,"title":"등번호"},{"ns":0,"title":"라틴어"},{"ns":0,"title":"리만 기하학"},{"ns":0,"title":"매듭 이론"},{"ns":0,"title":"명목척도"},{"ns":0,"title":"모집단"},{"ns":0,"title":"모형 이론"},{"ns":0,"title":"몸무게"},{"ns":0,"title":"미국"},{"ns":0,"title":"미분기하학"},{"ns":0,"title":"미분위상수학"},{"ns":0,"title":"미적분학"},{"ns":0,"title":"범위"},{"ns":0,"title":"범주론"},{"ns":0,"title":"복소해석학"},{"ns":0,"title":"분류 자료"},{"ns":0,"title":"분산"},{"ns":0,"title":"분포 (해석학)"}]}}}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
## 2.6. 위키 사전 통계학 페이지 외부링크
stat_external_links <- page_external_links("ko", "wikipedia", page = "통계학")
listviewer::jsonedit(stat_external_links)
~~~

<!--html_preserve--><div id="htmlwidget-f6920ad08250b558327b" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-f6920ad08250b558327b">{"x":{"data":{"continue":{"eloffset":10,"continue":"||"},"query":{"pages":{"141":{"pageid":141,"ns":0,"title":"통계학","extlinks":[{"*":"http://cafe.daum.net/statsas"},{"*":"http://d-nb.info/gnd/4056995-0"},{"*":"http://id.ndl.go.jp/auth/ndlna/00573173"},{"*":"http://kostat.go.kr/portal/korea/index.action"},{"*":"http://news.khan.co.kr/kh_news/khan_art_view.html?artid=201301182111155&code=900308"},{"*":"http://sa.stat.or.kr/"},{"*":"http://stat.snu.ac.kr/sri/"},{"*":"http://weekly2.cnbnews.com/category/read.html?bcode=10087"},{"*":"http://www.dt.co.kr/contents.html?article_no=2012110902010860600002"},{"*":"http://www.kasr.org"}]}}}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


### 3.2. 공개 웹 API 토큰 {#webdata-webapi-ecos}

한국은행 [ECOS OpenAPI 서비스](https://ecos.bok.or.kr/)는 디렉토리 방식으로 서비스를 제공하고 있다.
대부분 `?` 매개변수를 넘기는 방식과 비교하여 차이가 있고, 2013년 개발된 후 특별히 개선되거나 
활발히 활용되고 있는 것 같아 보이지는 않는다. 

1. `paste` 함수를 사용하여 url을 전체적으로 완성시킨다.
1. `GET` 함수로 ECOS OpenAPI 서비스에서 데이터를 가져온다.
1. `content` 함수로 필요한 데이터를 끄집어 낸다.
1. 데이터프레임으로 변환시킨 후에 분석작업을 수행한다.


~~~{.r}
# 1. 팩키지 설치 및 환경설정 ----------------------
# library(httr)
# library(ggthemes)
# library(extrafont)
# loadfonts()

# 2. 한국은행 오픈 API ----------------------

base_url <- "http://ecos.bok.or.kr/api/StatisticSearch"
API_KEY <- config::get("bok_key")
data_type <- "json"
country <- "kr"
start_index <- "1"
end_index <- "1000"
statlist <- "010Y002"
cycle_type <- "MM"
start_date <- "201001"
end_date <- "201708"
item_no <- "AAAA11"


ecos_url <- paste(base_url, API_KEY, data_type, country, start_index, end_index, statlist, 
                  cycle_type, start_date, end_date, item_no, sep="/")
  
ecos_res <- GET(ecos_url)  
listviewer::jsonedit(content(ecos_res))
~~~

<!--html_preserve--><div id="htmlwidget-fd76633a677253bd4481" style="width:672px;height:480px;" class="jsonedit html-widget"></div>
<script type="application/json" data-for="htmlwidget-fd76633a677253bd4481">{"x":{"data":{"StatisticSearch":{"list_total_count":91,"row":[{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"36887.9","ITEM_NAME3":" ","TIME":"201001"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"39400.9","ITEM_NAME3":" ","TIME":"201002"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"37567.9","ITEM_NAME3":" ","TIME":"201003"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"38045.9","ITEM_NAME3":" ","TIME":"201004"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"39204.4","ITEM_NAME3":" ","TIME":"201005"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"38939.6","ITEM_NAME3":" ","TIME":"201006"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"39421.8","ITEM_NAME3":" ","TIME":"201007"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"39593.2","ITEM_NAME3":" ","TIME":"201008"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"43247.5","ITEM_NAME3":" ","TIME":"201009"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"41352.2","ITEM_NAME3":" ","TIME":"201010"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"41967.2","ITEM_NAME3":" ","TIME":"201011"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"43307.2","ITEM_NAME3":" ","TIME":"201012"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"48083.1","ITEM_NAME3":" ","TIME":"201101"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"44655.7","ITEM_NAME3":" ","TIME":"201102"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"43731.2","ITEM_NAME3":" ","TIME":"201103"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"44116.1","ITEM_NAME3":" ","TIME":"201104"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"44679.5","ITEM_NAME3":" ","TIME":"201105"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"44580.7","ITEM_NAME3":" ","TIME":"201106"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"44968","ITEM_NAME3":" ","TIME":"201107"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"45794.1","ITEM_NAME3":" ","TIME":"201108"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"47509.2","ITEM_NAME3":" ","TIME":"201109"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"47125.8","ITEM_NAME3":" ","TIME":"201110"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"47495.4","ITEM_NAME3":" ","TIME":"201111"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"48657.6","ITEM_NAME3":" ","TIME":"201112"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"52613.8","ITEM_NAME3":" ","TIME":"201201"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"49675.4","ITEM_NAME3":" ","TIME":"201202"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"49326.3","ITEM_NAME3":" ","TIME":"201203"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"49777.4","ITEM_NAME3":" ","TIME":"201204"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"50528","ITEM_NAME3":" ","TIME":"201205"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"50226.5","ITEM_NAME3":" ","TIME":"201206"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"50590.8","ITEM_NAME3":" ","TIME":"201207"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"50681.3","ITEM_NAME3":" ","TIME":"201208"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"55524.5","ITEM_NAME3":" ","TIME":"201209"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"52775.5","ITEM_NAME3":" ","TIME":"201210"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"53213.6","ITEM_NAME3":" ","TIME":"201211"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"54334.4","ITEM_NAME3":" ","TIME":"201212"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"55277.4","ITEM_NAME3":" ","TIME":"201301"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"56792.6","ITEM_NAME3":" ","TIME":"201302"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"56213.9","ITEM_NAME3":" ","TIME":"201303"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"57549.6","ITEM_NAME3":" ","TIME":"201304"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"58073.8","ITEM_NAME3":" ","TIME":"201305"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"58089.4","ITEM_NAME3":" ","TIME":"201306"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"58637.2","ITEM_NAME3":" ","TIME":"201307"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"59279.7","ITEM_NAME3":" ","TIME":"201308"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"63093.9","ITEM_NAME3":" ","TIME":"201309"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"61659.1","ITEM_NAME3":" ","TIME":"201310"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"62279.7","ITEM_NAME3":" ","TIME":"201311"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"63365.9","ITEM_NAME3":" ","TIME":"201312"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"68717.1","ITEM_NAME3":" ","TIME":"201401"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"66160.3","ITEM_NAME3":" ","TIME":"201402"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"65742.5","ITEM_NAME3":" ","TIME":"201403"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"66687.7","ITEM_NAME3":" ","TIME":"201404"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"67028.9","ITEM_NAME3":" ","TIME":"201405"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"67208.4","ITEM_NAME3":" ","TIME":"201406"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"68038.8","ITEM_NAME3":" ","TIME":"201407"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"70612.4","ITEM_NAME3":" ","TIME":"201408"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"71641.4","ITEM_NAME3":" ","TIME":"201409"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"71392.6","ITEM_NAME3":" ","TIME":"201410"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"72511.8","ITEM_NAME3":" ","TIME":"201411"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"74944.8","ITEM_NAME3":" ","TIME":"201412"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"75495.3","ITEM_NAME3":" ","TIME":"201501"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"80502.2","ITEM_NAME3":" ","TIME":"201502"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"78044.2","ITEM_NAME3":" ","TIME":"201503"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"78699","ITEM_NAME3":" ","TIME":"201504"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"79546.1","ITEM_NAME3":" ","TIME":"201505"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"79502.4","ITEM_NAME3":" ","TIME":"201506"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"80496.09999","ITEM_NAME3":" ","TIME":"201507"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"81415.7","ITEM_NAME3":" ","TIME":"201508"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"86760.79999","ITEM_NAME3":" ","TIME":"201509"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"84589.1","ITEM_NAME3":" ","TIME":"201510"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"85055.8","ITEM_NAME3":" ","TIME":"201511"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"86757.1","ITEM_NAME3":" ","TIME":"201512"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"89627","ITEM_NAME3":" ","TIME":"201601"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"90794.2","ITEM_NAME3":" ","TIME":"201602"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"89728.5","ITEM_NAME3":" ","TIME":"201603"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"90291.1","ITEM_NAME3":" ","TIME":"201604"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"91287.9","ITEM_NAME3":" ","TIME":"201605"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"91555.1","ITEM_NAME3":" ","TIME":"201606"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"91926.5","ITEM_NAME3":" ","TIME":"201607"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"92875.6","ITEM_NAME3":" ","TIME":"201608"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"96128.2","ITEM_NAME3":" ","TIME":"201609"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"94898.6","ITEM_NAME3":" ","TIME":"201610"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"95936.1","ITEM_NAME3":" ","TIME":"201611"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"97382.3","ITEM_NAME3":" ","TIME":"201612"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"103510","ITEM_NAME3":" ","TIME":"201701"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"100231.7","ITEM_NAME3":" ","TIME":"201702"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"99474.9","ITEM_NAME3":" ","TIME":"201703"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"101124.7","ITEM_NAME3":" ","TIME":"201704"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"101331.9","ITEM_NAME3":" ","TIME":"201705"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"101368.6","ITEM_NAME3":" ","TIME":"201706"},{"UNIT_NAME":"십억원 ","STAT_NAME":"1.1.주요 통화금융지표","ITEM_CODE1":"AAAA11","STAT_CODE":"010Y002","ITEM_CODE2":" ","ITEM_CODE3":" ","ITEM_NAME1":"화폐발행잔액(말잔)","ITEM_NAME2":" ","DATA_VALUE":"101949.5","ITEM_NAME3":" ","TIME":"201707"}]}},"options":{"mode":"tree","modes":["code","form","text","tree","view"]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

~~~{.r}
# 3. 한국은행 주요경제지표 시각화 ----------------------

ecos_lst <- content(ecos_res)
ecos_df <- ecos_lst$StatisticSearch$row %>% bind_rows

ecos_df %>% 
  mutate(ddate = lubridate::ymd(paste0(str_sub(TIME,1,4), "-", str_sub(TIME,5,6), "-15")),
         value = as.numeric(DATA_VALUE)) %>% 
  select(ddate, value, STAT_CODE) %>% 
  ggplot(aes(ddate, value, group=STAT_CODE)) +
    geom_line() +
    theme_bw(base_family="NanumGothic") +
    labs(x="", y="화폐발행잔액", title="주요통화금융지표 중 화폐발행잔액",
         subtitle="단위: 십억원") +
    scale_y_continuous(labels = scales::comma)
~~~

<img src="fig/open-api-token-2.png" style="display: block; margin: auto;" />

### 3.3. 공개 웹 API 토큰과 GET 모수 {#webdata-webapi-gg-token}

[경기데이터드림 OpenAPI](http://data.gg.go.kr/portal/mainPage.do)를 통해서 경기도 데이터를 공개하여 API를 포함한 형태로 
제공해 주고 있다. 우선, 경기데이터드림 사이트에서 API-KEY를 발급받아 저장한다.
그리고 "물류 창고업체 현황"을 찾아 물류 창고업체 정보를 지리정보와 매핑하여 시각화해보자.
`SIGUN_CD`를 인자로 념겨 "수원시"에 위치한 물류 창고업체 현황정보를 파악해보자.

1. `query_param` 위치에 매개변수로 넘길 값을 리스트로 정리한다.
1. `GET(gg_url, query=query_param)` 명령어로 API 기본주소와 매개변수를 `query`로 넘긴다.
1. `content(logistics)` 명령어를 통해 XML 데이터로 출력값을 받아낸다.
1. `xml2` 팩키지 `xml_find_all()` 함수를 사용해서 `xpath`를 통해 필요한 필드값만 채워낸다.
1. `leaflet`을 통해 시각화한다.



~~~{.r}
# 1. 팩키지 설치 및 환경설정 ----------------------
# library(xml2)
# library(config)
# library(leaflet)

sigun_cd_df <- tribble(
~시군코드,	~시군명,
41000,	"경기도",
41110,	"수원시",
41130,	"성남시",
41150,	"의정부시",
41170,	"안양시",
41190,	"부천시",
41210,	"광명시",
41220,	"평택시",
41250,	"동두천시",
41270,	"안산시",
41280,	"고양시",
41290,	"과천시",
41310,	"구리시",
41360,	"남양주시",
41370,	"오산시",
41390,	"시흥시",
41410,	"군포시",
41430,	"의왕시",
41450,	"하남시",
41460,	"용인시",
41480,	"파주시",
41500,	"이천시",
41550,	"안성시",
41570,	"김포시",
41590,	"화성시",
41610,	"광주시",
41630,	"양주시",
41650,	"포천시",
41670,	"여주시",
41800,	"연천군",
41820,	"가평군",
41830,	"양평군")

# 2. 경기도 오픈 API ----------------------
## 2.1. 물류데이터 가져오기 --------------------

API_KEY <- config::get("gg_key")
gg_url <- "http://openapi.gg.go.kr/LogisticsWarehouse"

query_param <- list(
  KEY = API_KEY,
  Type = "xml",
  pIndex = "1",
  pSize = "100",
  SIGUN_CD = "41110"
)
 
logistics <- GET(gg_url, query=query_param)

## 2.2. XML 데이터프레임 변환 --------------------

gg_xml <- content(logistics)

sigun_cd <- xml_find_all(gg_xml, "//SIGUN_CD") %>% xml_text
sigun_nm <- xml_find_all(gg_xml, "//SIGUN_NM") %>% xml_text
bizplc_nm <- xml_find_all(gg_xml, "//BIZPLC_NM") %>% xml_text
emply_cnt <- xml_find_all(gg_xml, "//EMPLY_CNT") %>% xml_text
lon <- xml_find_all(gg_xml, "//REFINE_WGS84_LOGT") %>% xml_text
lat <- xml_find_all(gg_xml, "//REFINE_WGS84_LAT") %>% xml_text

logistics_df <- tibble(sigun_cd = sigun_cd,
                       sigun_nm = sigun_nm,
                       bizplc_nm = bizplc_nm,
                       emply_cnt = emply_cnt,
                       lon = lon,
                       lat = lat)

logistics_df <- logistics_df %>% 
  mutate(lon = as.numeric(lon),
         lat = as.numeric(lat))

# 3. 창고 위치 시각화 --------------------

leaflet(data = logistics_df) %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  addMarkers(lng=~lon, lat=~lat, clusterOptions = markerClusterOptions(),
             popup = ~ as.character(paste0("<strong> 물류시설 위치</strong><br><br>",
                                           "&middot; 시군명: ", sigun_nm, "<br>", 
                                           "&middot; 회사명: ", bizplc_nm, "<br>", 
                                           "&middot; 종업원수: ", emply_cnt, "<br>")))
~~~

<!--html_preserve--><div id="htmlwidget-9569200cac6b45122a7b" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-9569200cac6b45122a7b">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addProviderTiles","args":["OpenStreetMap",null,null,{"errorTileUrl":"","noWrap":false,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false}]},{"method":"addMarkers","args":[[37.2671534,37.2671534,37.2485745,37.2485745,37.2680461,37.2485745,37.2411827,37.2618457],[127.0679661,127.0679661,127.0477523,127.0477523,127.0667718,127.0477523,126.9770623,126.991947],null,null,null,{"clickable":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: 씨제이대한통운 주식회사(택배시설)<br>&middot; 종업원수: 25<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: 씨제이대한통운 주식회사(창고시설)<br>&middot; 종업원수: 20<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: (주)스파이시칼라<br>&middot; 종업원수: 88<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: (주)남영전구<br>&middot; 종업원수: 6<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: 알프스물류<br>&middot; 종업원수: 47<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: (주)패션플러스<br>&middot; 종업원수: 13<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: (주)쉥커코리아<br>&middot; 종업원수: 5<br>","<strong> 물류시설 위치<\/strong><br><br>&middot; 시군명: 수원시<br>&middot; 회사명: (주)동부택배<br>&middot; 종업원수: 5<br>"],null,{"showCoverageOnHover":true,"zoomToBoundsOnClick":true,"spiderfyOnMaxZoom":true,"removeOutsideVisibleBounds":true,"spiderLegPolylineOptions":{"weight":1.5,"color":"#222","opacity":0.5},"freezeAtZoom":false},null,null,null,null]}],"limits":{"lat":[37.2411827,37.2680461],"lng":[126.9770623,127.0679661]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

## 4. 날씨 예보 {#webdata-webapi-openweather}

R 팩키지 [ROpenWeatherMap: R Interface to OpenWeatherMap API](https://cran.r-project.org/web/packages/ROpenWeatherMap/index.html)를 활용하는 
것도 가능하지만, 직접 [Open Weather Map API](http://openweathermap.org/)에서 데이터를 가져와서 시각화하는 것도 가능하다.
이를 위해서 R 팩키지 사용법과는 별도로 일부 HTTP GET/POST에 대한 학습이 추가로 필요하다.

### 4.1. 날씨 예보 도시 하나 {#webdata-webapi-openweather-city}

[Open Weather Map API](http://openweathermap.org/)에서 도시 하나를 선택하여 날씨 정보를 가져온다.
가져온 중첩 JSON/XML 형태 데이터를 리스트 형태 데이터로 변환한 후에 `leaflet`으로 넘겨 
날씨정보를 시각화한다.


~~~{.r}
# 0. 환경설정 -----------------------------------
# library(rvest)
# library(httr)

API_KEY <- config::get("weather_key")

# 1. 데이터 가져오기 ----------------------------

query_param <- list(APPID=API_KEY, 
                    q="Seoul,kr",
                    units="metric")

weather_seoul <- GET("http://api.openweathermap.org/data/2.5/weather", query=query_param,
                     user_agent("kwangchun.lee.7@gmail.com studying..."))

weather_seoul_lst <- content(weather_seoul)
listviewer::jsonedit(weather_seoul_lst)

# 2. 데이터프레임 변환 ----------------------------

weather_df <- weather_seoul_lst %>% {
  tibble(
    city = weather_seoul_lst$name,
    lon = weather_seoul_lst$coord$lon,
    lat = weather_seoul_lst$coord$lat,
    temp = weather_seoul_lst$main$temp,
    temp_min = weather_seoul_lst$main$temp_min,
    temp_max = weather_seoul_lst$main$temp_max,
    humidity = weather_seoul_lst$main$humidity,
    speed = weather_seoul_lst$wind$speed,
    deg = weather_seoul_lst$wind$deg
  )
}



# 3. 날씨 시각화 ----------------------------

leaflet(data = weather_df) %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  addMarkers(lng=~lon, lat=~lat, clusterOptions = markerClusterOptions(),
             popup = ~ as.character(paste0("<strong> 날씨 예보</strong><br><br>",
                                           "&middot; 시군명: ", city, "<br>", 
                                           "&middot; 평균온도: ", temp, " 도<br>",
                                           "&middot; 최저온도: ", temp_min, " 도<br>", 
                                           "&middot; 최고온도: ", temp_max, " 도<br>",
                                           "&middot; 바람속도: ", speed, " m/s<br>", 
                                           "&middot; 풍향: ", deg, " 도 <br>", 
                                           "&middot; 습도: ", humidity, " % <br>")))
~~~

### 4.2. 날씨 예보 도시 여러개 {#webdata-webapi-openweather-cities}

도시를 하나 시각화 했으면... 도시를 여러개 가져와야 한다.
리스트 하나가 아닌 여러 도시를 리스트에 묶는 과정이 추가로 필요하고 입수한 데이터를 다시 풀어 
데이터프레임으로 변환하여 `leaflet`으로 시각화한다.


~~~{.r}
# 0. 환경설정 -----------------------------------

API_KEY <- config::get("weather_key")

# 1. 데이터 가져오기 ----------------------------

weather_lst <- list()

cities <- c("Seoul,kr", "Pusan,kr", "Sokcho,kr", "Daejeon,kr", "Daegu,kr")

for(city in cities) {
  query_param <- list(APPID=API_KEY, 
                      q=city,
                      units="metric")
  
  city_weather_lst <- GET("http://api.openweathermap.org/data/2.5/weather", query=query_param,
                  user_agent("kwangchun.lee.7@gmail.com studying..."))
  weather_lst[[city]] <- city_weather_lst 
}

weather_content_lst <- map(weather_lst, content)

listviewer::jsonedit(weather_content_lst)

# 2. 데이터프레임 변환 ----------------------------

weather_df <- weather_content_lst %>% {
  tibble(
    city = weather_content_lst$name,
    lon = weather_content_lst$coord$lon,
    lat = weather_content_lst$coord$lat,
    temp = weather_content_lst$main$temp,
    temp_min = weather_content_lst$main$temp_min,
    temp_max = weather_content_lst$main$temp_max,
    humidity = weather_content_lst$main$humidity,
    speed = weather_content_lst$wind$speed,
    deg = weather_content_lst$wind$deg
  )
}

name_df <- map(weather_content_lst, `[`, "name") %>% flatten %>% unlist %>% tibble
names(name_df) <- "city_name"
lon_df <- map(weather_content_lst, `[`, "coord") %>% flatten %>% map(., `[`, "lon") %>% unlist %>% tibble
names(lon_df) <- "lon"
lat_df <- map(weather_content_lst, `[`, "coord") %>% flatten %>% map(., `[`, "lat") %>% unlist %>% tibble
names(lat_df) <- "lat"
temp_df <- map(weather_content_lst, `[`, "main") %>% flatten %>% map(., `[`, "temp") %>% unlist %>% tibble
names(temp_df) <- "temp"
temp_min_df <- map(weather_content_lst, `[`, "main") %>% flatten %>% map(., `[`, "temp_min") %>% unlist %>% tibble
names(temp_min_df) <- "temp_min"
temp_max_df <- map(weather_content_lst, `[`, "main") %>% flatten %>% map(., `[`, "temp_max") %>% unlist %>% tibble
names(temp_max_df) <- "temp_max"
humidity_df <- map(weather_content_lst, `[`, "main") %>% flatten %>% map(., `[`, "humidity") %>% unlist %>% tibble
names(humidity_df) <- "humidity"
speed_df <- map(weather_content_lst, `[`, "wind") %>% flatten %>% map(., `[`, "speed") %>% unlist %>% tibble
names(speed_df) <- "speed"
deg_df <- map(weather_content_lst, `[`, "wind") %>% flatten %>% map(., `[`, "deg") %>% unlist %>% tibble
names(deg_df) <- "deg"

weather_df <- bind_cols(name_df, lon_df, lat_df, temp_df, temp_min_df, temp_max_df, humidity_df, speed_df, deg_df)

# 3. 날씨 시각화 ----------------------------

leaflet(data = weather_df) %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  addMarkers(lng=~lon, lat=~lat, clusterOptions = markerClusterOptions(),
             popup = ~ as.character(paste0("<strong> 날씨 예보</strong><br><br>",
                                           "&middot; 시군명: ", city, "<br>", 
                                           "&middot; 평균온도: ", temp, " 도<br>",
                                           "&middot; 최저온도: ", temp_min, " 도<br>", 
                                           "&middot; 최고온도: ", temp_max, " 도<br>",
                                           "&middot; 바람속도: ", speed, " m/s<br>", 
                                           "&middot; 풍향: ", deg, " 각도<br>", 
                                           "&middot; 습도: ", humidity, " % <br>")))
~~~


