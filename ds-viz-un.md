---
layout: page
title: 데이터 과학
subtitle: UN 투표 데이터를 통해 본 한국과 주변 강대국
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---




> ## 학습 목표 {.objectives}
>
> * `broom` 팩키지를 활용한 모형 개발 방법론을 살펴본다.
> * 국제연합(United Nation) 투표 데이터를 통해 동아시아 역학관계를 이해한다.
> * `ggplot` 등 시각화 방법을 살펴본다.

## 1. UN 투표 데이터

국제연합 총회 투표 데이터로 6개 사안별로 국가별 투표성향을 분석함으로써 국가별 유사성을 확인할 수 있고,
연도별 분석을 통해 국제 역학관계에 대한 통찰력(Insight)를 얻을 수 있다.

- __6개 분야__
    - 팔레스타인 갈등 : me "Palestinian conflict",
    - 핵무기와 핵물질 : nu "Nuclear weapons and nuclear material",
    - 군비통제 및 군비해제 : di "Arms control and disarmament",
    - 인권 : hr "Human rights",
    - 식민주의 : co "Colonialism",
    - 경제발전 : ec "Economic development"

- __국가: 한국과 주변 강대국__
    - 대한민국: "South Korea"
    - 미국: "United States of America"
    - 일본: "Japan"
    - 중국: "China"
    - 러시아: "Russia"

- 분석에 사용된 데이터
    - [United Nations General Assembly Voting Data](https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379)

### 1.1. 데이터 가져오기

`RawVotingdata.tab` 데이터 크기가 커서 한국과 주변 4 강대국만을 뽑아 데이터 크기를 크게 줄였다.


~~~{.r}
# 1. 데이터 -----------------------------------------
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379
## 국가 코드표 : COW country codes.csv
cow_ct <- read_csv("data/COW country codes.csv")
cow_ct <- cow_ct %>% dplyr::select(country_code=StateAbb, code=CCode, country=StateNme)

# 한국, 미국, 일본, 중국, 러시아
korea_5 <- c("United States of America", "South Korea", "Japan", "China", "Russia")

## UN 토의주제 : descriptionsnew.xls
description <- read_excel("data/descriptionsnew.xls", sheet="descriptions")

## Vote : RawVotingdata.tab --> votes_five_nations.csv
votes <- read_csv("data/votes_five_nations.csv")
votes <- votes %>% dplyr::select(ccode, session, rcid, vote, year, country_code=StateAbb,country=StateNme)
~~~

### 1.2. 데이터 정제

`session` 변수가 년도를 나타내는 구분자가 되나 컴퓨터가 이해하는 것이고 사람이 이해하는 연도로 바꾸기 위해 `year`
변수를 하나 추가한다. `session` 변수에 1945를 더하면 된다.
`description` 데이터프레임과 병합(조인)하여 6개 분야별 투표율 추이를 확인한다.


~~~{.r}
# 2. 데이터 정제-----------------------------------------

votes <- votes %>% mutate(year = session + 1945)
votes <- votes %>% left_join(cow_ct, by=c("ccode", "country"))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 'ccode' column not found in lhs, cannot join

~~~



~~~{.r}
k_df <- votes %>% 
  inner_join(description, by=c("session", "rcid")) %>% 
  dplyr::filter(country %in% korea_5) %>% 
  mutate(country = recode(country,
                        `United States of America` = "미국",
                        `South Korea` = "한국",
                        Japan = "일본",
                        China = "중국",
                        Russia = "러시아"))
~~~


## 2. 1998년 이후 투표 유사도 경향성

한국과 주변 4개 강대국의 투표 찬성율을 한 화면에 찍어보고, `facet` 기능을 활용하여 
각 국가별 연도별 추이를 살펴본다.

<img src="fig/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" /><img src="fig/unnamed-chunk-2-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

국제연합 투표 유사도를 살펴보면 미국과 중국은 대척점에 서 있고, 
중국에 러시사아가 일본보다 다소 더 가까이 위치하며 한국은 상대적으로 많이 미국에 가까운 것이 나타난다.


## 3. 6개 분야별 투표 유사도

`gather` 함수를 활용하여 `facet` 기능을 활용할 수 있도록 변경시키고 나서, 
각 분야별 국각별 투표 유사도를 살펴본다.

- 인권: 2005년 이후 중국과 러시아가 미국과 대척점에 서 있고 한국과 일본이 그 중간 국가간 유사도를 보임
- 핵무기와 핵물질, 군비통제 및 군비해제: 표면적으로는 미일 연합을 강조하고 있지만, 국제연합 투표 유사도에 있어서는 
**일본이 한국보다 훨씬 더 중국과 투표 유사도가 높음.** 
특히, 2000년 초반보다 2000년대 후반 이후 핵무기와 핵물질의 경우 투표 유사도에 대한 차이가 더 벌어짐.

<img src="fig/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

## 4. 한국과 주변 4개국: 한국 

### 4.1. 한국 UN 총회 찬성율 추이

UN 총회 찬성율 데이터중에서 한국만 뽑아낸다. 전체적인 찬성율 추이와 더불어 
각 분야별 찬성율 추이도 함께 살펴본다.



<img src="fig/un-broom-korea-viz01-1.png" title="plot of chunk un-broom-korea-viz01" alt="plot of chunk un-broom-korea-viz01" style="display: block; margin: auto;" />

### 4.2. 한국 UN 총회 찬성율 분야별 추이

한국 UN 총회 찬성율은 지속적으로 낮아지는 것으로 나타나고 있으며 분야별로 찬성율이 올라가는 것이 있는 반면에
찬성율이 하락하는 분야도 눈에 띈다.

<img src="fig/un-broom-korea-viz02-1.png" title="plot of chunk un-broom-korea-viz02" alt="plot of chunk un-broom-korea-viz02" style="display: block; margin: auto;" />

### 4.3. 한국 UN 총회 찬성율 회귀분석

년도별 회귀분석결과 co, di 분야는 찬성율이 높아지고 나머지 분야는 찬성율이 낮아지고 있다.

- co("식민주의"): 회귀계수 양수, 찬성율 증가
- di("군비통제 및 군비해제"): 회귀계수 양수, 찬성율 증가
- ec("경제개발"): 회귀계수 음수, 찬성율 감소
- hr("인권"): 회귀계수 음수, 찬성율 감소
- me("팔레스타인 갈등"): 회귀계수 음수, 찬성율 감소
- nu("핵무기와 핵물질"): 회귀계수 음수, 찬성율 감소



~~~{.output}
# A tibble: 6 × 6
                 topic  term     estimate   std.error  statistic
                 <chr> <chr>        <dbl>       <dbl>      <dbl>
1             경제개발  year -0.009727019 0.007478156 -1.3007243
2 군비통제 및 군비해제  year  0.005870564 0.004786146  1.2265744
3             식민주의  year  0.004020979 0.002165869  1.8565197
4                 인권  year -0.010040490 0.005184953 -1.9364671
5      팔레스타인 갈등  year -0.012595927 0.002538006 -4.9629233
6      핵무기와 핵물질  year -0.004176954 0.005375599 -0.7770211
# ... with 1 more variables: p.value <dbl>

~~~


## 5. 한국과 주변 4개국: 주변 4개국

### 5.1. 6개 분야별 시각화

한국과 주변 강대국 4개국을 뽑아 연도별, 주제별 데이터프레임을 준비한다.
년도별 찬성율을 `facet` 기능을 활용하여 시각화한다.

<img src="fig/un-broom-big-four-1.png" title="plot of chunk un-broom-big-four" alt="plot of chunk un-broom-big-four" style="display: block; margin: auto;" />

### 5.2. 6개 분야별 회귀분석

각분야별 회귀분석을 돌리고 나서 유의적인 국가와 분야를 추출한다.
5개국 6개 분야 총 30개 연도별 회귀계수 중 유의적인 것은 한국의 `me`("팔레스타인 갈등")만 나온다.
즉, 한국만 해당기간 약 20년동안 팔레스타인 갈등(Palestinian Conflict) 분야에서
중국과 유사성에서 벗어나 미국과 유사도를 높여 나간 것이라는 해석도 가능하다.


~~~{.output}
# A tibble: 30 × 7
   country                topic  term      estimate   std.error
     <chr>                <chr> <chr>         <dbl>       <dbl>
1   러시아             경제개발  year -8.582112e-03 0.006589147
2   러시아 군비통제 및 군비해제  year -7.179911e-03 0.005107293
3   러시아             식민주의  year  4.130869e-03 0.001649635
4   러시아                 인권  year  8.740788e-03 0.005003575
5   러시아      팔레스타인 갈등  year -3.312180e-03 0.001321534
6   러시아      핵무기와 핵물질  year  3.299022e-03 0.006195691
7     미국             경제개발  year  1.271357e-02 0.006199419
8     미국 군비통제 및 군비해제  year  9.286682e-03 0.005675220
9     미국             식민주의  year  0.000000e+00 0.000000000
10    미국                 인권  year -8.100447e-03 0.004715947
11    미국      팔레스타인 갈등  year -2.828305e-03 0.001949871
12    미국      핵무기와 핵물질  year -1.581633e-03 0.006743102
13    일본             경제개발  year -8.116824e-03 0.008238900
14    일본 군비통제 및 군비해제  year  9.672187e-03 0.003838705
15    일본             식민주의  year -2.799700e-03 0.001699037
16    일본                 인권  year -7.941423e-03 0.005971467
17    일본      팔레스타인 갈등  year -3.681101e-03 0.001599665
18    일본      핵무기와 핵물질  year  3.389408e-03 0.004638515
19    중국             경제개발  year -4.050235e-03 0.004393514
20    중국 군비통제 및 군비해제  year -2.199341e-03 0.004426557
21    중국             식민주의  year -3.338160e-17 0.002135042
22    중국                 인권  year  9.123346e-03 0.004090882
23    중국      팔레스타인 갈등  year -1.234842e-03 0.001594193
24    중국      핵무기와 핵물질  year -6.145878e-03 0.004824861
25    한국             경제개발  year -9.727019e-03 0.007478156
26    한국 군비통제 및 군비해제  year  5.870564e-03 0.004786146
27    한국             식민주의  year  4.020979e-03 0.002165869
28    한국                 인권  year -1.004049e-02 0.005184953
29    한국      팔레스타인 갈등  year -1.259593e-02 0.002538006
30    한국      핵무기와 핵물질  year -4.176954e-03 0.005375599
# ... with 2 more variables: statistic <dbl>, p.value <dbl>

~~~



~~~{.output}
# A tibble: 1 × 7
  country           topic  term    estimate   std.error statistic
    <chr>           <chr> <chr>       <dbl>       <dbl>     <dbl>
1    한국 팔레스타인 갈등  year -0.01259593 0.002538006 -4.962923
# ... with 1 more variables: p.value <dbl>

~~~
