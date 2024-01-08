---
layout: page
title: 데이터 과학
subtitle: 위기의 스프레드쉬트
---

> ## 학습 목표 {.objectives}
>
> * 왜 스프레드쉬트가 위기인지 이해한다.


### 1. 스프레드쉬트를 버려야 하는 6가지 이유 [^stop-excel]

엑셀은 작은 데이터를 가지고 임의 분석과 계산을 하는데 최적화 되었지만, 데이터베이스 기능으로 사용하는 것은 자제하여야 한다.
아주 많은 기업이나 조직에서 마이크로소프트 엑셀 스프레드쉬트에 매우 중요한 데이터로 보관하고 작업을 해서,
사소한 실수로 중요한 의사결정이 왜곡되는 위험에 처해 있다.

> #### 스프레드쉬트를 사용하는 이유 {.callout}
> 
> * 항상 엑셀을 사용했다: 항상 데이터를 엑셀로 저장하고 분석해서 사용했다. 하지만, 버튼 하나로 데이터를 내보내기 쉽다.
> * 데이터베이스를 사용할 만큼 데이터가 충분하지 않다: 데이터가 작아서 데이터베이스를 사용할 이유를 찾지 못하지만,
사업이 커지고, 업무량이 늘어나면서 엑셀 작업량이 높아지고, 복잡성도 커지고, 엑셀 자체에서 처리되는 시간도 늘어난다.

#### 1.1. 한번에 한사람만 작업이 가능하다.

해당 시간에 한번만 엑셀로 작업이 가능하다. 만약 다른 직원이 엑셀을 열어 작업을 하게 되면 "읽기 전용(Read-Only)"으로만 볼 수만 있다.

#### 1.2. 데이터 감사는 데이터베이스에서만 가능

보통 한 사람만 엑셀 스프레드쉬트 파일을 생성하고 유지보수한다. 이 직원이 다른 부서로 전보되거나 회사를 떠나게 되면, 모든 지식이 직원과 함께 날아간다.
고로, 해당 업무를 담고 있는 엑셀 스프레드쉬트를 익히는데 수개월이 소요된다.

이와 비교하여 감사 기능이 제공되는 데이터베이스는 주기적으로 사용자 활동을 기록해서 엑셀 스프레드쉬트가 담고 있는 정보 및 직관도 전달한다.

#### 1.3. 데이터베이스는 정형화된 작업흐름을 지원한다.

업무 프로세스를 엑셀 스프레드쉬트로 정의할 경우, 엑셀 스프레드쉬트 파일을 전자우편으로 다수 개발자, 검토자, 승인자에게 셀 수 없이 많이 전달해야 한다.
더 큰 문제는 이를 취합해서 수작업으로 정리해야 된다.

하지만, 업무 프로세스를 데이터베이스로 정의할 경우, 특정 사업 요구사항을 해결하는데 작업을 매핑하고, 추적하고 관리하기 편하다.
효과적으로 중앙에서 체계적으로 관리되는 스프레드쉬트, 데이터베이스로 할당된 작업에 대응하기 좋다.

#### 1.4. 데이터베이스는 엑셀보다 모형을 보다 잘 지원한다.

엑셀 스프레드쉬트 업무가 늘어나고 크기가 커지게 되면, 오류에 취약해 진다.
예를 들어, 새로운 수식을 새로운 곳에 복사해서 넣게 되면 셀참조가 엉클어져서 엉뚱한 값이 반영되는 경우도 흔히 발견된다.

#### 1.5. 데이터베이스로 보고서 생성이 수월하다.

데이터베이스에서 쿼리, 쿼리에 기반한 보고서를 작성하기 더 쉽다.
정적 스프레드쉬트와 반대로 관계형 환경에서 데이터를 정렬, 매칭, 조합하기 더 좋다.

#### 1.6.  데이터베이스는 보안이 강력하고 규제하기 좋다.

스프레드쉬트는 규제를 가하고 보안기능을 두기가 마땅치 않는다. 보안과 제한 기능은 완전히 사용자 몫으로 남겨진다.
엑셀 사용자가 수작업으로 모든 것을 식별해서 작업해야 되고 실수한 것도 고쳐야 된다.
스프레드쉬트에 이러한 기능이 거의 전무하기 때문에, 실수한 것도 알아차리지 못한 상태로 그냥 넘어가는 경우가 상당히 많다.

### 2. 스프레드쉬트 참사 [^excel-disaster]

|     회사      | 참사 비용 |   발생일 |        영향           |               참사 개요                         | 
|---------------|-----------|----------|-----------------------|-------------------------------------------------|
| 옥스포드 대학 | 미확인    | '11.12월 | 학생 인터뷰 일정 지연 | 엑셀이 수식이 꼬여 인터뷰 일정이 뒤죽박죽 [^12] |
|      MI5      | 미확인    |   '11년  | 잘못된 전화번호 작업  | 엑셀 서식 수식이 꼬여 엉뚱한 전화번호 작업 [^11] |
| '12년 런던 올림픽 | £ 0.5백만  |  '12.01월  | 티켓 환불 소동  | 수영장 10,000 티켓이 초과 판매 (엑셀 입력 오류) [^10] |
|     Mouchel   |  £ 4.3백만  |  '10.11월  | CEO 사임, 주가폭락 | 연금펀드평가 £ 4.3백만 엑셀 오류 [^09] |
|   C&C Group   |  £ 9 백만  |  '09.7월  | 주가 15% 하락 등 | 매출 3% 상승이 아니고 5% 하락, 엑셀 오류 [^08] |
|   UK 교통부   | 최소 £ 50 백만 |  '12.10월  | 영국민 추가 세금 부담 | 영국 철도 입찰 오류 [^07] |
|   King 펀드   | £ 130 백만 |  '11.05월  | 브래드 이미지 하락 | 웨일즈 지방 NHS 지출 엑셀 오류 [^06] |
| AXA Rosenberg | £ 150 백만 |  '11.02월  | 은폐, 벌금, 브래드 이미지 하락 | 엑셀 오류를 감춰서 $242 백만 벌금 |
| JP Morgan Chase | £ 250 백만 |  '13.01월  | 명성, 고객 신뢰도 저하 | 바젤 II VaR 위험 평가 엑셀 오류 [^04] |
| Fidelity Magellan 펀드 | £ 1.6 십억 |  '95.01월  | 투자자에게 약속한 배당금 지급 못함 | 음수 부호 누락으로 자본이득 과대계상 [^03] |
| 미연방준비위원회 | £ 2.5 십억 |  '10.10월  | 명확하지 않음 | 리볼빙 카드 신용액 산출 과정에 엑셀 오류 [^02] |
|  하버드 대학  | 평가 불능 | '13.04월  | 유럽 정부 긴축예산 편성 근거 | GDP 대비 정부 부채 영향도 분석 엑셀 오류 [^01] |



[^12]: [Test errors impede History applications](http://www.cherwell.org/2011/12/07/test-errors-impede-history-applications/)
[^11]: [MI5 makes 1,061 bugging errors](http://national-security.governmentcomputing.com/news/2011/jul/01/mi5-data-collection-errors)
[^10]: [London 2012 Olympics - lucky few to get 100m final tickets after synchronised swimming was overbooked by 10,000](http://www.telegraph.co.uk/sport/olympics/8992490/London-2012-Olympics-lucky-few-to-get-100m-final-tickets-after-synchronised-swimming-was-overbooked-by-10000.html)
[^09]: [Mouchel profits blow](http://www.express.co.uk/finance/city/276053/Mouchel-profits-blow)
[^08]: [C&C Group admit to mistake in revenue results](http://drinksdaily.com/2009/07/cc-group-admit-to-mistake-in-revenue-results/)
[^07]: [West Coast Main Line franchise fiasco 'to cost at least £50m'](http://www.bbc.com/news/uk-politics-21577826)
[^06]: [King’s Fund apologise for “error” in figures on health spending in Wales](http://leftfootforward.org/2011/05/kings-fund-apologise-for-error-on-health-spending-in-wales/)
[^04]: [Report of JPMorgan Chase & Co. Management Task Force Regarding 2012 CIO Losses](http://files.shareholder.com/downloads/ONE/2261602328x0x628656/4cb574a0-0bf5-4728-9582-625e4519b5ab/Task_Force_Report.pdf)
[^03]: [Computing error at Fidelity's Magellan fund](http://catless.ncl.ac.uk/Risks/16.72.html#subj1)
[^02]: [Blatant Data Error At The Federal Reserve](http://www.zerohedge.com/article/blatant-data-error-federal-reserve)
[^01]: [Is the evidence for austerity based on an Excel spreadsheet error?](https://www.washingtonpost.com/news/wonk/wp/2013/04/16/is-the-best-evidence-for-austerity-based-on-an-excel-spreadsheet-error/)



[^excel-disaster]: [THE DIRTY DOZEN 12 MODELLING HORROR STORIES & SPREADSHEET DISASTERS](http://blogs.mazars.com/the-model-auditor/files/2014/01/12-Modelling-Horror-Stories-and-Spreadsheet-Disasters-Mazars-UK.pdf)

[^stop-excel]: [6 Reasons It’s Time To Stop Using Excel As A Database](http://venasolutions.com/blog/2014/08/6-reasons-its-time-to-stop-using-excel-as-a-database/)