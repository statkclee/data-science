---
layout: page
title: 데이터 과학
subtitle: 탈옥(jailbreakr) -- 엑셀에서 탈출... 자유
---

> ## 학습 목표 {.objectives}
>
> * 스프레드쉬트에 대한 대중성을 확인한다.
> * 스프레드쉬트와 R을 비교한다.
> * 엔론 사례를 통해 스프레드쉬트 현황에 대해 이해한다.


<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/jailbreakr-Get-out-of-Excel-free/player" width="480" height="270" allowFullScreen frameBorder="0"></iframe>

### 탈옥 [^user-2016-jailbreakr]

[^user-2016-jailbreakr]: [jailbreakr: Get out of Excel, free](https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/jailbreakr-Get-out-of-Excel-free)

|   데이터 분석 도구    |       사용자 수       |
|-----------------------|-----------------------|
| 마이크로소프트 오피스 |     10 억명           |
|  스프레드쉬트(엑셀)   |    6억 5천만명        |
|   수식(formulas) 사용 |       50% &uarr;      |
|      파이썬           |   백만 ~ 오백만명     |
|        R              |     25만 ~ 백만명     |


### 엑셀 코퍼스 [^excel-enron]

**엑셀 코퍼스 저장소**

* [EUSES corpus](http://openscience.us/repo/spreadsheet/euses.html):  4,447 스프레드쉬트 (16,853 워크쉬트)
* [A modern day Pompeii - Spreadsheets at Enron](http://www.felienne.com/archives/3634): 15,770 스프레드쉬트 (79,983 워크쉬트)

<img src="fig/ds-xls-enron-vs-euses.png" alt="엔론 vs Euses 엑셀 코퍼스 비교" width="50%" />

[^excel-enron]: [Enron's Spreadsheets and Related Emails: A Dataset and Analysis](https://figshare.com/articles/Enron_s_Spreadsheets_and_Related_Emails_A_Dataset_and_Analysis/1222882)

**엔론 엑셀 코퍼스 분석 결과**

* **24%** 엔론 스프레드쉬트 수식에 엑셀 오류가 있음
* 스프레드쉬트에 사용되는 함수 : 핵심 함수 15 개가 76% 스프레드쉬트에 사용됨
* **매일** 스프레드쉬트 100개가 전자우편에 첨부되어 유통
* 전자우편을 통해 스프레드쉬트가 10% 전자우편이 첨부되거나 주제로 전달됨.

| 순위 |   함수  | 스프레드쉬트 갯수 | 누적 백분율(%) |
|------|------------|----------------|------------|
| 1    | SUM        | 578            | 6.4%       |
| 2    | +          | 1259           | 14.0%      |
| 3    | -          | 2262           | 25.1%      |
| 4    | /          | 2625           | 29.1%      |
| 5    | *          | 3959           | 43.9%      |
| 6    | IF         | 4260           | 47.3%      |
| 7    | NOW        | 5322           | 59.1%      |
| 8    | AVERAGE    | 5664           | 62.8%      |
| 9    | VLOOKUP    | 5733           | 63.6%      |
| 10   | ROUND      | 5990           | 66.5%      |
| 11   | TODAY      | 6182           | 68.6%      |
| 12   | SUBTOTAL   | 6480           | 71.9%      |
| 13   | MONTH      | 6520           | 72.3%      |
| 14   | CELL       | 6774           | 75.2%      |
| 15   | YEAR       | 6812           | 75.6%      |

#### 스프레드쉬트 내 워크쉬트 갯수 분포

<img src="fig/ds-xls-worksheets-dist.png" alt="워크쉬트 분포" width="50%" />


> ### 럼스펠트가 통계에 남긴 명언 {.callout}
>
> 'you go to war with the army you have, not the army you might want or wish to have at a later time' -- Donald Rumsfeld
>
> 'you go into data analysis with the tools you know, not the tools you need' -- Jenny Bryan


### 스프레드쉬트와 R 비교

|    **스프레드쉬트**      |          **R**               |
|--------------------------|------------------------------|
| * 데이터                 | * 데이터                     |
| * 로직                   | * .R, .Rmd                   |
| * 그림                   | * .png, .svg                 |
| * 서식을 갖춘 표         | * .md, .html, .pdf, Shiny 앱 |
| * **반응성(reactivity)** | * **빌드와 배포**            |

### 스프레드쉬트 활용 사례

#### 1. 대쉬보드 사례

<img src="fig/ds-xls-enron-ex01.png" alt="엔론 사례01" width="50%" />

#### 2. 스포츠 토토

<img src="fig/ds-xls-enron-ex02.png" alt="엔론 사례02" width="50%" />

#### 3. 데이터 서식
<img src="fig/ds-xls-enron-ex03.png" alt="엔론 사례03-서식" width="50%" />

#### 4. 수식(formulas) 

<img src="fig/ds-xls-enron-ex04.png" alt="엔론 사례04-수식" width="50%" />

#### 5. 병합(merge)

<img src="fig/ds-xls-enron-ex05.png" alt="엔론 사례05-병합" width="50%" />

