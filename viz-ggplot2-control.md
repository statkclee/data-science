---
layout: page
title: <eb>°<ec>´<ed>„° ê³¼í•™
subtitle: ggplot2 <ec>ƒ‰<ec>ƒ <ec> œ<ec>–´
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



### `gapminder` <eb>°<ec>´<ed>„° ì¤€ë¹<84>[^viz-ggplot2-control] 

[^viz-ggplot2-control]: [Taking control of qualitative colors in ggplot2](https://stat545-ubc.github.io/block019_enforce-color-scheme.html)


êµ<ad>ê°€ê°€ 2ê°œë§Œ <ed>¬<ed>•¨<eb>œ <ec>˜¤<ec>„¸<ec>•„<eb>‹ˆ<ec>•„ë¥<bc> <ec> œ<ec>™¸<ed>•œ `gapminder` <eb>°<ec>´<ed>„°ë¥<bc> ë¶ˆëŸ¬<ec>˜¨<eb>‹¤.

<ec>¸êµ¬ìˆ˜<ec>— ê¸°ë°˜<ed>•´<ec>„œ êµ<ad>ê°€ <ec>š”<ec>¸<ec>„ <ec> •<eb> ¬<ed>•˜ê³<a0> <eb>‚˜<ec>„œ <eb>°<ec>´<ed>„°<eb>„ <ec> •<eb> ¬<ed>•œ<eb>‹¤.
<ec>´<ec>œ <eb>Š” <ec>•„<eb>˜ ê±°í’ˆê·¸ë¦¼<ec>—<ec>„œ <ed>° êµ<ad>ê°€ê°€ <ec>‘<ec><9d>€ êµ<ad>ê°€ë¥<bc> ê°€ë¦¬ëŠ” ê²ƒì„ ë°©ì<a7>€<ed>•˜ê¸<b0> <ec>œ„<ed>•¨<ec>´<eb>‹¤.
<ec>Š¬<ed>”„ê²Œë„, <eb>°<ec>´<ed>„° <ed>–‰<ec>˜ <ec>ˆœ<ec>„œê°€ <ec>‹œê°ì  <ec>‚°ì¶œë¬¼<ec>— <ec>˜<ed>–¥<ec>„ ë¯¸ì¹˜<eb>Š” <ec>‚¬ë¡€<eb>‹¤.
<ed>•˜ì§€ë§<8c>, `ggplot2`<eb>Š” `lattice` <ed>˜¹<ec><9d>€ ê¸°ë³¸ ê·¸ë˜<ed>”½ <ec>‹œ<ec>Š¤<ed>…œë³´ë‹¤ <ec>´<eb>Ÿ° ê²ƒì— <eb>œ <ec>˜<ed>–¥<ec>„ ë°›ëŠ”<eb>‹¤.

*2015-10-19: GitHub<ec>—<ec>„œ ê°€<ec> ¸<ec>˜¨ `ggplot2` ë²„ì ¼ 1.0.1.9003 <ec>„ <ec>‚¬<ec>š©<ed>•œ<eb>‹¤.
`dev` ê°œë°œë²„ì ¼<ec>´ CRAN <ec><a0>€<ec>¥<ec>†Œ ë²„ì ¼ë³´ë‹¤ ë³€ê²½ì‚¬<ed>•­<ec>´ ë§ì´ ë°˜ì˜<eb>˜<ec>–´ <ec>ˆ<eb>‹¤!*


~~~{.r}
library(ggplot2)
library(gapminder)
~~~



~~~{.output}
Error in library(gapminder): there is no package called 'gapminder'

~~~



~~~{.r}
suppressPackageStartupMessages(library(dplyr))
jdat <- gapminder %>% 
  filter(continent != "Oceania") %>% 
  droplevels() %>% 
  mutate(country = reorder(country, -1 * pop)) %>% 
  arrange(year, country)  
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'gapminder' not found

~~~

### <ec> <ec>— <eb><8c>€<ed>•œ <ed>¬ê¸°ì<99>€ <ec>ƒ‰<ec>ƒ <ec> œ<ec>–´

`ggplot2`ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec> „<ed>†µ<ec>  `gapminder` ê±°í’ˆê·¸ë¦¼<ec>„ <ec>ƒ<ec>„±<ed>•´ <eb>‚˜ê°„ë‹¤.
ê¸°ì–´ê°€ê³<a0> <eb>‚˜<ec>„œ, ê±·ê³ , ë§ˆì<a7>€ë§‰ìœ¼ë¡<9c> <eb>›´<eb>‹¤.

ë¨¼ì<a0>€, <eb>…„<eb>„ <ed>•˜<eb>‚˜ë¥<bc> <ec>„ <ec> •<ed>•´<ec>„œ ê°„ë‹¨<ed>•œ <ec>‚°<ec> <eb>„ë¥<bc> <ec>ƒ<ec>„±<ed>•œ<eb>‹¤.


~~~{.r}
j_year <- 2007
q <-
  jdat %>% 
  filter(year == j_year) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10(limits = c(230, 63000))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'jdat' not found

~~~



~~~{.r}
q + geom_point()
~~~



~~~{.output}
Error in q + geom_point(): non-numeric argument to binary operator

~~~

<ec> œ<eb>„<eb>˜<eb>Š” ê¸°í˜¸, <ed>¬ê¸<b0>, <ec>ƒ‰<ec>ƒ<ec>„ <ec> œ<ec>–´<ed>•œ<eb>‹¤.
<eb>‹¤<ec>†Œ ë¶ˆì¾Œ<ed>•œ <ec>„¤<ec> •<ec>„ <ec>‚¬<ec>š©<ed>•´<ec>„œ, <ec>„±ê³µê³¼ <ec>‹¤<ed>Œ¨ë¥<bc> <ed>™•<ec>‹¤<ed>ˆ ëª…í™•<ed>ˆ <ed>•œ<eb>‹¤.
ë©ì§„ <ec>ƒ‰<ec>ƒì²´ê³„ë¥<bc> <ec> <ec>š©<ed>•˜<eb>Š”<eb>° <ec> •êµí•œ ì¡°ì‘<ec>„ <ed>•  <ec>‹œ<ec> <ec>´ ì§€ê¸ˆì<9d>€ <ec>•„<eb>‹ˆ<eb>‹¤.
ë°°ì§±<ec>„ ê°€<ec> ¸<eb>¼!


~~~{.r}
## ê¸°í˜¸<U+653C><U+3E63>— <U+653C><U+3E62><U+383C><U+3E63>€<U+653C><U+3E64>•œ <U+653C><U+3E64>¬ê¸°ì<U+393C><U+3E39>€ <U+653C><U+3E63>ƒ‰<U+653C><U+3E63>ƒ<U+653C><U+3E63>„ ì±„ìš°<U+653C><U+3E62>Š” ê²ƒì„ <U+653C><U+3E63> œ<U+653C><U+3E63>–´<U+653C><U+3E64>•  <U+653C><U+3E63>ˆ˜ <U+653C><U+3E63>ˆ<U+653C><U+3E62>Š”ê°€? ê·¸ë ‡<U+653C><U+3E62>‹¤!
q + geom_point(pch = 21, size = 8, fill = I("darkorchid1"))
~~~



~~~{.output}
Error in q + geom_point(pch = 21, size = 8, fill = I("darkorchid1")): non-numeric argument to binary operator

~~~

### <ec>›<ed>¬ê¸<b0> = <ec>¸êµ¬ìˆ˜

<ec>›<ed>¬ê¸°ë¡œ <ec>¸êµ¬ìˆ˜ë¥<bc> ë°˜ì˜<ed>•˜ê³ ì <ed>•œ<eb>‹¤. 
ë°˜ì<a7>€ë¦„ì„ ë°”ë¡œ <ec> œ<ec>–´<ed>•  <ec>ˆ˜ <ec>ˆê¸<b0> <eb>•Œë¬¸ì—, êµ<ad>ê°€ë³<84> <ec>¸êµ¬ì—<ec>„œ <ec>›<ec>˜ <ed>¬ê¸°ë<a5><bc> ê²°ì •<ed>•˜<eb>„ë¡<9d> ê´€ê³„ë<a5><bc> $ë©´ì  = \pi r^2$<ec>œ¼ë¡<9c> <ec>„¤<ec> •<ed>•œ<eb>‹¤.
ì²«ë²ˆì§<b8> <ec>‹œ<eb>„<ec>—<ec>„œ <ec>¼ë¶€ ë¯¸ë¹„<ec> <ec>´ ë°œê²¬<eb>˜<ec>—ˆ<eb>‹¤: <ec>›<ec>˜ <ed>¬ê¸°ê<b0>€ <eb>„ˆë¬<b4> <ec>‘<ec>•˜ê³<a0>, <ed>¬ê¸°ë³„ ë²”ë<a1>€<eb>Š” <ec>›<ed>•˜<eb>˜ ê²ƒì´ <ec>•„<eb>‹ˆ<eb>‹¤.
<eb>‘ë²ˆì§¸ <ec>‹œ<eb>„<ec>—<ec>„œ, `show_guide = FALSE` <ec>„ <ed>ƒ<ec>˜µ<ec>…˜ <ec>„¤<ec> •<ec>œ¼ë¡<9c> ë²”ë<a1>€ë¥<bc> <ec>ˆ¨ê²¼ê³ , 
$\sqrt(pop / \pi)$ ë¡<9c> <ec>›<ed>¬ê¸°ë<a5><bc> ë§¤í•‘<ed>•´<ec>„œ ëª…ì‹œ<ec> <ec>œ¼ë¡<9c> ê·œëª¨<ec>— <eb><8c>€<ed>•œ ë²”ìœ„ë¥<bc> <ec>„¤<ec> •<ed>•´<ec>„œ <ec>›<ec>˜ <ed>¬ê¸°ë<a5><bc> ì¦ê<b0>€<ec>‹œì¼°ë‹¤.


~~~{.r}
## ggplot2 ALERT: size now means size, not radius!
q + geom_point(aes(size = pop), pch = 21)
~~~



~~~{.output}
Error in q + geom_point(aes(size = pop), pch = 21): non-numeric argument to binary operator

~~~



~~~{.r}
(r <- q +
   geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
   scale_size_continuous(range=c(1,40)))
~~~



~~~{.output}
Error in q + geom_point(aes(size = pop), pch = 21, show.legend = FALSE): non-numeric argument to binary operator

~~~

### <ec>š”<ec>¸<ec>œ¼ë¡<9c> ê²°ì •<eb>œ <ec>ƒ‰<ec>ƒ<ec>œ¼ë¡<9c> <ec>›<ec>„ ì±„ì›Œ<eb>„£<eb>Š”<eb>‹¤.

`aes()` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>š”<ec>¸<ec>„ <ec>ƒ‰<ec>ƒ<ec>œ¼ë¡<9c> ë§¤í•‘<ed>•œ<eb>‹¤.
<ec>š°<ec>„ , `continent` <ec>š”<ec>¸ê³<bc> <ec><eb>™ <ec>ƒ‰<ec>ƒì¡°í•©<ec>— ë§ì¶° <ec>‚¬<ec>š©<ed>•œ<eb>‹¤.
<eb><8c>€ë¥™ë³„ <ed>Œ¨<ec>‹¯(facet)<ec>„ <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. <ed>Œ¨<ec>‹¯<ec>„ <ec>‚¬<ec>š©<ed>•˜<eb>Š” <ec>´<ec>œ <eb>Š” ë§ì¶¤<ed>˜• <ec>ƒ‰<ec>ƒì¡°í•©<ec>„ <ec>‚¬<ec>š©<ed>•˜ë©´ì„œ ì§„ë„<ec>ƒ<ed>™©<ec>„ 
<ec> ê²€<ed>•´ <eb>‚˜ê°€<eb>Š”<eb>° <eb>„<ec><9b>€<ec>´ <eb>œ<eb>‹¤. ê°€<eb> ¹ <ec>œ <eb>Ÿ½<ec>— <ec>ˆ<eb>Š” ëª¨ë“  êµ<ad>ê°€ê°€ <eb>…¹<ec>ƒ‰ <ec>ƒ‰ì¡°ë<a5><bc> <eb>„ê¸<b0> <eb>•Œë¬¸ì—,
ë§Œì•½ <eb><8c>€ë¥<99> <ed>Œ¨<ec>‹¯<ec>— <eb>‹¤<ec>–‘<ed>•œ <ec>ƒ‰<ec>ƒ<ec>˜ <ec>›<ec>´ <ec>ˆ<eb>‹¤ë©<b4>, ë­”ê<b0>€ <ec>˜ëª»ëœ ê²ƒì„ <ec>¸ì§€<ed>•  <ec>ˆ˜ <ec>ˆê²<8c> <eb>œ<eb>‹¤.


~~~{.r}
(r <- r + facet_wrap(~ continent) + ylim(c(39, 87)))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'r' not found

~~~



~~~{.r}
r + aes(fill = continent)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'r' not found

~~~

### êµ<ad>ê°€ë³<84> <ec>ƒ<ec>ƒì¡°í•©<ec>„ <ec>„¤<ec> •<ed>•œ<eb>‹¤.

`gapminder` <ed>Œ©<ed>‚¤ì§€<ec>—<eb>Š” <eb><8c>€ë¥™ê³¼ ê°<81> êµ<ad>ê°€ë³<84> <ec>ƒ‰<ec>ƒ <ed>Œ”<eb> ˆ<ed>Š¸ê°€ <eb>”°<eb>¼<ec>˜¨<eb>‹¤.
<ec>˜ˆë¥<bc> <eb>“¤<ec>–´, [êµ<ad>ê°€ë³<84> <ec>ƒ‰<ec>ƒì¡°í•©](https://github.com/jennybc/gapminder/blob/master/data-raw/gapminder-color-scheme-ggplot2.png)<ec>„ 
<ed>´ë¦<ad><ed>•œ<eb>‹¤.


~~~{.r}
str(country_colors)
~~~



~~~{.output}
Error in str(country_colors): object 'country_colors' not found

~~~



~~~{.r}
head(country_colors)
~~~



~~~{.output}
Error in head(country_colors): object 'country_colors' not found

~~~

`country_colors` <ec>ˆœ<ec>„œê°€ <ec>•Œ<ed>ŒŒë²<b3> <ec>ˆœ<ec>´ <ec>•„<eb>‹ˆ<eb>‹¤.
êµ<ad>ê°€ê°€ <ec>‹¤<ec> œë¡<9c> <eb><8c>€ë¥™ë‚´ <ed>¬ê¸°ë¡œ <ec> •<eb> ¬<eb>˜<ec>–´ <ec>ˆ<ec>–´, <ec>ƒ‰<ec>ƒì¡°í•©<ec>´ <ec>ƒ<ec>„±<eb>œ ë¡œì§<ec>„ ë°˜ì˜<ed>•˜ê³<a0> <ec>ˆ<eb>‹¤.
<ec>´<ec>ƒ<ec> <ec>œ¼ë¡<9c>, <ec>‹¤<ec> œ<ec>—<ec>„œ<eb>Š” <ed>•­<ec>ƒ ê·¸ë ‡ì§€<eb>Š” <ec>•Šì§€ë§<8c>, ë¶„ì„<ec>´ <ed>–‰<ec>ˆœ<ec>„œ<ec>— <ec>˜ì¡´í•˜ë©<b4> <ec>•ˆ<eb>œ<eb>‹¤.

### `ggplot2`<ec>— <ec>‚¬<ec>š©<eb>  <ec>ƒ‰<ec>ƒì¡°í•©<ec>„ ì¤€ë¹„í•œ<eb>‹¤.

ê·¸ë˜<ed>”½ ë¬¸ë²•(Grammar of Graphics)<ec>—<ec>„œ, **scale** <ed>•¨<ec>ˆ˜ê°€ <eb>°<ec>´<ed>„° ë³€<ec>ˆ˜<ec>—<ec>„œ `aes` ë¯¸í•™<ec>— <eb><8c>€<ed>•œ ë§¤í•‘<ec>„ <ec> œ<ec>–´<ed>•œ<eb>‹¤.
ì§€ê¸ˆê¹Œì§€, <ec><eb>™<ec>œ¼ë¡<9c> `ggplot2`ê°€ <ec>ƒ‰<ec>ƒ / ì±„ìš°ê¸<b0> scale <ec>´ ê²°ì •<eb>˜<eb>„ë¡<9d> <eb>‚´ë²„ë ¤ <eb>‘<ec>—ˆ<eb>‹¤.
<ed>•˜ì§€ë§<8c>, ë§ì¶¤<ed>˜• <ec>ƒ‰<ec>ƒì¡°í•©<ec>„ <ec>‚¬<ec>š©<ed>•˜<eb> ¤ë©<b4>, `country` <ec>š”<ec>¸<ec>´ `geom_point`<ec>— <ec>ƒ‰<ec>ƒ<ec>„ ì±„ìš°<eb>Š”<eb>° ë§¤í•‘<ec>´ <eb>˜<eb>„ë¡<9d> <ec> œ<ec>–´<ed>•œ<eb>‹¤.

`scale_fill_manual` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. <ec>´<ec>‚°<ed>˜• ì²™ë„ë¥<bc> ë§ì¶¤<ed>˜•<ec>œ¼ë¡<9c> <ec> œ<ec>–´<ed>•˜<eb>Š”<eb>° <ec>‚¬<ec>š©<eb>˜<eb>Š” <ed>•¨<ec>ˆ˜ ê°€ì¡<b1> ì¤<91> êµ¬ì„±<ec>›<ec>´<eb>‹¤.
<ed>•µ<ec>‹¬ <ec>¸<ec><eb>Š” `value =`<ec>œ¼ë¡<9c> ë¯¸í•™ê°<92> ë²¡í„°ë¡<9c> <ec>´ë²<88> ê²½ìš°<ec>— <ec>ƒ‰<ec>ƒ<ec>„ ì±„ì›Œ<eb>„£<eb>Š”<eb>‹¤.
ë²¡í„°ê°€ ëª…ì¹­<ec>„ ê°–ê²Œ<eb>˜ë©<b4>, ë§¤í•‘ê³¼ì •<ec>—<ec>„œ ì°¸ê³ <eb>œ<eb>‹¤. <ec>´<eb>Ÿ° ê¸°ëŠ¥<ec>´ ë¯¿ì„ <ec>ˆ˜ <ec>—†<ec>„ <ec> •<eb>„ë¡<9c> <ec>œ <ec>š©<ed>•˜<eb>‹¤!
`country_colors` ê°€ <ec>™œ **<ec> •<ed>™•<ed>•˜ê²<8c> <ec>‘<ec>—…**<ec>„ <ec>ˆ˜<ed>–‰<ed>•˜<eb>Š” <ec>´<ec>œ <eb>‹¤.
<ec>´ë¥<bc> <ed>†µ<ed>•´ `country` <ec>š”<ec>¸ <ec>ˆ˜ì¤€<ec>— <eb><8c>€<ed>•œ <ec>ˆœ<ec>„œ, <eb>°<ec>´<ed>„° <ed>–‰ <ec>ˆœ<ec>„œ, <ed>˜¹<ec><9d>€ <ec> •<ed>™•<ed>•˜ê²<8c> <ec>–´<eb>–¤ êµ<ad>ê°€ê°€ <ec> œ<eb>„<eb>˜<ec>–´<ec>•¼ <ed>•˜<eb>Š”ì§€<ec>— 
ê´€<ed>•œ ê±±ì •<ec>„ <eb>œ<ec>–´ì¤€<eb>‹¤.

### `ggplot2` ê±°í’ˆê·¸ë¦¼<ec>„ <ec>ƒ<ec>„±<ed>•œ<eb>‹¤.

<ec>´ ì§€<ec> <ec>— <ec>˜¤ë©<b4> <ec>‚¬ê¸°ì„±<ec>´ <ec>ˆ<ec>„ <ec> •<eb>„ë¡<9c> <eb>‹¨<ec>ˆœ<ed>•´ ì§„ë‹¤.
<eb>‹¤ë¥<b8> ë§ì<9d>€ ê²ƒê³¼ ë§ˆì°¬ê°€ì§€ë¡<9c>, <ec>•<ec>„  ëª¨ë“  ê²ƒì„ <ed>•´ê²°í•˜ë©<b4>, <ec> •ë§<90> <ec>‰½<eb>‹¤. 
ë§ˆì<a7>€ë§‰ìœ¼ë¡<9c> ì¶”ê<b0>€<ed>•  ìµœì¢… ë¹„íŠ¸ <eb>‘ê°œëŠ” `aes()`ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ êµ<ad>ê°€ê°€ <ec>ƒ‰<ec>ƒ<ec>— ë§¤ì¹­<eb>˜ê²<8c> <ed>•˜ê³<a0>,
`scale_fill_manual()`<ec>„ <ec>‚¬<ec>š©<ed>•´<ec>„œ ë§ì¶¤<ed>˜• <ec>ƒ‰<ec>ƒì¡°í•©<ec>„ ëª…ì„¸<ed>•œ<eb>‹¤.


~~~{.r}
r + aes(fill = country) + scale_fill_manual(values = country_colors)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'r' not found

~~~

### <ed>•œê³³ì— ëª¨ë‘ ëª¨ì•„ë³´ì.

<ec> œ<eb>„ë¥<bc> <ec>™„<ec>„±<ed>•˜<eb>Š” <ec> „ì²<b4> ì½”ë“œ<eb>Š” <eb>‹¤<ec>Œê³<bc> ê°™ë‹¤.


~~~{.r}
j_year <- 2007
jdat %>% 
  filter(year == j_year) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, fill = country)) +
  scale_fill_manual(values = country_colors) +
  facet_wrap(~ continent) +
  geom_point(aes(size = pop), pch = 21, show.legend = FALSE) +
  scale_x_log10(limits = c(230, 63000)) +
  scale_size_continuous(range = c(1,40)) + ylim(c(39, 87))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'jdat' not found

~~~
