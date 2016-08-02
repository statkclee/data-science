---
layout: page
title: <eb>°<ec>´<ed>„° ê³¼í•™
subtitle: Kormaps, leaflet ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™” ê¸°ì´ˆ 
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 


> ## <ed>•™<ec>Šµ ëª©í‘œ {.objectives}
>
>  * <ec>œ„<eb>„ê²½ë„ <ec> •ë³<b4> <ed>™œ<ec>š© `ggmap` ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™”<ed>•œ<eb>‹¤.
>  * `Kormaps` ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™”<ed>•œ<eb>‹¤.

### 1. `Kormaps` ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™” [^kormaps-01] 

[^kormaps-01]: [Kormaps <ed>Œ¨<ed>‚¤ì§€ë¥<bc> <ec>´<ec>š©<ed>•œ <eb>‹¨ê³„êµ¬ë¶„ë„ <ec>‰½ê²<8c> ê·¸ë¦¬ê¸<b0>(1)](http://web-r.org/webrboard/6477)

2010<eb>…„ <ec>‹œ/<eb>„, <ec>‹œ/êµ<b0>/êµ<ac>, <ec>/ë©<b4>/<eb>™ <ed>–‰<ec> •êµ¬ì—­ì§€<eb>„ 3ê°œë<a5><bc> ê°–ê³  <ec>¸êµ¬ì´ì¡°ì‚¬(2010<eb>…„) ê¸°ì<a4>€ ì§€ë¦¬ì •ë³´ë<a5><bc> <ec> œê³µí•˜<eb>Š” R <ed>Œ©<ed>‚¤ì§€ë¥<bc> ì¹´í†¨ë¦<ad><eb><8c>€<ed>•™êµ<90>
[ë¬¸ê±´<ec>›…](http://web-r.org) êµìˆ˜<eb>‹˜ê»˜ì„œ ê°œë°œ<ed>•˜<ec>—¬ ê³µê°œ<ed>•˜<ec><98>€<eb>‹¤.

`submap` ê´€<eb> ¨ <ec>¼ë¶€ <eb>™<ec>‘<ec>´ <eb>˜ì§€ <ec>•Š<eb>Š” ê²½ìš°<eb>„ <ec>ˆì§€ë§<8c>, ë¹ ë¥´ê²<8c> <ec>¸êµ¬ì´ì¡°ì‚¬ê²°ê³¼ë¥<bc> <eb><8c>€<ed>•œë¯¼êµ­ ì§€ë¦¬ì •ë³´ë¡œ <eb>„<ec>‹<ed>™”<ed>•˜<eb>Š”<eb>° ì¢‹ì<9d>€ ê¸°ëŠ¥<ec>„ <ec> œê³µí•˜ê³<a0> <ec>ˆ<eb>‹¤.

`Kormaps` <ed>Œ©<ed>‚¤ì§€ë¥<bc> <ec>„¤ì¹˜í•˜ê³<a0>, ì£¼ì œ<eb>„ <ed>Œ©<ed>‚¤ì§€ `tmap` <eb>„ ë¶ˆëŸ¬<ec>˜¨<eb>‹¤.


~~~{.r}
#install.packages("devtools")  # <U+653C><U+3E64>•œë²<U+383C><U+3E38> <U+653C><U+3E63>„¤ì¹˜í•œ ê²½ìš°<U+653C><U+3E63>—<U+653C><U+3E62>Š” <U+653C><U+3E62>‹¤<U+653C><U+3E63>‹œ <U+653C><U+3E63>„¤ì¹˜í•  <U+653C><U+3E64>•„<U+653C><U+3E63>š” <U+653C><U+3E63>—†<U+653C><U+3E63>Šµ<U+653C><U+3E62>‹ˆ<U+653C><U+3E62>‹¤.
#devtools::install_github("cardiomoon/Kormaps")
library(Kormaps)
~~~



~~~{.output}
FALSE Error in library(Kormaps): there is no package called 'Kormaps'

~~~



~~~{.r}
library(tmap)
~~~



~~~{.output}
FALSE Error in library(tmap): there is no package called 'tmap'

~~~



~~~{.r}
library(raster)
~~~



~~~{.output}
FALSE Error in library(raster): there is no package called 'raster'

~~~

2010<eb>…„ <ec>‹œ/<eb>„, <ec>‹œ/êµ<b0>/êµ<ac>, <ec>/ë©<b4>/<eb>™ 3<eb>‹¨ê³<84> `Kormaps` <ed>Œ©<ed>‚¤ì§€<ec>— <eb>‚´<ec>¥<eb>œ <ed>–‰<ec> •êµ¬ì—­ì§€<eb>„<eb>Š” <eb>‹¤<ec>Œê³<bc> ê°™ë‹¤.


~~~{.r}
p1 <- qtm(kormap1)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): could not find function "qtm"

~~~



~~~{.r}
p2 <- qtm(kormap2)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): could not find function "qtm"

~~~



~~~{.r}
p3 <- qtm(kormap3)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): could not find function "qtm"

~~~



~~~{.r}
multiplot(p1, p2, p3, cols = 3)
~~~



~~~{.output}
FALSE Error in multiplot(p1, p2, p3, cols = 3): object 'p1' not found

~~~


`submap()` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•˜<ec>—¬ <eb><8c>€<ed>•œë¯¼êµ­ <ed>Š¹<ec> • ì§€<ec>—­<ec>„ ë½‘ì•„<eb>‚´<ec>„œ ë³„ë„ë¡<9c> ì§€ë¦¬ì •ë³´ë<a5><bc> <ec>‹œê°í™” <ed>•  <ec>ˆ˜ <ec>ˆ<eb>‹¤.


~~~{.r}
daejeon.lvl.3 <-  submap(korpopmap3, enc2utf8("<U+FFFD>€<U+FFFD><U+FFFD>"))
qtm(daejeon.lvl.3,"ê°€êµ<U+FFFD>ê³<U+FFFD>ê°€êµ<U+FFFD>")+tm_layout(fontfamily="AppleGothic")
~~~



~~~{.output}
FALSE Error: invalid multibyte character in parser at line 1

~~~

ì°¸ê³ , `names(korpopmap1@data)` ëª…ë ¹<ec>–´ë¥<bc> <ed>†µ<ed>•´<ec>„œ <ec>¸êµ¬ì´ì¡°ì‚¬(2010<eb>…„)<ec>— <ed>¬<ed>•¨<eb>œ <eb>°<ec>´<ed>„°<eb>„ <ed>™•<ec>¸<ed>•  <ec>ˆ˜ <ec>ˆ<eb>‹¤.

### 2. `Kormaps`, `leaflet` <ed>Œ©<ed>‚¤ì§€ <ed>™œ<ec>š© ì§€ë¦¬ì •ë³<b4> <ec>‹œê°í™” [^kormaps-02]

[^kormaps-02]: [Kormaps <ed>Œ¨<ed>‚¤ì§€ë¥<bc> <ec>´<ec>š©<ed>•œ <eb>‹¨ê³„êµ¬ë¶„ë„ <ec>‰½ê²<8c> ê·¸ë¦¬ê¸<b0>(2)](http://rpubs.com/cardiomoon/159305)

[leaflet](https://rstudio.github.io/leaflet/) <ed>Œ©<ed>‚¤ì§€<eb>Š” <ec>¸<ed>„°<eb>™<ed>‹°ë¸<8c> ì§€<eb>„ë¡<9c> ê°€<ec>¥ <ec>¸ê¸°ìˆ<eb>Š” <ec>˜¤<ed>”ˆ<ec>†Œ<ec>Š¤ <ec>ë°”ìŠ¤<ed>¬ë¦½íŠ¸ <eb>¼<ec>´ë¸ŒëŸ¬ë¦¬ë¡œ 
[<eb>‰´<ec>š•<ed><83>€<ec>„ì¦<88>](http://www.nytimes.com/projects/elections/2013/nyc-primary/mayor/map.html), 
[<ec>›Œ<ec>‹±<ed>„´<ed>¬<ec>Š¤<ed>Š¸](http://www.washingtonpost.com/sf/local/2013/11/09/washington-a-world-apart/), 
[GitHub](https://github.com/blog/1528-there-s-a-map-for-that), [<ed>”Œë¦¬ì»¤](https://www.flickr.com/map) ê°™ì<9d>€ êµ<ad><eb>‚´<ec>™¸ <ec>œ ëª<85> <ec>›¹<ec>‚¬<ec>´<ed>Š¸<ec>—<ec>„œ <ec>‚¬<ec>š©<eb>˜ê³<a0> <ec>ˆ<eb>‹¤.



~~~{.r}
library(leaflet)
blue_palette <- colorNumeric(palette="Blues",domain=korpopmap3$ê°€êµ<U+FFFD>ê³<U+FFFD>ê°€êµ<U+FFFD>)
households <- paste0(korpopmap3@data$name,": ",korpopmap3@data$ê°€êµ<U+FFFD>ê³<U+FFFD>ê°€êµ<U+FFFD>)

leaflet(korpopmap3) %>%
  addTiles() %>%
  addPolygons(stroke=TRUE, 
              smoothFactor = 0.2,
              fillOpacity = .8, 
              popup=households,
              color= ~blue_palette(korpopmap3@data$ê°€êµ<U+FFFD>ê³<U+FFFD>ê°€êµ<U+FFFD>))
~~~



~~~{.output}
FALSE Error: <text>:2:66: unexpected input
FALSE 1: library(leaflet)
FALSE 2: blue_palette <- colorNumeric(palette="Blues",domain=korpopmap3$ê°€
FALSE                                                                     ^

~~~

