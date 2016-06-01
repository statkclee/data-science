---
layout: page
title: 데이터 과학
subtitle: 두언어 문제
---

> ## 학습 목표 {.objectives}
>
> * 두 언어 문제에 대해 이해한다.
> * 사용자와 개발자를 나누는 사회적 장벽을 이해한다.


<iframe width="320" height="200" src="https://www.youtube.com/embed/B9moDuSYzGo" frameborder="0" allowfullscreen></iframe>

[^Ousterhout-dichotomy]: [Ousterhout's dichotomy](https://en.wikipedia.org/wiki/Ousterhout%27s_dichotomy)

### 두 언어 문제 [^Ousterhout-dichotomy]

[ODSC East 2016 - Stefan Karpinski - "Solving the Two Language Problem"](https://www.youtube.com/watch?v=B9moDuSYzGo)

| 시스템 언어  | Ousterhout 이분법  | 스크립트 언어  |
|-------------|-------------|-------------|
|   정적       |     --      |     동적     |
|   컴파일      |     --      |    인터프리터 |
| 사용자정의 자료형|     --      |  표준 자료형 |
|   빠른 속도   |     --      |   늦은 속도   |
|   어려움       |     --      |   쉬움     |

두 언어 문제로 인해 편리함을 위해 파이썬, R, Matlab을 사용하고 C/C++, 포트란 시스템 언어로 모든 힘든 작업을 수행한다.
시스템 언어와 스크립트 언어의 두가지 문제점을 해결하기 위해서 두가지 다른 언어의 장점을 취하고 이를 보완하려는 노력이 지속적으로 경주되고 있다.

<img src="fig/data-scientist-languages.png" alt="데이터 과학자 언어" width="50%">

과거 데이터 과학자가 선형대수, 통계&시각화, 속도, 통합작업과 관련하여 다양한 언어와 도구를 익혀야 했지만,
2010년 중반을 넘어서는 현시점에서 파이썬과 R을 함께 사용하는 것으로 중지가 모아지고 있다.