---
layout: page
title: R 파이썬 클라우드
subtitle: RStudio IDE와 Shiny 서버 설치
---
> ## 학습 목표 {.objectives}
>
> *   SoftLayer API를 사용해서 가상 컴퓨터를 주문한다.
> *   Shiny 앱 개발을 위한 RStudio를 설치한다.
> *   데이터 과학 응용프로그램 운영 Shiny 서버를 설치한다.


### 1. 클라우드 API 맛보기

SoftLayer API를 사용해서 계정(Account) 주소정보 중 도시를 읽어오는 프로그램을 작성해보자.
먼저, 소프트레이어 계정정보에 악의적인 사용을 막기위해서 계정정보 `API Access Information` 아래 `Allowed IPs`를 `ifconfig` 명령을 통해서 등록한다. 다음 소프트레이어 API 문서를 참고해서 다음과 같이 파이썬 코드를 작성하고 실행한다.

~~~ {.python}
# SoftLayer API를 사용해서 계정(Account) 주소정보 중 도시를 읽어오는 프로그램
import SoftLayer
client = SoftLayer.create_client_from_env(username="SLXXXXXX", api_key="7c769b8...")
resp = client['Account'].getObject()
print 'Account city info : ', resp['city']
~~~

먼저 `SoftLayer` 모듈을 가져오고, `client` 객체를 생성하고, `getObject()` 메쏘드를 통해서 resp에 `Account` 계정정보를 가져오고, 계정정보 중 도시정보를 다음과 같이 출력한다. 

~~~ {.output}
root@shiny:~# python python-start.py
Account city info :  Seoul
~~~

> ### 웹 API {.callout}
>
> 웹 응용프로그램 인터페이스(API, Application Programming Interface)는 웹 애플리케이션 개발에서 다른 서비스에 요청을 보내고 응답을 받기 위해 정의된 명세를 일컫는다. 
> 예를 들어 블로그 API를 이용하면 블로그에 접속하지 않고도 다른 방법으로 글을 올릴 수 있다. 
> 그 외에 우체국의 우편번호 api, 구글과 네이버의 지도 api등 유용한 api들이 많으므로, 
> 요즘은 홈페이지 구축이나 추가개편 시 따로 추가로 개발하지 않고도로 이런 오픈 api를 가져와 사용하는 추세이다.
> 출처: [위키피디아 API](http://ko.wikipedia.org/wiki/API) 

### 2. 데이터 과학 응용프로그램 개발 가상 컴퓨터 주문

데이터 과학 응용프로그램 개발을 위한 가상 컴퓨터를 파이썬 프로그램을 작성해서 주문한다. 컴퓨터 호스트 이름은 `shiny-sl`이고 프로세서는 1개, 주기억장치는 1GB, 보조기억장치는 25GB를 달러스 데이터센터에 우분투 최신 버젼 OS를 가지고 비용절감을 위해서 공용으로 주문한다.

|   구성항목     |  명칭           |  선택 사양   |
| -------------|:----------------|:-------------|
| 호스명        |  hostname       |  shiny-sl     |
| 도메인명       |  domain         |  xwmooc.net  |
| 데이터센터     |  datacenter     |  dal09       |
| 프로세서갯수   |  cpu            |  1           |
| 주기억장치    |  memory         |  1024        |
| 운영체제      |  os             |  UBUNTU_LASTEST|
| 보조기억장치  |  disk           |  25          |
| 공용/전용     |  public/private |  public      | 
| 요금 청구단위 |  billing        |  hourly     |

~~~ {.python}
import SoftLayer
client = SoftLayer.create_client_from_env(username="SLXXXXXX", api_key="7c7xxxxxxxxxxxxxxxxxxxxxxxxx")

shiny_object = client['Virtual_Guest'].createObject({
    'hostname': 'shiny-sl',
    'domain': 'xwmooc.net',
    'startCpus': 1,
    'maxMemory': 1024,
    'hourlyBillingFlag': 'true',
    'operatingSystemReferenceCode': 'UBUNTU_LATEST',
    'localDiskFlag': 'true'
    'datacenter': {"name": 'dal09'},
    'local_disk': 25
})

for key, value in shiny_object.iteritems():
    print key, " : ", value
~~~

~~~ {.output}
root@shiny:~# python shiny-create.py
domain  :  xwmooc.net
maxMemory  :  1024
uuid  :  ed82caeb-xxxxxxx
maxCpu  :  1
metricPollDate  :
createDate  :  2015-05-22T01:36:51-06:00
hostname  :  shiny-sl
startCpus  :  1
lastPowerStateId  :
lastVerifiedDate  :
statusId  :  1001
globalIdentifier  :  a24e018e-xxxxxxxx
provisionDate  :
maxCpuUnits  :  CORE
modifyDate  :
accountId  :  xxxxxxx
id  :  xxxxxxxxx
fullyQualifiedDomainName  :  shiny-sl.xwmooc.net
~~~

#### 2.1. 주문한 가상 컴퓨터 생성 확인

`slcli vs list` 명령어를 통해서 새로운 가상 컴퓨터 `shiny-sl`이 생성된 것을 확인할 수 있다.

~~~ {.input}
root@shiny:~# slcli vs list
:.........:..........:.................:................:............:........:
:    id   : hostname :    primary_ip   :   backend_ip   : datacenter : action :
:.........:..........:.................:................:............:........:
: 9535091 : shiny-sl :  169.53.232.11  : 10.121.217.205 :   dal09    :   -    :
:.........:..........:.................:................:............:........:
~~~

#### 2.2.주문한 가상 컴퓨터 삭제

파이썬 프로그램으로 가상컴퓨터를 간단히 삭제할 수 있다.
삭제하는 방법은 `id`를 `cancel_instance()` 메쏘드에 인자로 넣어주면 끝이다.

~~~ {.python}
import SoftLayer
client = SoftLayer.create_client_from_env(username="SLXXXXXX", api_key="7c7xxxxxxxxxxxxxxxxxxxxxxxxx")

mgr = SoftLayer.VSManager(client)
mgr.cancel_instance(9535091)
~~~

주문한 `shiny-sl` 컴퓨터를 주문취소하여 진행되는 과정이 보여지고 있다. 

~~~ {.output}
root@shiny:~# slcli vs list
:.........:..........:.................:................:............:.....................:
:    id   : hostname :    primary_ip   :   backend_ip   : datacenter :        action       :
:.........:..........:.................:................:............:.....................:
: 9535091 : shiny-sl :  169.53.232.11  : 10.121.217.205 :   dal09    : Cloud ISO Tear Down :
:.........:..........:.................:................:............:.....................:
~~~


> ## REST {.callout}
> 
> REST(Representational State Transfer)는 월드 와이드 웹과 같은 분산 하이퍼미디어 시스템을 위한 소프트웨어 아키텍처의 한 형식이다. 
> 이 용어는 로이 필딩(Roy Fielding)의 2000년 박사학위 논문에서 소개되었다. 필딩은 HTTP의 주요 저자 중 한 사람이다. 이 개념은 네트워킹 문화에 널리 퍼졌다.
> 엄격한 의미로 REST는 네트워크 아키텍처 원리의 모음이다. 여기서 '네트워크 아키텍처 원리'란 자원을 정의하고 자원에 대한 주소를 지정하는 방법 전반을 일컫는다. 간단한 의미로는, 웹 상의 자료를 HTTP위에서 SOAP이나 쿠키를 통한 세션 트랙킹 같은 별도의 전송 계층 없이 전송하기 위한 아주 간단한 인터페이스를 말한다. 이 두 가지의 의미는 겹치는 부분과 충돌되는 부분이 있다. 필딩의 REST 아키텍처 형식을 따르면 HTTP나 WWW이 아닌 아주 커다란 소프트웨어 시스템을 설계하는 것도 가능하다. 또한, 리모트 프로시저 콜 대신에 간단한 XML과 HTTP 인터페이스를 이용해 설계하는 것도 가능하다.
> 필딩의 REST 원리를 따르는 시스템은 종종 RESTful이란 용어로 지칭된다. 열정적인 REST 옹호자들은 스스로를 RESTafrians 이라고 부른다.
>  
> 출처: 위키피디아 REST [http://ko.wikipedia.org/wiki/REST](http://ko.wikipedia.org/wiki/REST)

SoftLayer REST에 대한 자세한 사항은 [http://sldn.softlayer.com/article/rest](http://sldn.softlayer.com/article/rest) 기사를 참조한다.

~~~ {.output}
root@shiny:~# curl -s https://SLXXX:API-KEY@api.softlayer.com/rest/v3/SoftLayer_Account.json | pyt
hon -m json.tool
{
    "accountManagedResourcesFlag": false,
    "accountStatusId": 1XXX,
    "address1": "XXXXX",
    "allowedPptpVpnQuantity": X,
    "brandId": XX,
    "city": "XXXX",
    "claimedTaxExemptTxFlag": false,
    "companyName": "xwMOOC",
    "country": "KR",
    "createDate": "xxx",
    "email": "xxxxxx@gmail.com",
    "firstName": "xxxxx",
    "id": xxxxxx,
    "isReseller": 0,
    "lastName": "Lee",
    "lateFeeProtectionFlag": null,
    "modifyDate": "2014-11-11T17:55:18-06:00",
    "officePhone": "XXXXXXXXX",
    "postalCode": "XXX",
    "state": "OT",
    "statusDate": null
}
~~~

![클라우드 가상 컴퓨터 위에 Shiny 웹서버와 RStudio IDE 설치](fig/shiny-install-overview.png)

### 3. Shiny 서버 설치

#### 3.1. 가상 컴퓨터 사양 확인 

`Shiny R`을 설치하기에 앞서 클라우드 데이터 과학 분석을 위한 가상 컴퓨터를 살펴보자.
데이터 과학용 클라우드 가상 컴퓨터가 준비되었으면 `ssh root@169.53.232.11`를 이용해서 `lshw` 명령어를 통해서 하드웨어 기본 사양을 확인한다.

~~~ {.input}
$ ssh root@169.53.232.11
Password:
Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-51-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.

root@shiny-sl:~#
~~~

~~~ {.input}
root@shiny-sl:~# lshw
shiny-sl
    description: Computer
    width: 64 bits
    capabilities: vsyscall32
  *-core
       description: Motherboard
       physical id: 0
     *-memory
          description: System memory
          physical id: 0
          size: 989MiB
     *-cpu
          product: Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
          vendor: Intel Corp.
          physical id: 1
          bus info: cpu@0
          width: 64 bits
... 중략...
     *-network:1
       description: Ethernet interface
       physical id: 2
       logical name: eth1
       serial: 06:2c:2b:b1:43:ed
       capabilities: ethernet physical
       configuration: broadcast=yes driver=vif ip=169.53.232.9 link=yes multicast=yes
~~~

하드웨어 사양을 확인했으니, 운영체제 사양도 확인한다. 우분투의 경우 `lsb_release -a` 명령어를 콘솔에 타이핑하면 된다.

~~~ {.input}
root@shiny-sl:~# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 14.04.2 LTS
Release:        14.04
Codename:       trusty
~~~

#### 3.2. `Shiny` 서버 설치 

기본적으로 `R` 라이선스가 `GPL`을 따르기 때문에 `Shiny` 서버도 동일한 라이선스를 따르니 리눅스를 이용하는 기분으로 소프트웨어를 사용한다.
이제 Shiny 서버를 클라우드에 구축하기 위해서 Shiny 서버를 다운로드하여 설치한다.
우분투 기준 `Shiny Server v1.3.0.403` 버젼 기준으로 설치해 나간다. 자세한 내용은 영어 설치페이지[http://www.rstudio.com/products/shiny/download-server/](http://www.rstudio.com/products/shiny/download-server/)를 참조한다.

운영체제 버젼 확인 결과 우분투 14.04 버젼으로 Rstudio 에서 설치시 권장하는 우분투 12.04보다 상위버젼으로 바로 `R`부터 설치를 진행해 나갈 수 있다.
`r-base`를 설치하고 난 다음에는 `Shiny 서버`를 설치하기 전에 `Shiny R` 팩키지를 설치해야한다. 물론 `R`로 들어가서 
`install.packages('shiny', repos='http://cran.rstudio.com/')`를 해서 `shiny` 팩키지를 설치해도 된다. 

~~~ {.input}
root@shiny-sl:~# sudo apt-get install r-base
root@shiny-sl:~# $ sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""
~~~

`R`과 `Shiny` 패키지를 설치한 다음에 **gdebi**를 다음에 설치해야 한다. 그리고 나서 `gdebi`를 통해서 `Shiny 서버`를 설치할 수 있다.

`wget`을 통해서 `Shiny 서버` 설치 파일을 다운로드받고, `gdebi`를 통해서 `Shiny 서버`를 설치한다.

~~~ {.input}
root@shiny-sl:~# sudo apt-get install gdebi-core
root@shiny-sl:~# wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb
root@shiny-sl:~# sudo gdebi shiny-server-1.3.0.403-amd64.deb
~~~

`Shiny 서버`가 잘 실행되고 있는지 `status shiny-server` 명령어를 통해서 확인해보고, 만약 서비스가 시작되지 않았다면, `sudo start shiny-server` 명령어로 실행시킨다. 

~~~ {.input}
root@shiny-sl:~# status shiny-server
shiny-server start/running, process 14553

root@shiny-sl:~# sudo start shiny-server
start: Job is already running: shiny-server
~~~

이제 웹브라우져를 열고 **포트번호(port, 3838)**를 뒤에 `:3838`을 붙여 `http://169.53.232.11:3838/`와 같이 입력하면 
브라우져 상단에 다음과 같은 메시지가 출력되면 설치가 완료되고 사용준비가 완료된 것이다.

![Shiny 서버 설치 화면](fig/shiny-install.png)

첫 설치 페이지 우측 하단에 `rmarkdown` 설치가 되지 않아 생기는 오류사항은 `R`에서 `install.packages("rmarkdown")`를 통해서 `rmarkdown` 팩키지를 설치해서 해결할 수 있고 다음과 같은 메시지가 보이면 설치가 모두 완료된 것이다.

~~~ {.output}
With Shiny and `rmarkdown` installed, you should see a Shiny doc above.
~~~

#### 3.3. `shinyapp.io` 공용 Shiny 서버 설정

`Tools` --> `ShinyApps` --> `Manage Accounts...`를 통해 RStudio에서 바로 [https://www.shinyapps.io/](https://www.shinyapps.io/) 공용 Shiny 서버로 응용프로그램을 배포할 수 있다. 먼저 [https://www.shinyapps.io/](https://www.shinyapps.io/) 웹사이트에 접속해서 계정을 생성한다. 

[https://www.shinyapps.io/](https://www.shinyapps.io/) 웹사이트에 로그인한 뒤에 사용자명(우측상단)을 클릭하고 **Tokens**를 클릭하면 토큰과 비밀키 정보가 함께 볼 수 있다. 

~~~ {.output}
shinyapps::setAccountInfo(name='xwmooc',
        token='C9CXXXXXXXXXXXXXXXXXXXXX',
        secret='<SECRET>')
~~~

토큰 정보를 `Tools` --> `ShinyApps` --> `Manage Accounts...`에 등록한다.

![RStudio IDE에서 shinyapp.io에 바로 연결하기 위한 토근 환경설정](fig/shiny-shinyapp-io-configuration.png)

**주의:** Shiny 응용프로그램을 배포하기 위해서 `ui.R`, `server.R`로 응용프로그램이 나눠줘야 한다.

![RStudio IDE에서 shinyapp.io에 개발한 응용프로그램을 바로 배포(Publish App...)](fig/shiny-shinyapp-io-connect-menu.png)

### 4. `RStudio` 서버 설치

`Shiny 서버`를 설치한 다음에 `RStudio` 개발환경을 설치한다.
`gdebi`는 `Shiny 서버` 소프트웨어를 설치할 때 설치했기 때문에 바로 최신 버전을 `wget`을 통해 다운로드하고 나서 설치한다.

~~~ {.input}
root@shiny-sl:~# wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
~~~

~~~ {.output}
--2015-05-22 03:42:29--  http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
Resolving download2.rstudio.org (download2.rstudio.org)... 54.192.7.233, 54.230.4.176, 54.230.5.20,
...
Connecting to download2.rstudio.org (download2.rstudio.org)|54.192.7.233|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 36304754 (35M) [application/x-deb]
Saving to: 'rstudio-server-0.98.1103-amd64.deb'

100%[==========================================================>] 36,304,754  19.5MB/s   in 1.8s

2015-05-22 03:42:31 (19.5 MB/s) - 'rstudio-server-0.98.1103-amd64.deb' saved [36304754/36304754]
~~~

~~~ {.input}
root@shiny-sl:~# sudo gdebi rstudio-server-0.98.1103-amd64.deb
~~~

### 4.1 `RStudio` IDE 접속

이제 웹브라우져를 열고 **포트번호(port, 8787)**를 뒤에 `:8787`을 붙여 `http://169.53.232.11:8787/`와 같이 입력하면 
`Sign in to RStudio` 화면에 사용자명(`username:`)과 비밀번호(`Password:`)를 넣고 `Sign In`하라고 한다.
절대 `root`권한을 가지고 로그인하면 들어가지 않는다. `root`권한을 가지고 사용자를 추가한 후에 추가된 사용자명을 가지고 로그인한다.
[useradd](http://linux.die.net/man/8/useradd)를 통해서 사용자 추가를 추가하고, [userdel](http://linux.die.net/man/8/userdel)을 통해서 사용자를 삭제한다. `adduser` 혹은 `useradd` 동일한 명령어다. `xwmooc` 사용자를 `sudo useradd -m xwmooc` 혹은 `sudo adduser -m xwmooc`
명령어로 설정했으니, 다음올 비밀번호를 설정한다. `sudo passwd xwmooc` 비밀번호를 두번 입력하게 되면 설정이 완료되었다.  
  
**주의**: `sudo useradd -m xwmooc` 명령어에서 `-m` 옵션 플래그는 홈디렉토리를 생성하게 만든다. 그래야지만 정상적으로 `RStudio` 작업이 가능하다.

~~~ {.input}
root@shiny-sl:~# sudo useradd -m xwmooc
root@shiny-sl:~# sudo adduser -m xwmooc
adduser: The user `xwmooc' already exists.
root@shiny-sl:~# sudo passwd xwmooc
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
root@shiny-sl:~#
~~~

이제 `RStudio`를 사용하기 위해서 `http://169.53.232.11:8787/` 사이트에서 사용자명 `xwmooc`를 넣고 비밀번호를 입력하게 되면 `RStudio`를 사용할 수 있게 된다.

![RStudio IDE 서버 설치 화면](fig/shiny-rstudio-install.png)
