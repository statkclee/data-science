---
layout: page
title: <eb>°<ec>´<ed>„° ê³¼í•™
subtitle: ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™” - ì£¼ì†Œ<ec><99>€ <ec>œ„<eb>„ê²½ë„
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## <ed>•™<ec>Šµ ëª©í‘œ {.objectives}
>
> *  <ed>•œêµ<ad> ì£¼ì†Œëª…ì„ ì§€ë¦¬ì •ë³<b4>(<ec>œ„<eb>„, ê²½ë„)ë¡<9c> ë³€<ed>™˜<ed>•œ<eb>‹¤. [^geoCodingWithR]
> * `dplyr` <ed>Œ©<ed>‚¤ì§€ `mutate_geocode` <ec>œ„<eb>„ê²½ë„ <ed>•¨<ec>ˆ˜ë¥<bc> <ed>ŒŒ<ec>´<ed>”„<ec>—°<ec>‚°<ec>ž<ec><99>€ ê²°í•©<ed>•˜<ec>—¬ ì½”ë“œë¥<bc> ê°„ê²°<ed>™”<ed>•œ<eb>‹¤. 

### 1. ì§€ë¦¬ì •ë³<b4> API - `geocode` 

<eb>°<ec>´<ed>„°ë¥<bc> ì§€ë¦¬ì •ë³´ì<99>€ ê²°í•©<ed>•˜<ec>—¬ <ec> œê³µí•  ê²½ìš° <ed>˜„<ec>ƒ<ec>— <eb><8c>€<ed>•œ <ec>´<ed>•´, <ec>˜ˆì¸<a1>, <ed>†µì°°ë ¥<ec>„ <ec>–»<ec>„ <ec>ˆ˜ <ec>žˆ<eb>‹¤.
<eb>°<ec>´<ed>„°ë¥<bc> ì§€ë¦¬ì •ë³´ì<99>€ ê²°í•©<ed>•  <eb>•Œ, ê°€<ec>ž¥ <ed>•„<ec>š”<ed>•œ ê²ƒì´ ì£¼ì†Œ<ec> •ë³´ì— <ec>œ„<eb>„<ec><99>€ ê²½ë„ <ec> •ë³´ë<a5><bc> ë¶™ì—¬ ì§€<eb>„<ec>— <ed>‘œ<ec>‹œ<ed>•˜ê²<8c> <eb>œ<eb>‹¤.

ì£¼ì†Œ<ec> •ë³´ê<b0>€ <ec> œê³µë˜<ec>—ˆ<ec>„ <eb>•Œ, <ec>´<ec>— <ed>•´<eb>‹¹<eb>˜<eb>Š” <ec>œ„<eb>„<ec><99>€ ê²½ë„ë¥<bc> ë¶ˆëŸ¬<ec>˜¬ <eb>•Œ <ec>‚¬<ec>š©<ed>•˜<eb>Š” ê²ƒì´ <ed>•¨<ec>ˆ˜<ec>˜ <ec>¼ì¢…ì¸ API<eb>‹¤.
<ec>œ„ê²½ë„ <ec> •ë³´ë<a5><bc> <ec> œê³µí•˜<eb>Š” <ec>—…ì²´ë¡œ êµ¬ê<b8>€, <eb>„¤<ec>´ë²<84>, <eb>‹¤<ec>Œ <eb>“± <ec>—¬<eb>Ÿ¬ <ec>—…ì²´ê<b0>€ <ec>žˆ<eb>‹¤.

R<ec>—<ec>„œ êµ¬ê<b8>€, <eb>„¤<ec>´ë²<84>, <eb>‹¤<ec>Œ<eb>“±<ec>—<ec>„œ <ec> œê³µí•˜<eb>Š” ì§€ë¦¬ì •ë³<b4> APIë¥<bc> <ed>™œ<ec>š©<ed>•  ê²½ìš°, <ed>¬ê²<8c> <eb>‘ê°€ì§€ ë°©ë²•<ec>´ ì¡´ìž¬<ed>•œ<eb>‹¤. 
<ed>•˜<eb>‚˜<eb>Š” ì§ì ‘ êµ¬ê<b8>€, <eb>„¤<ec>´ë²<84>, <eb>‹¤<ec>Œ ì§€ë¦¬ì •ë³<b4> API ë¬¸ì„œë¥<bc> <ec>½ê³<a0> Rì½”ë“œë¡<9c> <ec>ž‘<ec>„±<ed>•˜<eb>Š” ë°©ì‹<ec>´ <ec>žˆê³<a0>,
<eb>˜ <eb>‹¤ë¥<b8> <ed>•˜<eb>‚˜<eb>Š” `ggmap` <ed>Œ©<ed>‚¤ì§€<ec>—<ec>„œ <ec>´ë¯<b8> ì§€ë¦¬ì •ë³<b4> APIë¥<bc> <eb>‚´<ec>ž¬<ed>™”<ed>•´<ec>„œ <ed>•¨<ec>ˆ˜ë¡<9c> êµ¬í˜„<ed>•´ <eb>†“<ec><9d>€ ê²ƒì„ <ed>˜¸ì¶œí•´<ec>„œ <ec>‚¬<ec>š©<ed>•˜<eb>Š” ë°©ë²•<ec>´<eb>‹¤.

<ed>•œêµ<ad>ì£¼ì†Œë¥<bc> <ec> „<eb>‹¬<ed>•˜ë©<b4> <ec>œ„<eb>„, ê²½ë„ <ec> •ë³´ë<a5><bc> ë°˜í™˜<ed>•˜<eb>Š” APIë¡<9c> [êµ¬ê<b8>€ ì§€<eb>„ API](https://developers.google.com/maps/?hl=ko)ë¥<bc> ê¸°ë³¸<ec>œ¼ë¡<9c> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. 
`library(ggmap)` <ed>Œ©<ed>‚¤ì§€ë¥<bc> ë¶ˆëŸ¬<ec>˜¤ë©<b4> `geocode` <ed>•¨<ec>ˆ˜ê°€ ì£¼ì†Œëª…ì„ ë°›ì•„ <ec>œ„<eb>„, ê²½ë„ <ec> •ë³´ë<a5><bc> ë°˜í™˜<ed>•œ<eb>‹¤.
<ed>•˜ì§€ë§<8c>, Hadley Wickham<ec>´ ê´€<ec>—¬<ed>•œ <ed>Œ©<ed>‚¤ì§€<eb>Š” [<ec>¸ì½”ë”©](encoding.html)<ec>œ¼ë¡<9c> **utf-8**<ec>„ <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. 
<eb>”°<eb>¼<ec>„œ, <ed>•œêµ<ad><ec>–´<eb>Š” `enc2utf8` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>¸ì½”ë”©<ec>„ ë°”ê¿” <eb>„£<ec><9d>€ <ed>›„<ec>— `geocode` <ed>•¨<ec>ˆ˜<ec>— <ec>¸<ec>žë¡<9c> <eb>„£<ec>–´<ec>•¼ <ec>›<ed>•˜<eb>Š” <ec>œ„<eb>„ê²½ë„ <ec> •ë³´ë<a5><bc> ë°˜í™˜ë°›ì„ <ec>ˆ˜ <ec>žˆ<eb>‹¤. 

<img src="fig/geo-googleapi.png" alt="Google ì§€<eb>„ API" width="77%" />


~~~{.r}
library(ggmap)
library(ggplot2)
geocode(enc2utf8("<U+FFFD>ì´ˆ"), source='google')
~~~



~~~{.output}
FALSE Error: invalid multibyte character in parser at line 3

~~~

ì£¼ì†Œ<ec> •ë³´ë<a5><bc> <ed>•¨ê»<98> ì¶œë ¥<ed>•˜ê³ ìž<ed>•  ê²½ìš° `output="latlona"` <ec>„ <ed>ƒ<ec>˜µ<ec>…˜<ec>„ ì¶”ê<b0>€<ed>•œ<eb>‹¤.


~~~{.r}
#geocode(enc2utf8("<U+FFFD>ì´ˆ"), source='google', output="latlona")
geocode(enc2utf8("<U+FFFD>ì´ˆ&language=ko"), source='google', output="latlona")
~~~



~~~{.output}
FALSE Error: invalid multibyte character in parser at line 2

~~~
`"<ec>†ì´<88>"`ë¥<bc> `geocode` <ed>•¨<ec>ˆ˜ <ec>¸<ec>žë¡<9c> <eb>„£<ec><9d>€ ê²½ìš°<ec><99>€ `"<ec>†ì´<88>&language=ko"` <eb>„£<ec>–´ <ed>•¨ê»<98> <eb>„˜ê¸<b4> ê²½ìš° <ed>•œê¸€ì£¼ì†Œë¡<9c> ì¶œë ¥<eb>˜ê²<8c> <ed>•œ<eb>‹¤.


### 2. <ed>•œê°<9c> <ec>´<ec>ƒ ì£¼ì†Œ<ec> •ë³´ì—<ec>„œ <ec>œ„<eb>„ê²½ë„ <ec> •ë³<b4> ë½‘ì•„<eb>‚´ê¸<b0> 

êµ¬ê<b8>€ ì§€<eb>„ APIë¥<bc> <ec>‚¬<ec>š©<ed>•  ê²½ìš°, ë¬´ë£Œë¡<9c> <ec>´<ec>š©<ed>•  <ec>ˆ˜ <ec>žˆ<eb>Š” ë°˜ë©´<ec>— <ec>‚¬<ec>š©<ec>ž<ec>˜ <ec>˜¤<eb>‚¨<ec>š©<ec>„ ë°©ì<a7>€<ed>•˜ê¸<b0> <ec>œ„<ed>•´<ec>„œ <ec>–´<eb>Š API <ec>„œë¹„ìŠ¤<eb>„ ë§ˆì°¬ê°€ì§€ì§€ë§<8c>,
êµ¬ê<b8>€<ec>´<eb>‚˜ API <ec>„œë¹„ìŠ¤ <ec> œê³µìž <ec>ž„<ec>˜ë¡<9c> APIë¥<bc> ë³€ê²½í•  <ec>ˆ˜ <ec>žˆê³<a0>, <ec>‚¬<ec>š©<ec> œ<ed>•œ<ec>„ <eb>‘”<eb>‹¤.
<ed>˜„<ec>ž¬ ê¸€<ec>„ <ec>ž‘<ec>„±<ed>•˜<eb>Š” <ec>‹œ<ec> <ec>—<ec>„œ êµ¬ê<b8>€ ì§€<eb>„ API<ec>˜ ê²½ìš° <ec>¼<ec>¼ 2,500 ë²<88> ë¬´ë£Œë¡<9c> <ec>‚¬<ec>š©<ec>´ ê°€<eb>Š¥<ed>•˜<eb>‹¤.

`geocodeQueryCheck(userType = "free")` ëª…ë ¹<ec>–´ë¥<bc> <ec>‚¬<ec>š©<ed>•˜<ec>—¬ êµ¬ê<b8>€ ì§€<eb>„ API <ec>‚¬<ec>š©<eb>Ÿ‰<ec>„ <ed>™•<ec>¸<ed>•  <ec>ˆ˜ <ec>žˆ<eb>‹¤.


~~~{.r}
geocodeQueryCheck(userType = "free")
~~~



~~~{.output}
Error in eval(expr, envir, enclos): could not find function "geocodeQueryCheck"

~~~

ê²½ê¸°<eb>„ ë°<8f> ê°•ì›<eb>„ 3ê°<9c> ì§€<ec> <ec>— <eb><8c>€<ed>•œ <ec>œ„<eb>„ê²½ë„ <ec> •ë³´ë<a5><bc> ë°›ì•„<ec>˜¤<eb>Š” ê²½ìš°, ë¨¼ì<a0>€ <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„<ec>„ <ec>ƒ<ec>„±<ed>•˜ê³<a0> <eb>‚˜<ec>„œ,
`enc2utf8()` <ed>•¨<ec>ˆ˜ë¡<9c> <ec>¸ì½”ë”©<ec>„ ê²€ì¦í•˜ê³<a0> <eb>‚˜<ec>„œ `geocode` APIë¥<bc> <ed>˜¸ì¶œí•´<ec>„œ <ec>œ„<eb>„ê²½ë„ <ec> •ë³´ë<a5><bc> ë°›ì•„<ec>˜¤ë©´ì„œ
ë°”ë¡œ <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„<ec>— ë¶™ì¸<eb>‹¤.


~~~{.r}
library(ggmap)
library(ggplot2)
library(plyr)

geocodeQueryCheck(userType = "free")

kangwon.loc <- data.frame(addr=c("ê°•ì›<U+FFFD><U+FFFD> <U+FFFD>ì´ˆ<U+FFFD><U+FFFD> <U+FFFD>ëž‘<U+FFFD><U+FFFD>", 
                                 "ê²½ê¸°<U+FFFD><U+FFFD> <U+FFFD>˜ì™•<U+FFFD><U+FFFD> <U+FFFD>¬ì¼<U+FFFD>¸ê±°ë¦¬ë¡œ 73",
                                 "ê²½ê¸°<U+FFFD><U+FFFD> <U+FFFD>±ë‚¨<U+FFFD><U+FFFD> ë¶„ë‹¹êµ<U+FFFD> ë¯¸ê¸ˆ<U+FFFD><U+FFFD>"), stringsAsFactors = FALSE)

kangwon.loc$addr <- enc2utf8(kangwon.loc$addr)

kangwon.loc.latlon <- geocode(kangwon.loc$addr, source="google")

kangwon.loc.latlon <- with(kangwon.loc, data.frame(addr,
                                   laply(addr, function(val){geocode(val)})))

kangwon.loc.latlon  
~~~



~~~{.output}
FALSE Error: invalid multibyte character in parser at line 7

~~~

`geocodeQueryCheck(userType = "free")` ëª…ë ¹<ec>–´ë¡<9c> <ec>‚¬<ec>š©<eb>Ÿ‰<ec>´ 3ê°<9c> ì¤€ ê²ƒì„ <ed>™•<ec>¸<ed>•  <ec>ˆ˜ <ec>žˆ<eb>‹¤.


~~~{.r}
geocodeQueryCheck(userType = "free")
~~~



~~~{.output}
Error in eval(expr, envir, enclos): could not find function "geocodeQueryCheck"

~~~

### 3. `dplyr` <ed>•¨<ec>ˆ˜ë¥<bc> <ed>™œ<ec>š©<ed>•œ <eb>” ê°„ê²°<ed>•œ ì½”ë“œ

`dplyr`<ec>—<ec>„œ <ec> œê³µí•˜<eb>Š” `mutate_geocode` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>œ„<eb>„ê²½ë„ <ec> •ë³´ë<a5><bc> <ec>¼ê´„ì <ec>œ¼ë¡<9c> ë°›ì•„<ec><99>€<ec>„œ R <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„<ec>œ¼ë¡<9c> <ec><a0>€<ec>ž¥<ed>•œ<eb>‹¤.


~~~{.r}
library(dplyr)
kangwon.loc.dplyr <- kangwon.loc %>% mutate_geocode(addr)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'kangwon.loc' not found

~~~



~~~{.r}
kangwon.loc.dplyr
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'kangwon.loc.dplyr' not found

~~~

ê²½ê¸°<eb>„<ec><99>€ ê°•ì›<eb>„ 3ê°<9c> ì£¼ì†Œ<ec> •ë³´ë<a5><bc> êµ¬ê<b8>€ ì§€<eb>„ API ì§€<ec>—­<ec>— <ec> „<eb>‹¬<ed>•˜<ec>—¬ <ec>œ„<eb>„<ec><99>€ ê²½ë„<ec> •ë³´ë<a5><bc> ë°›ì•„<ec><99>€<ec>„œ <ec>´ë¥<bc> <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„<ec>— ë¶™ì¸<eb>‹¤.
ë°›ì•„<ec>˜¨ <ec> •ë³´ë<a5><bc> `kangwon.loc.dplyr` <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„<ec>— <ec><a0>€<ec>ž¥<ed>•˜ê³<a0> <ec>´ë¥<bc> <ed>™œ<ec>š©<ed>•˜<ec>—¬ êµ¬ê<b8>€ì§€<eb>„<ec>— <ec>‹œê°í™”ë¥<bc> <ed>•œ<eb>‹¤.


~~~{.r}
kangwonMap <- qmap(enc2utf8("<U+FFFD>ì´ˆ"), zoom = 8, maptype = "toner-lite")

kangwonMap + geom_point(data = kangwon.loc.dplyr, aes(lon,lat), size = 2, colour="blue")
~~~



~~~{.output}
FALSE Error: invalid multibyte character in parser at line 1

~~~

[^geoCodingWithR]: [GeoCoding with R](http://lumiamitie.github.io/r/geocoding-with-r-02/)
