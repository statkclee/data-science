---
layout: page
title: 데이터 과학
subtitle: pdf 파일 데이터 추출
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## 학습 목표 {.objectives}
>
> * 광학문자인식(OCR) 기술을 통한 텍스트 추출 과정을 이해한다.
> * `.pdf` 파일에서 데이터를 추출한다.
> * `.pdf` 파일에서 추출된 데이터를 정제하는 기법을 살펴본다.

## 1. `.pdf` 파일에서 텍스트 추출 [^tesseract-ocr] [^extract-data-and-text]

[^tesseract-ocr]: [The new Tesseract package: High Quality OCR in R](https://www.r-bloggers.com/the-new-tesseract-package-high-quality-ocr-in-r/)

[^extract-data-and-text]: [Tools for Extracting Data and Text from PDFs - A Review](http://okfnlabs.org/blog/2016/04/19/pdf-tools-extract-text-and-data-from-pdfs.html)

`.pdf` 파일에서 데이터를 추출하는 작업은 흔한 데이터 랭글링(wrangling, 정제작업)으로 다음 세가지 범주로 설명가능하다.

- `.pdf` 파일에서 텍스트 추출
- `.pdf` 파일에서 표(Table) 추출
- `.pdf` 파일에서 텍스트가 아닌 스캔, 이미지 추출

마지막, `.pdf` 파일 혹은 고품질 이미지나 사진에서 텍스트를 추출하는 과정은 
광학문자인식(Optical character recognition, OCR)과 밀접한 관련이 있다.

### 1.1. `.pdf` 파일을 텍스트로 변환하는 도구 

- [PDFMiner](http://www.unixuser.org/~euske/python/pdfminer/)
- [pdftohtml](http://pdftohtml.sourceforge.net/)
- [pdftoxml](http://pdftoxml.sourceforge.net/)
- [docsplit](http://documentcloud.github.io/docsplit/)
- [pypdf2xml](https://github.com/zejn/pypdf2xml)
- [pdf2htmlEX](http://coolwanglu.github.io/pdf2htmlEX/)
- [pdf.js](http://mozilla.github.io/pdf.js/)
- [Apache Tika](https://tika.apache.org/)
- [Apache PDFBox](https://pdfbox.apache.org/)

### 1.2. `.pdf` 파일에서 표를 추출하는 도구

- [Tabula](http://tabula.technology/)
- [pdftables](https://github.com/okfn/pdftables)
- [pdftohtml](http://pdftohtml.sourceforge.net/)

### 1.3. `OCR` 작업흐름 [^ocr-workflow]

[^ocr-workflow]: [Extracting Data from PDFs](http://schoolofdata.org/handbook/courses/extracting-data-from-pdf/)

[Data Science Toolkit](http://www.datasciencetoolkit.org/)을 통해 원하는 대부분의 경우 데이터를 획득할 수 있다.
OCR을 통해 데이터를 추출하는 경우 자동차 조립라인처럼 다양한 프로그래밍 도구를 컨베이어에 태워 흘리는 과정을 거치게 된다.

1. 내용물 정제작업 
1. 레이아웃(layout) 이해 
1. 페이지별 레이아웃에 따라, 텍스트 조각을 추출.
1. 텍스트 조각을 재조합해서 유용한 형태로 변환.

<img src="fig/ds-ocr-processing-order.png" alt="OCR 이미지 처리 과정" width="77%" />

[unpaper](https://github.com/Flameeyes/unpaper)를 많이 사용하고 있으며, 스캔당시에 검은 얼룩을 제거하거 
하거나, 배경과 출력 텍스트를 정렬하고 기울어진 텍스트를 곧게 펴는 작업 등이 포함된다. 
OCR 엔진은 `.ppm` (픽스맵 파일형식, pixmap format)만 지원하기 때문에 이미지를 `.ppm` 파일 형식으로 변환한다.

- [Tesseract OCR](https://github.com/tesseract-ocr)
- [Ocropus](https://github.com/tmbdev/ocropy)
- [GNU Ocrad](http://www.gnu.org/software/ocrad/)


## 2. `.pdf` 파일로부터 표 추출 작업 [^tabulizer] [^pdftools]

[^tabulizer]: [Bindings for Tabula PDF Table Extractor Library - tabulizer](https://github.com/ropenscilabs/tabulizer)

[^pdftools]: [Extract Text and Data from PDF Documents - pdftools](https://github.com/ropensci/pdftools)

`.pdf` 파일로부터 표를 추출하는 경우 [tabulizer](https://github.com/ropenscilabs/tabulizer) 팩키지를 활용하는 것도 가능하다.
`tabulizer` 팩키지는 [tabula-java](https://github.com/tabulapdf/tabula-java/)를 기반으로 하고 있어, `tabulizerjars` 파일도 함께 설치한다.

`tabulizer` 팩키지를 설치하게 되면, `examples/data.pdf` 파일에 유명한 `mtcars`, `iris` 데이터를 PDF 파일에 표로 출력되어 있다.
이를 `extract_tables()` 함수를 사용해서 원래 데이터를 복원한다.


~~~{.r}
#1. 환경설정-------------------------------

#library(devtools)
#install_github(c("ropenscilabs/tabulizerjars", "ropenscilabs/tabulizer"), args = "--no-multiarch")

#2. 표추출-------------------------------
library(tabulizer)

# 경로 확인
.libPaths()
~~~



~~~{.output}
[1] "/Library/Frameworks/R.framework/Versions/3.2/Resources/library"

~~~



~~~{.r}
# "C:/Users/KwangChun/Documents/R/win-library/3.3" 사용자 라이브러리 경로 위치
f <- system.file(path="examples", file="data.pdf", package = "tabulizer")
~~~

### 2.1. `iris` 데이터 복원

`examples/data.pdf` 파일 2페이지에 `iris` 데이터가 표형식으로 찍혀있다. 
이를 `extract_tables(f, pages = 2, method = "data.frame")` 명령어로 추출한다.


~~~{.r}
out1 <- extract_tables(f)
str(out1)
~~~



~~~{.output}
List of 3
 $ : chr [1:32, 1:10] "mpg" "21.0" "21.0" "22.8" ...
 $ : chr [1:7, 1:3] "Sepal.Width" "3.5" "3.0" "3.2" ...
 $ : chr [1:15, 1] "supp" "VC" "VC" "VC" ...

~~~



~~~{.r}
iris_ocr <- extract_tables(f, pages = 2, method = "data.frame")

#3. 데이터프레임 변환--------------------------

iris_df <- iris_ocr[[1]]
# library(dplyr)
glimpse(iris_df)
~~~



~~~{.output}
Observations: 6
Variables: 5
$ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4
$ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9
$ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7
$ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4
$ Species      <chr> "setosa", "setosa", "setosa", "setosa", "setosa",...

~~~
















