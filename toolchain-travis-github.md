---
layout: page
title: 데이터 과학
subtitle: 지속적 통합(CI) - GitHub
---
> ## 학습 목표 {.objectives}
>
> *  GitHub과 트래비스를 연결한다.

### GitHub 토근 생성

1. 우측상단 사용자를 클릭해서 `Settings` &#8594; 좌측 `Personal settings` 메뉴에서 
`Personal access tokens`을 선택하고 **Generate new token**을 클릭해서 신규 명칭을 부여하고 복사해서 사용한다. **주의:** 토큰은 한번만 볼 수 있고, 다시볼려면 다시 생성하든지 해야 한다.

2. `gem install travis` 명령어로 트래비스 명령-라인 인터페이스(CLI)를 설치하고 나서, `travis login` 명령어를 통해 로그인한다. `travis encrypt -r` 명령어로 GitHub 저장소를 지정하고 `GH_TOKEN`에 GitHub에서 생성한 토근을 사용한다. [http://travis-encrypt.github.io/](http://travis-encrypt.github.io/) 웹사이트에서도 동일하게 진행할 수 있다. `--org`는 `travis login`에 사설(`--pro`)이 아니고 공용 계정으로 로그인함을 지정한다. **주의:** `ruby` 1.9.X 버젼에서는 설치가 되지 않을 수도 있으니 최신 루비 버젼으로 업그레이드 한다. 

~~~ {.input}
root@csunplugged:~# gem install travis
root@csunplugged:~# travis login
root@csunplugged:~# travis encrypt -r statkclee/swc-travis GH_TOKEN=6a50cecd7327db*************** --org
~~~


~~~ {.output}
  secure:"Ui9WbONLJG1Q5LwgogG68LKekQq9uH+xRIIbyO+8A+5bh3qkY0UqhKNyr+RNgb0MdrWwOJqROTqTb4aQNvCBQtCRezve+UVk1Oh/WNVp66eh7Sfu63nwQKC+l1FJGnmgPRONbXe/+9i7ZFhbQO+dTZa23W+9KC2YovnpSNKvj7c+oZPcV5zdpV/WCpSe4yJkiLML2JtYNTr15BsQ0mZu5zjgIKtYgOlrdp0tVubaOUmgyMm//J5B7SlABoOyaYI32stwHcq4R2bLlzkjzvkcwCXwzBtT3E76qFIgdvmyit2mDNB9yrEVmP3KwUqUoYywzr5lIc4J+xSDJ1pancbKEb9WRu7sR1FciNliZA74+HUQvlr3JufPtZo3ApULfwp32lfPOiNPSuNGnjrC2W5e+XkLedeYofbWhfcxr79yRpQ5ljAfEbSellBbU61Pfzv7mLP2B3rPKCSRAdhBiK4VBd/27cmjpso7n4v8QEjQRD56Upyu1laMOF3xijgMwBGEeGCIVMOANOP0Ud05X5y/4LHDM6qxXKMKovYfGJ/vd4f8+2CPcF4E9/Dgc72sWCc2CO1QFpc1RURByAaaPI934S/j3w8Pi30o+Tmfs="
~~~

