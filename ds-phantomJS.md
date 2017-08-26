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

### 1.2. R 팬텀JS 테스트 {#phantomJS-test-on-R}

윈도우 쉘환경에서 팬텀JS가 정상적으로 설치된 것이 확인되면 다음 단계로 운영체제에 맞는 `system`, `system2`, `shell` 등의 명령어로 
R 환경에서 쉘명령을 직접 실행해본다.


~~~{.r}
> system("phantomjs --version")
2.1.1
~~~
