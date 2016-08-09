---
layout: page
title: <eb>°<ec>´<ed>„° ê³¼í•™
subtitle: <eb>°<ec>´<ed>„° <ec>‹œê°í™”(ggplot2, ggvis)
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---





> ## <ed>•™<ec>Šµ ëª©í‘œ [^data-carpentry-ggplot2] {.objectives}
>
> * `ggplot2` <ed>Œ©<ed>‚¤ì§€ë¡<9c> <eb>°<ec>´<ed>„°ë¥<bc> <ec>‹œê°í™”<ed>•œ<eb>‹¤. 
> * ê³ ë‚œ<eb>„ ë³µì¡<ed>•œ <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>„ `ggplot2` <ed>Œ©<ed>‚¤ì§€ë¥<bc> <ed>™œ<ec>š©<ed>•˜<ec>—¬ <eb>‹¨ê³„ì <ec>œ¼ë¡<9c> êµ¬ì¶•<ed>•œ<eb>‹¤.
> * Figshare [surveys.csv](http://files.figshare.com/1919744/surveys.csv), [mammals data](http://figshare.com/articles/Portal_Project_Teaching_Database/1314459)
<eb>°<ec>´<ed>„°ë¥<bc> <ed>™œ<ec>š©<ed>•˜<ec>—¬ <ec>‹œê°í™”ë¥<bc> <ec>‹¤<ec>Šµ<ed>•œ<eb>‹¤.

[^data-carpentry-ggplot2]: [Data Carpentry R lessons on ecology](http://www.datacarpentry.org/R-ecology/)


### `ggplot2`ë¡<9c> <ec>‹œê°í™”ë¥<bc> <ed>•˜<eb>Š” <ec>´<ec>œ 

R<ec>— ê¸°ë³¸<ec> <ec>œ¼ë¡<9c> <ec>‹œê°í™”ë¥<bc> <ec>œ„<ed>•œ <eb>‹¤<ec>–‘<ed>•œ ê¸°ëŠ¥<ec>´ ì¡´ì¬<ed>•˜ì§€ë§<8c>, `ggplot2`ê°€ ê¸°ë³¸<ec>œ¼ë¡<9c> <ec> œê³µë˜<eb>Š” R <ec>‹œê°í™” ê¸°ëŠ¥ <ec>œ„<ec>— <eb>”<ec>š± ê°•ë ¥<ed>•œ ê¸°ëŠ¥<ec>„ <ec> œê³µí•œ<eb>‹¤.
ê¸°ë³¸<ec> <ec>¸ R ê¸°ëŠ¥<eb>„ <ec>ƒ<eb><8c>€<ec> <ec>œ¼ë¡<9c> <eb>‹¤ë¥<b8> <ec>†Œ<ed>”„<ed>Š¸<ec>›¨<ec>–´ <ec>„œë¹„ìŠ¤<eb>‚˜ <ec> œ<ed>’ˆê³<bc> ë¹„êµê°€ <eb>˜ì§€ <ec>•Š<ec>„ <ec> •<eb>„ë¡<9d> ê°•ë ¥<ed>•˜<eb>‹¤. <ec>´<eb>Ÿ° <ec> <ec>—<ec>„œ R<ec><9d>€ ì°<b8> ê²¸ì†<ed>•˜<eb>‹¤<eb>Š” <ec>ƒê°ì´ <eb>“ <eb>‹¤.

### <eb>°<ec>´<ed>„° <eb>‹¤<ec>š´ë¡œë“œ<ec><99>€ <ec>‹œê°í™” <ed>ˆ´ì²´ì¸ ì¤€ë¹<84>


~~~{.r}
# read_csvë¡<U+393C><U+3E63> csv <U+653C><U+3E64>ŒŒ<U+653C><U+3E63>¼<U+653C><U+3E63>„ ë¶ˆëŸ¬ <U+653C><U+3E63>½<U+653C><U+3E63>–´<U+653C><U+3E63>˜¨<U+653C><U+3E62>‹¤.
library(readr)
# <U+653C><U+3E63>‹œê°í™”ë¥<U+623C><U+3E63> <U+653C><U+3E63>œ„<U+653C><U+3E64>•œ ggplot2 <U+653C><U+3E64>Œ©<U+653C><U+3E64>‚¤ì§€ë¥<U+623C><U+3E63> ë¶ˆëŸ¬ <U+653C><U+3E63>½<U+653C><U+3E63>–´<U+653C><U+3E63>˜¨<U+653C><U+3E62>‹¤. 
library(ggplot2)
# ggplot2<U+653C><U+3E63>— <U+653C><U+3E63>…<U+653C><U+3E62> ¥<U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„°ë¡<U+393C><U+3E63> <U+653C><U+3E63>‚¬<U+653C><U+3E63>š©<U+653C><U+3E62>  <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„°ë¥<U+623C><U+3E63> <U+653C><U+3E63> „ì²˜ë¦¬<U+653C><U+3E64>•œ<U+653C><U+3E62>‹¤.
library(dplyr)
# <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„°ë¥<U+623C><U+3E63> ë¶ˆëŸ¬<U+653C><U+3E63>˜¨<U+653C><U+3E62>‹¤.
surveys.dat <- read_csv("http://files.figshare.com/1919744/surveys.csv")
~~~



~~~{.output}
FALSE Error in open.connection(con, "rb"): Timeout was reached

~~~

[figshare](https://figshare.com/)[^figshare-wired] <ec>‚¬<ec>´<ed>Š¸<ec>—<ec>„œ <eb>°<ec>´<ed>„°ë¥<bc> ê°€<ec> ¸<ec>˜¨<eb>‹¤. `surveys.csv` <eb>°<ec>´<ed>„°<eb>Š” <ed>¬<ed>š<eb>œ <eb>™ë¬¼ì— ê´€<ed>•œ ì¸¡ì •<ec> •ë³´ê<b0>€ <eb>‹´ê²<a8> <ec>ˆ<eb>‹¤.

### <ec>‹œê°í™”ë¥<bc> <ec>œ„<ed>•œ <eb>°<ec>´<ed>„° <ec> „ì²˜ë¦¬ ê³¼ì •

<eb>‹¤<ec>š´ë¡œë“œ ë°›ì<9d>€ <eb>°<ec>´<ed>„°<ec>— <eb><8c>€<ed>•œ <ec>š”<ec>•½<ec> •ë³´ë<a5><bc> `summary` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>‚´<ed>´ë³¸ë‹¤.


~~~{.r}
summary(surveys.dat)
~~~



~~~{.output}
Error in summary(surveys.dat): object 'surveys.dat' not found

~~~

#### 1 <eb>‹¨ê³<84> - ê²°ì¸¡ê°<92> <ec> œê±<b0>

<eb>°<ec>´<ed>„°<ec>…‹<ec>— <ec>¼ë¶€ ê²°ì¸¡<ec> •ë³´ê<b0>€ `summary` <ec>‹¤<ed>–‰ê²°ê³¼ë¥<bc> ë³´ì—¬ì£¼ê³  <ec>ˆ<ec>–´, <ec>´ë¥<bc> <ec> œê±°í•œ<eb>‹¤. 
ê°<81> ë³€<ec>ˆ˜ë§ˆë‹¤ ê²°ì¸¡ì¹˜ê<b0>€ <ec>ˆ<ec>–´ <ec>´ë¥<bc> <ed>•œ<eb><95>€ <ed>•œ<eb><95>€ <ec> •<ec>„±<ec>Š¤<eb>Ÿ½ê²<8c> ê²°ì¸¡<ec> •ë³´ë<a5><bc> <ec> œê±°í•˜<eb>Š” <eb><8c>€<ec>‹ <ec>— `dplyr` <ed>ŒŒ<ec>´<ed>”„ <ec>—°<ec>‚°<ec>ë¥<bc> <ec>‚¬<ec>š©<ed>•˜<ec>—¬
<ec>¼ê´„ì <ec>œ¼ë¡<9c> ì²˜ë¦¬<ed>•œ<eb>‹¤.


~~~{.r}
surveys.complete <- surveys.dat %>%
                    filter(species_id != "") %>%       # species_id ê²°ì¸¡ê°<U+FFFD> <U+FFFD>œê±°
                    filter(!is.na(weight)) %>%          # weight ê²°ì¸¡ê°<U+FFFD> <U+FFFD>œê±°
                    filter(!is.na(hindfoot_length))     # hindfoot_length ê²°ì¸¡ê°<U+FFFD> <U+FFFD>œê±°
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'surveys.dat' not found

~~~
#### 2 <eb>‹¨ê³<84> - ë¯¸ë<af>¸í•œ <ec>ë£<8c> <ec> œê±<b0>

ê°œì²´<ec>ˆ˜ê°€ <ec> <ec><9d>€ ì¢…ì´ ë§ì•„<ec>„œ, ê°œì²´<ec>ˆ˜ ê¸°ì<a4>€ 10 ë³´ë‹¤ <ec> <ec><9d>€ ì¢…ì<9d>€ <ec> œê±°í•˜ê¸°ë¡œ <ed>•œ<eb>‹¤.
ë¨¼ì<a0>€ `group_by` <ed>•¨<ec>ˆ˜ë¡<9c> ê°œì²´ì¢…ì„ ê·¸ë£¹<ec>œ¼ë¡<9c> êµ°ì§‘<ed>™”<ed>•˜ê³<a0>, `tally` <ed>•¨<ec>ˆ˜ë¡<9c> ê°<81> ì¢…ë³„ë¡<9c> ê°œì²´<ec>ˆ˜ë¥<bc> <ec>„¸ê³<a0>, 
<eb>‚´ë¶€<ec>¸<ec>ë¡<9c> `sort=TRUE` ë¥<bc> <eb>„£<ec>–´<ec>„œ <eb>‚´ë¦¼ì°¨<ec>ˆœ<ec>œ¼ë¡<9c> <ec> •<eb> ¬<ed>•œ<eb>‹¤. 



~~~{.r}
species.counts <- surveys.complete %>%
  group_by(species_id) %>%
  tally(sort=TRUE)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'surveys.complete' not found

~~~



~~~{.r}
tail(species.counts)
~~~



~~~{.output}
FALSE Error in tail(species.counts): object 'species.counts' not found

~~~

ê°œì²´<ec>ˆ˜ê°€ 10ê°<9c> ë¯¸ë§Œ<ec>¸ ì¢…ì„ <ec> œê±°í•˜ê³<a0>, <ec>‹œê°í™”ë¥<bc> <ec>œ„<ed>•œ ê¸°ë³¸ <eb>°<ec>´<ed>„°<ec>…‹ ì¤€ë¹„ë<a5><bc> <ec>™„ë£Œí•œ<eb>‹¤.


~~~{.r}
frequent.species <- species.counts %>%
                    filter(n >= 10) %>%
                    select(species_id)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'species.counts' not found

~~~



~~~{.r}
surveys.complete <- surveys.complete %>%
           filter(species_id %in% frequent.species$species_id)
~~~



~~~{.output}
FALSE Error in eval(expr, envir, enclos): object 'surveys.complete' not found

~~~

#### ê¸°ë³¸ R <ec>‹œê°í™” ê¸°ëŠ¥ <ed>™œ<ec>š©

`weight`ë¥<bc> <ec>˜ˆì¸¡ë<b3>€<ec>ˆ˜ `x` <ec>œ„ì¹˜ì— <eb>‘ê³<a0>, ì¢…ì†ë³€<ec>ˆ˜ `hindfoot_length`ë¥<bc> `y`<ec>— <eb>‘ê³<a0> R ê¸°ë³¸ <ec>‹œê°í™” <ec>‚°<ec> <eb>„ë¥<bc> <eb>„<ec>‹<ed>™”<ed>•´ ë³´ì.


~~~{.r}
plot(x = surveys.complete$weight, y = surveys.complete$hindfoot_length)
~~~



~~~{.output}
Error in plot(x = surveys.complete$weight, y = surveys.complete$hindfoot_length): object 'surveys.complete' not found

~~~

### `ggplot2` <ed>Œ©<ed>‚¤ì§€ë¡<9c> <ec>‹œê°í™”

`ggplot2`ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ R ê¸°ë³¸ <eb>‚´<ec>¥<eb>œ <ec>‹œê°í™” ê¸°ëŠ¥<ec>„ <eb><8c>€<ec>‹ <ed>•˜<ec>—¬ <eb>™<ec>¼<ed>•œ <ec>‘<ec>—…<ec>„ <ec>ˆ˜<ed>–‰<ed>•  <ec>ˆ˜ <ec>ˆ<eb>‹¤.

<eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>„ <eb>°<ec>´<ed>„°<ec>—<ec>„œ ë³µì¡<ed>•˜ê³<a0> <ec> •êµí•œ <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>„  `ggplot2` <ed>Œ©<ed>‚¤ì§€ë¡<9c> <ec>ƒ<ec>„±<ed>•  <ec>ˆ˜ <ec>ˆ<eb>‹¤.
ê¸°ë³¸<ec>„¤<ec> •ë§Œìœ¼ë¡<9c> ìµœì†Œ<ec>˜ <eb>…¸<eb> ¥<ec>œ¼ë¡<9c> ì¶œíŒ <ed>’ˆì§<88> <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>„ ë§Œë“¤<ec>–´ <eb>‚¼ <ec>ˆ˜ <ec>ˆ<eb>‹¤.

`ggplot2` <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec><9d>€ <ec>‹œê°í™” <ec>š”<ec>†Œë¥<bc> ì°¨ê³¡ì°¨ê³¡ ì¶”ê<b0>€<ed>•´ <eb>‚˜ê°€ë©´ì„œ ë§Œë“¤<ec>–´ ê°„ë‹¤.

`ggplot2`  <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec><9d>€ <eb>‹¤<ec>Œ <eb>‹¨ê³„ë¡œ ë§Œë“¤<ec>–´ <eb>‚˜ê°„ë‹¤:

- `data` <ec>¸<ec>ë¡<9c> <ed>Š¹<ec> • <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>„ê³<bc> <ed>”Œë¡<af><ec>„ ë¬¶ì–´ <ec>—°ê²°ì‹œ<ed>‚¨<eb>‹¤.


~~~{.r}
ggplot(data = surveys.complete)
~~~

- ë¯¸ì  <ec>š”<ec>†Œë¥<bc> `aes` ë¡<9c> <ec> •<ec>˜<ed>•´<ec>„œ, <ed>”Œë¡<af>ì¶•ì— <eb>°<ec>´<ed>„° ë³€<ec>ˆ˜ë¥<bc> ë§¤í•‘<ed>•˜ê³<a0>, <ed>¬ê¸<b0>, ëª¨ì–‘, <ec>ƒ‰<ec>ƒ <eb>“±<ec>„ <ec>‹œê°í™”<ed>•œ<eb>‹¤. 


~~~{.r}
ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length))
~~~

- <eb>°<ec>´<ed>„°<ec>— <eb><8c>€<ed>•œ <ec>‹œê°ì  <ed>‘œ<ed>˜„(<ec> , <ec>„ , ë§‰ë<8c>€ <eb>“±)<ec>„ <ed>•˜<eb>Š”<eb>° `geoms` <ec>„ <ec>‚¬<ec>š©<ed>•´<ec>„œ <ed>”Œë¡<af><ec>— ë°˜ì˜<ed>•œ<eb>‹¤. 
<ed>”Œë¡<af><ec>— `geoms`ë¥<bc> ì¶”ê<b0>€<ed>•˜<eb>Š”<eb>° `+` <ec>—°<ec>‚°<ec>ë¥<bc> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤::


~~~{.r}
ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)) +
  geom_point()
~~~



~~~{.output}
Error in ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)): object 'surveys.complete' not found

~~~

> #### ì£¼ì˜ <ec>‚¬<ed>•­ {.callout}
>
> - `ggplot` <ed>•¨<ec>ˆ˜<ec>— <eb>„£<ec><9d>€ <ec>–´<eb>–¤ ê²ƒë„ ì¶”ê<b0>€<ed>•œ `geom` ê³„ì¸µ<ec>„ <ed>†µ<ed>•´ ë°˜ì˜<eb>œ<eb>‹¤. ì¦<89>, ë³´í¸<ec> <ec>¸ <ed>”Œë¡<af> <ec>„¤<ec> •<ec>´<eb>‹¤.
> - `aes()`<ec>— <ec>„¤<ec> •<ed>•œ `x`ì¶<95>, `y`ì¶•ë„ <ec>—¬ê¸°ì— <ed>¬<ed>•¨<eb>œ<eb>‹¤.

### <ed>”Œë¡<af> ë³€ê²½í•˜ê¸<b0>

- <ed>ˆ¬ëª…ë„(transparaency, alpha)ë¥<bc> ì¶”ê<b0>€<ed>•œ<eb>‹¤.


~~~{.r}
ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha=0.1)
~~~



~~~{.output}
Error in ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)): object 'surveys.complete' not found

~~~

- <ec>ƒ‰<ec>ƒ<ec>„ ì¶”ê<b0>€<ed>•œ<eb>‹¤.


~~~{.r}
ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha=0.1, color = "blue")
~~~



~~~{.output}
Error in ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)): object 'surveys.complete' not found

~~~

### <ec>ƒ<ec> ê·¸ë¦¼

ê°<81> ì¢…ë³„ë¡<9c> ì²´ì¤‘ ë¶„í¬ë¥<bc> <ec>‹œê°í™”<ed>•œ<eb>‹¤.


~~~{.r}
ggplot(data = surveys.complete, aes(x = species_id,  y = weight)) +
                   geom_boxplot()
~~~



~~~{.output}
Error in ggplot(data = surveys.complete, aes(x = species_id, y = weight)): object 'surveys.complete' not found

~~~

<ec>ƒ<ec>ê·¸ë¦¼<ec>— <ec> <ec>„ ì¶”ê<b0>€<ed>•´<ec>„œ, <ed>Š¹<ec>´<ed>•œ ê´€ì¸¡ì ê³<bc> ë§ì´ ê´€ì¸¡ëœ ì¸¡ì •ê°’ì„ ë³<bc> <ec>ˆ˜ <ec>ˆ<eb>‹¤.


~~~{.r}
ggplot(data = surveys.complete, aes(x = species_id, y = weight)) +
                   geom_jitter(alpha = 0.3, color = "tomato") +
                   geom_boxplot(alpha = 0)
~~~



~~~{.output}
Error in ggplot(data = surveys.complete, aes(x = species_id, y = weight)): object 'surveys.complete' not found

~~~

<ec>ƒê¸<b0> <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>—<ec>„œ <ec>ƒ<ec>ê·¸ë¦¼<ec>´ ì§€<ed>„° ê³„ì¸µ <ec>œ„<ec>— <eb>†“<ec>¸ ë°©ì‹<ec>— ì£¼ëª©<ed>•œ<eb>‹¤.
`geoms` <ec>ˆœ<ec>„œë¥<bc> ì¡°ì •<ed>•˜ê³<a0>, <ed>ˆ¬ëª…ë„ë¥<bc> ì¡°ì ˆ<ed>•´ <ed>”Œë¡<af><ec>— ê³„ì¸µ<ec>„ <ec>Œ“<eb>Š” ë°©ì‹<ec>„ <ec> œ<ec>–´<ed>•œ<eb>‹¤.

> ### <eb>„<ec> „ê³¼ì œ {.challenge}
>
> `hindfoot_length`<ec>— <eb><8c>€<ed>•œ <ec>ƒ<ec>ê·¸ë¦¼<ec>„ <ec>ƒ<ec>„±<ed>•œ<eb>‹¤.

### <ec>‹œê³„ì—´ <eb>°<ec>´<ed>„° <ec>‹œê°í™”

ê°<81> ì¢…ë³„ë¡<9c> <eb>…„<eb>„ë³<84> ê°œì²´<ec>ˆ˜ë¥<bc> ê³„ì‚°<ed>•œ<eb>‹¤.
<ec>´ <ec>‘<ec>—…<ec>„ <ec>ˆ˜<ed>–‰<ed>•˜ê¸<b0> <ec>œ„<ed>•´<ec>„œ<eb>Š” ë¨¼ì<a0>€ <eb>°<ec>´<ed>„°ë¥<bc> ê·¸ë£¹ì§‘ë‹¨<ed>™”<ed>•˜ê³<a0>, ê°<81> ê·¸ë£¹ë§ˆë‹¤ <ed>•´<eb>‹¹ <eb> ˆì½”ë“œ ê°œìˆ˜ë¥<bc> <ec>„¼<eb>‹¤.



~~~{.r}
yearly.counts <- surveys.complete %>%
                 group_by(year, species_id) %>%
                 tally
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'surveys.complete' not found

~~~

`x`ì¶•ì— <ec>—°<eb>„, `y` ì¶•ì— ê°œìˆ˜ë¥<bc> <eb>†“ê³<a0> ì§ì„ <ec>œ¼ë¡<9c> <ec>‹œê°„ì— <eb>”°<eb>¼ ê²½ê³¼<ed>•œ <ec> •ë³´ë<a5><bc> <ec>‹œê°í™”<ed>•œ<eb>‹¤.


~~~{.r}
ggplot(data = yearly.counts, aes(x = year, y = n)) +
                  geom_line()
~~~



~~~{.output}
Error in ggplot(data = yearly.counts, aes(x = year, y = n)): object 'yearly.counts' not found

~~~

ë¶ˆí–‰<ed>•˜ê²Œë„, <ec>ƒê¸<b0> ê·¸ë˜<ed>”„<eb>Š” <ec>›<ed>•˜<eb>Š” ë°”ê<b0>€ <ec>•„<eb>‹Œ<eb>°, <ec>´<ec>œ <eb>Š” ëª¨ë“  ì¢…ì— <eb><8c>€<ed>•´ <eb>°<ec>´<ed>„°ë¥<bc> <ec>‹œê°í™”<ed>•˜ê²<8c> ëª…ë ¹<ec>–´ë¥<bc> <ec> „<ec>†¡<ed>–ˆê¸<b0> <eb>•Œë¬¸ì´<eb>‹¤.
`species_id`ë¡<9c> <ec>‹œê°í™”<ed>•œ <eb>°<ec>´<ed>„°ë¥<bc> ìª¼ê°  <ed>›„<ec>— `ggplot` ëª…ë ¹<ec>–´ë¡<9c> <ec>‹œê°í™”<ed>•˜ê²<8c> <ed>•œ<eb>‹¤.


~~~{.r}
ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id)) +
  geom_line()
~~~



~~~{.output}
Error in ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id)): object 'yearly.counts' not found

~~~

<ec>ƒ‰<ec>ƒ<ec>„ ì¶”ê<b0>€<ed>•˜ê²<8c> <eb>˜ë©<b4>, ê·¸ë˜<ed>”„<ec>—<ec>„œ ê°œì²´ë¥<bc> <ec>‹ë³„í•˜ê²<8c> <eb>œ<eb>‹¤.


~~~{.r}
ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()
~~~



~~~{.output}
Error in ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id, : object 'yearly.counts' not found

~~~

###  ì¸¡ë©´ë³´ì—¬ì£¼ê¸°(faceting)

`ggplot` <ec>—<eb>Š” *ì¸¡ë©´ ë³´ì—¬ì£¼ê¸°(faceting)* <eb>¼<eb>Š” <ed>Š¹<ec>ˆ˜<ed>•œ ê¸°ëŠ¥<ec>´ <ec>ˆ<ec>–´<ec>„œ, <ed>Š¹<ec> • <ec>š”<ec>¸<ec>— <eb>”°<eb>¼
ê·¸ë˜<ed>”„ <ed>•˜<eb>‚˜ë¥<bc> <eb>‹¤<ec>ˆ˜ ê·¸ë˜<ed>”„ë¡<9c> ìª¼ê°¤ <ec>ˆ˜ <ec>ˆ<eb>‹¤. <ec>˜ˆë¥<bc> <eb>“¤<ec>–´, ê°<81> ì¢…ë§ˆ<eb>‹¤ <ec>‹œê³„ì—´ ê·¸ë˜<ed>”„ë¥<bc> ë³„ë„ë¡<9c> 
<eb>„<ec>‹<ed>™”<ed>•  <ec>ˆ˜ <ec>ˆ<eb>‹¤.


~~~{.r}
ggplot(data = yearly.counts, aes(x = year, y = n, color = species_id)) +
  geom_line() + facet_wrap(~species_id)
~~~



~~~{.output}
Error in ggplot(data = yearly.counts, aes(x = year, y = n, color = species_id)): object 'yearly.counts' not found

~~~

ê´€ì¸¡ëœ ê°<81> ê°œì²´ <ec>„±ë³„ì— <eb>”°<eb>¼ ê·¸ë˜<ed>”„<ec>— ì§ì„ <ec>„ ìª¼ê°œê³ ì <ed>•œ<eb>‹¤.
<ec>´ <ec>‘<ec>—…<ec>„ <ec>ˆ˜<ed>–‰<ed>•˜<eb> ¤ë©<b4>, <ec>„±ë³„ë¡œ ê·¸ë£¹<ec>„ ë§Œë“¤<ec>–´ <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>„<ec>— ê°œìˆ˜ë¥<bc> <ec>„¸<ec>–´<ec>•¼ <eb>œ<eb>‹¤.

> ### <eb>„<ec> „ê³¼ì œ {.challenge}
>
> - <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>„<ec>„ <ed>•„<ed>„°ë§í•´<ec>„œ "F" <ed>˜¹<ec><9d>€ "M" ê°’ì„ ê°–ëŠ” <eb> ˆì½”ë“œë§<8c> ê°–ë„ë¡<9d> <ec>‘<ec>—…<ed>•œ<eb>‹¤.
>  
> 
> 
> 
> ~~~{.r}
> sex_values = c("F", "M")
> surveys.complete <- surveys.complete %>%
>            filter(sex %in% sex_values)
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in eval(expr, envir, enclos): object 'surveys.complete' not found
> 
> ~~~
> 
> - <ec>—°<eb>„(`year`), ê°œì²´ <ec>‹ <ec>›<ec> •ë³<b4>(`special_id`), <ec>„±(`sex`) ë³„ë¡œ ê·¸ë£¹<ec>„ ë§Œë“ <eb>‹¤.
>
> 
> ~~~{.r}
> yearly.sex.counts <- surveys.complete %>%
>                      group_by(year, species_id, sex) %>%
>                      tally
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in eval(expr, envir, enclos): object 'surveys.complete' not found
> 
> ~~~
>
> - (ê°œë³„ ê·¸ë˜<ed>”„ <eb>‚´ë¶€<ec>—) <ec>„±ë³„ë¡œ ìª¼ê°œ<eb>Š” ì¸¡ë©´ë³´ì—¬ì£¼ê¸° <ed>”Œë¡<af><ec>„ <ec>ƒ<ec>„±<ed>•œ<eb>‹¤.
>
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = species_id, group = sex)) +
>   geom_line() + facet_wrap(~ species_id)
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = species_id, : object 'yearly.sex.counts' not found
> 
> ~~~
>
> - <eb>…¼ë¬¸ì¶œ<ed>Œ<ec>œ¼ë¡<9c> <ed>°<ec>ƒ‰ ë°°ê²½<ec>´ ì¢€<eb>” ê°€<eb>…<ec>„±<ec>„ ì¢‹ê²Œ <ed>•œ<eb>‹¤.
> ` theme_bw()` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ed>°<ec>ƒ‰ ë°°ê²½<ec>„ <ec> <ec>š©<ed>•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = species_id, group = sex)) +
>   geom_line() + facet_wrap(~ species_id) + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = species_id, : object 'yearly.sex.counts' not found
> 
> ~~~
> 
> > - ì¢…ë<8c>€<ec>‹ <ec>— <ec>„±ë³„ë¡œ <ec>ƒ‰<ec>ƒ<ec>„ <ec>…<ed><98>€<ec>„œ ê·¸ë˜<ed>”„ ê°€<eb>…<ec>„±<ec>„ ì¢‹ê²Œ ë§Œë“¤ <ec>ˆ˜ <ec>ˆ<eb>‹¤.
> > (ì¢…ì<9d>€ <ec>´ë¯<b8> ë³„ë„ ê·¸ë˜<ed>”„ë¡<9c> <ec>‹œê°í™”<eb>˜<ec>–´<ec>„œ, <eb>” <ec>˜ <ec>‹ë³„í•˜ê²<8c> ë§Œë“¤ <ed>•„<ec>š”<eb>Š” <ec>—†<eb>‹¤.)
> 
> 
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, group = sex)) +
>   geom_line() + facet_wrap(~ species_id) + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, : object 'yearly.sex.counts' not found
> 
> ~~~
> 
> > - <ec>—°<eb>„<ec>— ê±¸ì³ ê°<81> ì¢…ë³„ë¡<9c> <ed>‰ê·<a0> ì²´ì¤‘<ec>„ <ec>‹œê°í™”<ed>•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> yearly.weight <- surveys.complete %>%
>                  group_by(year, species_id, sex) %>%
>                  summarise(avg_weight = mean(weight, na.rm = TRUE))
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in eval(expr, envir, enclos): object 'surveys.complete' not found
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> ggplot(data = yearly.weight, aes(x=year, y=avg_weight, color = species_id, group = species_id)) +
>   geom_line() + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.weight, aes(x = year, y = avg_weight, color = species_id, : object 'yearly.weight' not found
> 
> ~~~
> 
> > - <ec>‹œê°í™”ë¥<bc> <ec>™œ <ec>´<eb>Ÿ° <eb>‹¨ê³„ë<a5><bc> ë°Ÿì•„<ec>„œ <eb>„<ec>‹<ed>™” <ec> ˆì°¨ë<a5><bc> ê±°ì¹œ<eb>‹¤ê³<a0> <ec>ƒê°í•˜<eb>Š”ê°€?
> > - <ec>ˆ˜ì»·ê³¼ <ec>•”ì»<b7> ì²´ì¤‘<ec>´ <ec>ƒ<eb>‹¹<ed>ˆ ì°¨ì´ê°€ <eb>‚˜<ec>„œ <ec>„±ë³„ë¡œ ë³„ë„ <ec>‹œê°í™”ë¥<bc> <ec>ˆ˜<ed>–‰<ed>•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> ggplot(data = yearly.weight, aes(x=year, y=avg_weight, color = species_id, group = species_id)) +
>   geom_line() + facet_wrap(~ sex) + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.weight, aes(x = year, y = avg_weight, color = species_id, : object 'yearly.weight' not found
> 
> ~~~
> ì§€ê¸ˆê¹Œì§€ <ec>‹œê°í™” ê²°ê³¼ê°€ <ec>ƒ<eb>‹¹<ed>ˆ ì¢‹ì•˜ì§€ë§<8c>, <ec>•„ì§<81> ì¶œíŒ<ed>•˜ê¸°ì—<eb>Š” ë§ì´ ë¶€ì¡±í•˜<eb>‹¤.
> <ec>‹œê°í™” <ec>‚°ì¶œë¬¼ ê²°ê³¼ë¥<bc> <ed>–¥<ec>ƒ<ed>•  <ec>ˆ˜ <ec>ˆ<eb>Š” <eb>‹¤ë¥<b8> ë°©ë²•<ec><9d>€ ë¬´ì—‡<ec>´ <ec>ˆ<ec>„ê¹<8c>?
> `ggplot2` [ì»¨ë‹ìª½ì<a7>€(cheat sheet)](https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf)ë¥<bc> 
> ì°¸ì¡°<ed>•˜ê³<a0>, <ec> <ec>–´<eb>„ <ec>„¸ê°€ì§€ <ec>•„<ec>´<eb>””<ec>–´ë¥<bc> <ec> <ec>–´ë³¸ë‹¤.
> 
> `x`ì¶•ê³¼ `y`ì¶•ì— 'year'<ec><99>€ 'n' ë³´ë‹¤ <eb>” ë§ì<9d>€ <ec> •ë³´ë<a5><bc> <ec> „<eb>‹¬<ed>•˜<eb>„ë¡<9d> ë³€ê²½í•˜ê³<a0>, ê·¸ë˜<ed>”„<ec>— <ec> œëª©ì„ ì¶”ê<b0>€<ed>•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, group = sex)) +
>   geom_line() +
>   facet_wrap(~ species_id) +
>   labs(title = 'Observed species in time',
>        x = 'Year of observation',
>        y = 'Number of species') + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, : object 'yearly.sex.counts' not found
> 
> ~~~
> 
> <ec>´<ec> œ ì¢€<eb>” <eb>‚˜<ec>•„<ec> ¸<ec>„œ <ed>›¨<ec>”¬ <eb>” ë§ì<9d>€ <ec> •ë³´ë<a5><bc> ì£¼ëŠ” `x`, `y` ì¶<95> ëª…ì¹­<ec>œ¼ë¡<9c> ë°”ê¿¨ì§€ë§<8c>, ê°€<eb>…<ec>„±<ec>´ <eb>–¨<ec>–´ì§€ê³<a0> <ec>ˆ<eb>‹¤.
> ê¸€<ec> <ed>¬ê¸°ë<a5><bc> ë³€ê²½í•˜ê³<a0> ê¸€<ec>ì²´ë„ ë³€ê²½í•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, group = sex)) +
>   geom_line() +
>   facet_wrap(~ species_id) +
>   labs(title = 'Observed species in time',
>        x = 'Year of observation',
>        y = 'Number of species') +
>   theme(text=element_text(size=16, family="Arial")) + theme_bw()
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, : object 'yearly.sex.counts' not found
> 
> ~~~
> 
> ì¡°ì‘<ec>„ <ed>•œ <eb>‹¤<ec>Œ<ec>—, `x` ì¶•ì´ <ec>—¬<ec> „<ed>ˆ <ec> <ec> ˆ<ed>•œ ê°€<eb>…<ec>„±<ec>„ <ec> „<eb>‹¬<ed>•˜ê³<a0> <ec>ˆì§€ <ec>•Š<ec>Œ<ec>„ ë³<bc> <ec>ˆ˜ <ec>ˆ<eb>‹¤.
> <eb>¼ë²<a8> ë°©í–¥<ec>„ ë³€ê²½í•´<ec>„œ <ec>„œë¡<9c> ê²¹ì³ì§€ì§€ <ec>•Š<eb>„ë¡<9d> <ec>ˆ˜<ed>‰ <ed>˜¹<ec><9d>€ <ec>ˆ˜ì§ë°©<ed>–¥<ec>œ¼ë¡<9c> ë°”ê¾¼<eb>‹¤.
> 90<eb>„ ê°ë„ë¥<bc> <ec>‚¬<ec>š©<ed>•˜ê±°ë‚˜, <eb><8c>€ê°ì„  ë°©í–¥<ec>œ¼ë¡<9c> <eb>¼ë²¨ë°©<ed>–¥<ec>„ ë³€ê²½í•˜<eb>„ë¡<9d> <ec> <ec> ˆ<ed>•œ ê°ë„ë¡<9c> ë°”ê¾¸<eb>Š” <ec>‹¤<ed>—˜<ec>„ ì§„í–‰<ed>•œ<eb>‹¤. 
> 
> 
> ~~~{.r}
> ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, group = sex)) +
>     geom_line() +
>     facet_wrap(~ species_id) +
>     theme_bw() +
>     theme(axis.text.x = element_text(colour="grey20", size=12, angle=90, hjust=.5, vjust=.5),
>           axis.text.y = element_text(colour="grey20", size=12),
>           text=element_text(size=16, family="Arial")) +
>     labs(title = 'Observed species in time',
>          x = 'Year of observation',
>          y = 'Number of species')
> ~~~
> 
> 
> 
> ~~~{.output}
> Error in ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = sex, : object 'yearly.sex.counts' not found
> 
> ~~~
> 
> <ec>´<ec> œ, <eb>¼ë²¨ì„ <ed>‚¤<ec>›Œ<ec>„œ ê°€<eb>…<ec>„±<ec>´ <eb>” ì¢‹ì•„ì¡Œì<a7>€ë§<8c>, ê°œì„ <ed>•  <ec>—¬ì§€<eb>Š” <eb>‚¨<ec>•„ <ec>ˆ<eb>‹¤.
> <ec>‹œê°„ì„ 5ë¶„ë§Œ <eb>” <eb>“¤<ec>—¬<ec>„œ <eb>” <eb>‚˜<ec><9d>€ <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>„ ë§Œë“¤<ec>–´ <eb>‚´<eb>„ë¡<9d> <ed>•˜<eb>‚˜ <ed>˜¹<ec><9d>€ <eb>‘ê°€ì§€ <ec>‘<ec>—…<ec>„ <ec>‹œ<eb>„<ed>•´ ë³¸ë‹¤.
> `ggplot2` ì»¨ë‹ ìª½ì<a7>€ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ, <ec>ƒê¸<b0> <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>— <ec> <ec>š©<ed>•   <ec>˜ê°ì„ ë°›ì•„ë³¸ë‹¤.
> 
> <eb>‹¤<ec>Œ<ec>— ëª‡ê<b0>€ì§€ <ec>ƒê°ë‚œ ê²ƒì´ <ec>ˆ<eb>‹¤:
> 
> - <ec>„  <eb>‘ê»˜ë<a5><bc> ë³€ê²½í•  <ec>ˆ˜ <ec>ˆ<eb>Š”ì§€ <ec>‚´<ed>´ë³¸ë‹¤.
> - ë²”ë<a1>€(legend) ëª…ì¹­<ec>„ ë³€ê²½í•  ë°©ë²•<ec>„ <ec>‚´<ed>´ë³¸ë‹¤. ë²”ë<a1>€ <eb>¼ë²¨ì<9d>€ <ec>–´<eb>–¤ê°€?
> - <ec>™¸<ec>–‘<ec>„ ì¢‹ê²Œ <ed>•˜<eb>Š”<eb>° <eb>‹¤ë¥<b8> <ec>ƒ‰<ec>ƒ <ed>Œ”<eb> ˆ<ed>Š¸ë¥<bc> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. (http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/)
> 
> <ec>™„ë²½í•œ <ec>‹œê°í™” <ec>‚°ì¶œë¬¼<ec>´ <eb>„ì¶œë˜ë©<b4>, <ec>„ <ed>˜¸<ed>•˜<eb>Š” ê·¸ë¦¼<ed>ŒŒ<ec>¼ <ed>˜•<ec>‹<ec>œ¼ë¡<9c> <ec><a0>€<ec>¥<ed>•œ<eb>‹¤.
> ê·¸ë¦¼ <ed>­ê³<bc> <eb>†’<ec>´ë¥<bc> ì§€<ec> •<ed>•´<ec>„œ <ed>¬ê¸°ë<a5><bc> <ec>‰½ê²<8c> ë³€ê²½í•œ<eb>‹¤.
> 
> 
> ~~~{.r}
> ggsave("observed_species_in_time.png", width=15, height=10)
> ~~~


> ### `Error in plot.new() : figure margins too large` <ec>‹œê°í™” ë¬¸ì œ <ed>•´ê²<b0> {.callout}
>
> ê·¸ë¦¼<ec>— ì¢Œìš°<ec>ƒ<ed>•˜ <ec>—¬ë°<b1>(margin)<ec>´ ë§ì<a7>€ <ec>•Š<eb>Š” <ec>˜¤ë¥˜ê<b0>€ ë°œìƒ<ed>•˜<eb>Š” ê²½ìš° 
> ì¢Œìš°<ec>ƒ<ed>•˜ <ec>—¬ë°±ì„ ê¸°ë³¸<ec>„¤<ec> • `par(mar=c(1,1,1,1))` ëª…ë ¹<ec>–´ë¥<bc> <ed>†µ<ed>•´ <ed>•´ê²°í•œ<eb>‹¤. 
>
> ~~~ {.r}
> plot(x = surveys.complete$weight, y = surveys.complete$hindfoot_length)
> Error in plot.new() : figure margins too large
> ~~~














### ì°¸ê³ <ec>ë£<8c>

[^figshare-wired]: ["figshare wants to open up scientific data to the world"](http://www.wired.co.uk/news/archive/2014-07/25/figshare)
