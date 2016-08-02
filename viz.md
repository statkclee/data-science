---
layout: page
title: <eb>°<ec>´<ed>„° ê³¼í•™
subtitle: <ec>‹œê°í™”
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



> ## <ed>•™<ec>Šµ ëª©í‘œ  {.objectives}
>
> * <eb>°<ec>´<ed>„° <ec>‹œê°í™”<ec>˜ ì¤‘ìš”<ec>„±<ec>„ <ec>´<ed>•´<ed>•œ<eb>‹¤.
> * <ec>‹œê°í™” <ec>–¼ê°œë<a5><bc> <ed>†µ<ed>•´ <ec>‹œê°í™”ë¥<bc> ëª©ì ê³<bc> ë°©í–¥<ec>„ <ec>´<ed>•´<ed>•œ<eb>‹¤.


### Anscombe 4ì¢…ë¥˜ <eb>°<ec>´<ed>„°(Anscombe's Quartet) [^anscombe] [^anscombe-jstor]

Anscombe<eb>Š” 1973<eb>…„ <eb>™<ec>¼<ed>•œ <ed>†µê³„ëŸ‰<ec>„ ê°–ëŠ” 4ì¢…ë¥˜ <eb>°<ec>´<ed>„°<ec>…‹<ec>„ ë§Œë“¤<ec>–´<ec>„œ <ec>‹œê°í™”<ec>˜ ì¤‘ìš”<ec>„±<ec>„ ê³µê°œ<ed>–ˆ<eb>‹¤.

|  <ed>†µê³„ëŸ‰     |   ê°<92>  |
|-------------|-------|
|  <ed>‰ê·<a0>(`x`)  |  9    |
|  ë¶„ì‚°(`x`)  |  11   |
|  <ed>‰ê·<a0>(`y`)  |  7.5  |
|  ë¶„ì‚°(`y`)  |  4.1  |
|  <ec>ƒê´€ê³„ìˆ˜   |  0.82  |
|  <ed>šŒê·€<ec>‹     |  y = 3.0 + 0.5*x |



[^anscombe]: [Anscombe quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet)
[^anscombe-jstor]: Anscombe, F. J. (1973). "Graphs in Statistical Analysis". American Statistician 27 (1): 17<e2>€<93>21.



~~~{.r}
data(anscombe)
anscombe <- tbl_df(anscombe)
anscombe
~~~



~~~{.output}
# A tibble: 11 x 8
      x1    x2    x3    x4    y1    y2    y3    y4
   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1     10    10    10     8  8.04  9.14  7.46  6.58
2      8     8     8     8  6.95  8.14  6.77  5.76
3     13    13    13     8  7.58  8.74 12.74  7.71
4      9     9     9     8  8.81  8.77  7.11  8.84
5     11    11    11     8  8.33  9.26  7.81  8.47
6     14    14    14     8  9.96  8.10  8.84  7.04
7      6     6     6     8  7.24  6.13  6.08  5.25
8      4     4     4    19  4.26  3.10  5.39 12.50
9     12    12    12     8 10.84  9.13  8.15  5.56
10     7     7     7     8  4.82  7.26  6.42  7.91
11     5     5     5     8  5.68  4.74  5.73  6.89

~~~

#### Anscombe <eb>°<ec>´<ed>„°<ec>…‹ 4ì¢<85> ê¸°ìˆ <ed>†µê³„ëŸ‰


~~~{.r}
# x1, x2, x3, x4 <U+653C><U+3E64>‰ê·ãå<U+3E30>
anscombe %>% select(x1,x2,x3,x4) %>% 
summarize(x1Mean=round(mean(x1),1), y2Mean=round(mean(x2),2), y3Mean=round(mean(x3),1), y4Mean=round(mean(x4),1))
~~~



~~~{.output}
# A tibble: 1 x 4
  x1Mean y2Mean y3Mean y4Mean
   <dbl>  <dbl>  <dbl>  <dbl>
1      9      9      9      9

~~~



~~~{.r}
# x1, x2, x3, x4 ë¶„ì‚°
anscombe %>% select(x1,x2,x3,x4) %>% 
summarize(x1Var=round(var(x1),1), x2Var=round(var(x2),1), x3Var=round(var(x3),1), x4Var=round(var(x4),1))
~~~



~~~{.output}
# A tibble: 1 x 4
  x1Var x2Var x3Var x4Var
  <dbl> <dbl> <dbl> <dbl>
1    11    11    11    11

~~~



~~~{.r}
# y1, y2, y3, y4 <U+653C><U+3E64>‰ê·ãå<U+3E30>
anscombe %>% select(y1,y2,y3,y4) %>% 
summarize(y1Mean=round(mean(y1),1), y2Mean=round(mean(y2),2), y3Mean=round(mean(y3),1), y4Mean=round(mean(y4),1))
~~~



~~~{.output}
# A tibble: 1 x 4
  y1Mean y2Mean y3Mean y4Mean
   <dbl>  <dbl>  <dbl>  <dbl>
1    7.5    7.5    7.5    7.5

~~~



~~~{.r}
# y1, y2, y3, y4 ë¶„ì‚°
anscombe %>% select(y1,y2,y3,y4) %>% 
summarize(y1Var=round(var(y1),1), y2Var=round(var(y2),1), y3Var=round(var(y3),1), y4Var=round(var(y4),1))
~~~



~~~{.output}
# A tibble: 1 x 4
  y1Var y2Var y3Var y4Var
  <dbl> <dbl> <dbl> <dbl>
1   4.1   4.1   4.1   4.1

~~~



~~~{.r}
# x1:y1 ~ x4:y4 <U+653C><U+3E63>ƒê´€ê³„ìˆ˜
anscombe %>% 
summarise(cor1=round(cor(x1,y1),2), cor2=round(cor(x2,y2),2), cor3=round(cor(x3,y3),2),cor4=round(cor(x4,y4),2))
~~~



~~~{.output}
# A tibble: 1 x 4
   cor1  cor2  cor3  cor4
  <dbl> <dbl> <dbl> <dbl>
1  0.82  0.82  0.82  0.82

~~~



~~~{.r}
# y1:x1-x4 ~ y1:x1-x4 <U+653C><U+3E64>šŒê·€ë¶„ì„
lm_fit <- function(y1, x1, dat) {
  the_fit <- lm(y1 ~ x1, dat)
  setNames(data.frame(t(coef(the_fit))), c("intercept", "slope"))
}
gfits <- anscombe %>%
  do(reg1 = lm_fit(y1, x1, .), reg2=lm_fit(y2, x2, .), 
     reg3=lm_fit(y3, x3, .), reg4=lm_fit(y4, x4, .))

unlist(gfits$reg1)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg2)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg3)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~



~~~{.r}
unlist(gfits$reg4)
~~~



~~~{.output}
intercept     slope 
3.0000909 0.5000909 

~~~


#### Anscombe <eb>°<ec>´<ed>„°<ec>…‹ 4ì¢<85> <ec>‹œê°í™”


~~~{.r}
p1 <- ggplot(anscombe) + geom_point(aes(x1, y1), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 1")
p2 <- ggplot(anscombe) + geom_point(aes(x2, y2), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 2")
p3 <- ggplot(anscombe) + geom_point(aes(x3, y3), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 3")
p4 <- ggplot(anscombe) + geom_point(aes(x4, y4), color = "darkorange", size = 3) + theme_bw() + scale_x_continuous(breaks = seq(0, 20, 2)) + scale_y_continuous(breaks = seq(0, 12, 2)) + geom_abline(intercept = 3, slope = 0.5, color = "cornflowerblue") + expand_limits(x = 0, y = 0) + labs(title = "dataset 4")

multiplot(p1, p2, p3, p4, cols=2, main="Anscombe's Quartet")
~~~

<img src="fig/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

~~~{.output}
[1] "Anscombe's Quartet"

~~~

### <ec>‹œê°í™” [^tamara] 

ì»´í“¨<ed>„°ë¥<bc> ê¸°ë°˜<ec>œ¼ë¡<9c> <ed>•œ <ec>‹œê°í™” <ec>‹œ<ec>Š¤<ed>…œ<ec><9d>€ <ec>‹œê°ì <ec>œ¼ë¡<9c> <eb>°<ec>´<ed>„°ë¥<bc> <ed>‘œ<ed>˜„<ed>•¨<ec>œ¼ë¡<9c> <ec>¸<ed>•´<ec>„œ 
<ec>‚¬<eb>Œ<eb>“¤<ec>´ <ec>‘<ec>—…<ec>„ <eb>”<ec>š± <ed>š¨<ec>œ¨<ec> <ec>œ¼ë¡<9c> <ec>ˆ˜<ed>–‰<ed>•  <ec>ˆ˜ <ec>ˆ<eb>„ë¡<9d> <eb>•<eb>Š”<eb>‹¤.

<ec>—¬ê¸°ì„œ <ec>‹œê°í™”ê°€ <ec> <ed>•©<ed>•œ <ec>ƒ<ed>™©<ec><9d>€ <ec>¸ê³µì<a7>€<eb>Š¥ ë°<8f> <ec> „<ec>‚¬<ed>™”ë¥<bc> <ed>†µ<ed>•´ <ec>‚¬<eb>Œ<ec>„ <eb><8c>€ì²´í•˜ê¸<b0> ë³´ë‹¤<eb>Š” <ec>¸ê°„ëŠ¥<eb> ¥<ec>„ ì¦ê°•<ec>‹œ<ed>‚¤<eb>Š”<eb>° <ec>œ <ec>š©<ed>•˜<eb>‹¤.
<eb>”°<eb>¼<ec>„œ, <ec>™„<ec> „ <ec><eb>™<ed>™” <ed>•´ê²°ì±…<ec>´ ì¡´ì¬<ed>•˜ê³<a0> <ec>‹ ë¢°ì„±<ec>´ <ec>ˆ<eb>Š” ê²½ìš° <ec>‹œê°í™”ê°€ ê·¸ë‹¤ì§€ <ed>•„<ec>š”<ed>•˜ì§€<eb>Š” <ec>•Š<eb>Š”<eb>‹¤.
<eb>˜<ed>•œ, ë§ì<9d>€ ë¶„ì„ë¬¸ì œ<ec>—<eb>Š” <ec>–´<eb>–¤ ì§ˆë¬¸<ec>„ <eb>˜<ec> ¸<ec>•¼ <eb>˜<eb>Š”ì§€ <ec>‚¬<ec> „<ec>— <ec>•Œê³<a0> <ec>ˆ<eb>Š” ê²½ìš°ê°€ <ec> <ec>–´, ëª…ì„¸ê°€ ë¶„ëª…<ed>•˜ì§€ <ec>•Š<eb>Š” ê²½ìš°ê°€ <ec>ˆ<eb>Š”<eb>°,
<ec>´<eb>Ÿ° ëª©ì <ec>— <ec>œ <ec>š©<ed>•˜<eb>‹¤.

> ### <ec>‹œê°í™” {.callout}
> 
> "Computer-based visualization systems provide visual representations of datasets
 designed to help people carry out tasks more effectively" -- Tamara Munzner


[^tamara]: [Tamara Munzner. Visualization Analysis and Design. A K Peters Visualization Series, CRC Press, 2014](http://www.cs.ubc.ca/~tmm/vadbook/)

#### <ec>‹œê°í™”ê°€ <ec>™œ <ed>•„<ec>š”<ed>•œê°€?

**<ec>¸ì§€ë¶€<ed>•˜(cognitive load)**ë¥<bc> **<ec>‹œê°ì  ì§€ê°<81>(perception)**<ec>œ¼ë¡<9c> ë°”ê¿” <ed>•´<eb>‹¹ <ec>‘<ec>—…<ec>„ <eb>”<ec>š± <ed>š¨ê³¼ì <ec>œ¼ë¡<9c> ì²˜ë¦¬<ed>•˜<eb>Š”<eb>° <ec>‹œê°í™”ë¥<bc> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤.


~~~{.r}
library(datasets)
women
~~~



~~~{.output}
   height weight
1      58    115
2      59    117
3      60    120
4      61    123
5      62    126
6      63    129
7      64    132
8      65    135
9      66    139
10     67    142
11     68    146
12     69    150
13     70    154
14     71    159
15     72    164

~~~

`women` <eb>°<ec>´<ed>„°ê°€ <ec> •<eb> ¬<ec>´ <eb>˜<ec>–´ <ec>ˆ<ec>–´<ec>„œ, <ec>‹ <ec>¥<ec>´ ì»¤ì§<ec>— <eb>”°<eb>¼ ì²´ì¤‘<ec>´ ì¦ê<b0>€<ed>•˜<eb>Š” ê²ƒì„ <ec>•Œ <ec>ˆ˜ <ec>ˆì§€ë§<8c>, <eb>°<ec>´<ed>„°ë§<8c> ë³´ê³  <ec>´<ed>•´<ed>•˜<eb> ¤ë©<b4>
<ec>¸ì§€<ec> <ec>œ¼ë¡<9c> <eb>°<ec>´<ed>„° <ed>•œì¤„ì„ <ec>½ê³<a0> ë¨¸ë¦¬<ec>†<ec>œ¼ë¡<9c> <ec>ƒê°í•˜ê³<a0>, <eb>‘ë²ˆì§¸ ì¤„ì„ <ec>½ê³<a0> <ec>ƒê°í•˜ê³<a0>, ... <ec>´<eb>Ÿ° ê³¼ì •<ec>„ ë°˜ë³µ<ed>•˜ë©´ì„œ <ec>¸ì§€<ec>  ë¶€<ed>•˜ê°€ ì¦ê<b0>€<ed>•˜ê²<8c> <eb>œ<eb>‹¤.
<ed>•˜ì§€ë§<8c>, <ec>‹œê°ì <ec>œ¼ë¡<9c> <ed>‘œ<ed>˜„<ed>•˜ê²<8c> <eb>˜ë©<b4> <ed>•œ<eb>ˆˆ<ec>— <ec>‹ <ec>¥ê³<bc> ì²´ì¤‘ ê´€ê³„ë<a5><bc> ë³<bc> <ec>ˆ˜ <ec>ˆ<eb>‹¤.


~~~{.r}
women %>% ggplot(aes(y=weight, x=height)) + geom_point(color='blue', size=2) +
  geom_smooth(color='pink')
~~~

<img src="fig/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

#### <ec>‹œê°í™” ë¶„ì„ <ec>–¼ê°<9c> êµ¬ì„±<ec>š”<ec>†Œ

<ec>‹œê°í™” ë¶„ì„ <ec>–¼ê°œëŠ” 4ê°€ì§€ ë¶€ë¶„ìœ¼ë¡<9c> êµ¬ì„±<eb>œ<eb>‹¤. 

- <ec> „ë¬¸ì˜<ec>—­ : ìµœì¢… <ec>‚¬<ec>š©<ec> ê³ ê°<ec>´ <eb>ˆ„êµ°ì¸ê°€?
- ì¶”ìƒ<ed>™”
    + <ec> „ë¬¸ì˜<ec>—­<ec>˜ êµ¬ì²´<ec> <ec>¸ <ec> <ec>„ <ec>‹œê°í™” <ec>š©<ec>–´ë¡<9c> ë²ˆì—­
        * **<eb>°<ec>´<ed>„° ì¶”ìƒ<ed>™”** : <ec>‹œê°í™”<ed>•˜<eb>Š” ê²ƒì´ ë¬´ì—‡(what)<ec>¸ê°€?
        * **<ec>‘<ec>—… ì¶”ìƒ<ed>™”** : <ec>™œ(why) <ec>‚¬<ec>š©<ec>ê°€ <eb>ˆˆ<ec>„ <eb>Œë¦¬ëŠ”ê°€?
- <ed>‘œ<ed>˜„<ec>–‘<ec>‹(idiom)
    + <eb>°<ec>´<ed>„°ê°€ <ec>–´<eb>–»ê²<8c>(How) <ec>‹œê°í™”<eb>˜<eb>Š”ê°€?
    	* **<ec>‹œê°ì  <ec>¸ì½”ë”© <ed>‘œ<ed>˜„<ec>–‘<ec>‹** : <ec>‹œê°í™”<ed>•˜<eb>Š” ë°©ë²•
    	* **<ec>ƒ<ed>˜¸<ec>‘<ec>š© <ed>‘œ<ed>˜„<ec>–‘<ec>‹** : ì¡°ì‘<ed>•˜<eb>Š” ë°©ë²•
- <ec>•Œê³ ë¦¬ì¦<98>
	+ <ed>š¨<ec>œ¨<ec>  <ec>—°<ec>‚°ë°©ë²•    	

[Munzner, Tamara. "A nested model for visualization design and validation." Visualization and Computer Graphics, IEEE Transactions on 15.6 (2009): 921-928.](http://www.cs.ubc.ca/~tmm/talks/iv09/nestedmodel-4x4.pdf)

<img src="fig/viz-framework.png" alt="RStudio" width="77%" />

#### <ec>‹œê°í™” ë¶„ì„ <ec> ‘ê·¼ë°©<ed>–¥

<ec>‹œê°í™” <ec>‹œ<ec>Š¤<ed>…œ <ec>‹¤<ed>–‰<ec>‹œê°<84>, ë©”ëª¨ë¦<ac> <ec>‚¬<ec>š©<eb>Ÿ‰ <eb>“±<ec>„ ì¸¡ì •<ed>•˜ê³<a0>, <ec>—°<ec>‚° ë³µì¡<ec>„±<ec>„ ë¶„ì„<ed>•˜<eb>Š” <ec>•Œê³ ë¦¬ì¦<98> <ec>‘<ec>—…<ec><9d>€ ì»´í“¨<ed>„° ê³¼í•™<ec><ec>˜ ëª«ì´<eb>‹¤.
<ec>—¬<eb>Ÿ¬ê°€ì§€ <eb><8c>€<ec>•ˆ <ec>‹œ<ec>Š¤<ed>…œ <ec>•„<ed>‚¤<ed>…ì²˜ë<a5><bc> <ec> •<eb>‹¹<ed>™”<ed>•˜ê³<a0> <ec>‹œê°ì  <ec>¸ì½”ë”© ë°©ë²•ê³<bc> <ec>ƒ<ed>˜¸<ec>‘<ec>š©<ed>•˜<eb>Š” <ed>‘œ<ed>˜„<ec>–‘<ec>‹<ec>„ <ec>„¤ê³„í•˜<eb>Š” ê²ƒì<9d>€ <ec>‹œ<ec>Š¤<ed>…œ <ec>„¤ê³„ì<ec>˜ ëª«ì´<eb>‹¤.
<ec>‹œê°í™” <ec>‹œ<ec>Š¤<ed>…œ ê²°ê³¼ë¬¼ì„ <ec> •<eb>Ÿ‰<ec> <ec>œ¼ë¡<9c> ë¶„ì„<ed>•˜ê³<a0>, <ec>‚¬<ec>š©<ec> <ec>¸ê°„ì— <eb><8c>€<ed>•œ <ec>‹¤<ed>—˜<ec>„ ì¶”ì§„<ed>•˜<eb>Š” ê²ƒì<9d>€ <ec>¸ì§€<ec>‹¬ë¦¬í•™<ec><ec>˜ ëª«ì´<eb>‹¤.
<ec>´ë¥<bc> ê°ì‹¸ê³<a0> <ec>ˆ<eb>Š” <eb>°<ec>´<ed>„° ì¶”ìƒ<ed>™”<ec><99>€ <ec>‘<ec>—…ì¶”ìƒ<ed>™”ê°€ <ec>ˆ<eb>Š”<eb>°, <ec>‹œ<ec>Š¤<ed>…œ <ec>„¤ê³„ìê°€ <ec>•<eb>‹¨<ec>—<ec>„œ <ec>„¤ê³„í•˜ë©<b4> <ed>›„<ed>–‰<eb>‹¨<ec>—<ec>„œ <ec>¸ì§€<ec>‹¬ë¦¬í•™<ec>ê°€ ê²€ì¦í•˜ê³<a0>,
ì»´í“¨<ed>„° ê³¼í•™<ec>ê°€ ê°œë°œ<ed>•˜<eb>Š” êµ¬ì¡°ë¥<bc> ê°–ëŠ”<eb>‹¤.

<ec>´ ëª¨ë“  <ec>‹œ<ec>‘<ec><9d>€ <ec> „ë¬¸ì˜<ec>—­<ec>—<ec>„œ ë¬¸ì œ<ec> <ec>„ <ec>¸<ec>‹<ed>•˜ê³<a0> ê¸°ì¡´<ec>˜ <eb>„êµ¬ë<a5><bc> <ec>‚¬<ec>š©<ed>•˜<eb>Š” ëª©í‘œ <ec>‚¬<ec>š©<ec>ë¥<bc> ê´€ì¸¡í•˜<eb>Š” ê²ƒì—<ec>„œ <ec>‹œ<ec>‘<eb>˜<eb>Š”<eb>° <ec>´<eb>Š” <ec>¸ë¥˜í•™<ec>, ë¯¼ì¡±ì§€<eb>¼<eb>Š” ë¶„ì•¼<ec><99>€ <ec>—°ê´€<eb>œ<eb>‹¤.
<eb>”°<eb>¼<ec>„œ, ê¸°ìˆ ì¤‘ì‹¬<ec>œ¼ë¡<9c> ë°–ìœ¼ë¡<9c> <ed>¼<ec> ¸<eb>‚˜ê°<88> <ec>ˆ˜<eb>„ <ec>ˆì§€ë§<8c>, ë¬¸ì œ<ed>•´ê²°ì‘<ec>—…<ec>œ¼ë¡<9c> <ec>‹œê°í™”ë¥<bc> <ed>™œ<ec>š©<ed>•˜<eb>Š” ê²ƒë„ ê°€<eb>Š¥<ed>•œ <ec> ‘ê·¼ë²•<ec>´<eb>‹¤.

> ### <ec>‹œê°í™” <eb>„êµ<ac>{.callout}
> 
> - **ëª…ë ¹<ed>˜•(imperative)**: "ë°©ë²•(how)"<ec>— ì´ˆì , Processing, OpenGL, prefuse
> - **<ec>„ <ec>–¸<ed>˜•(declarative)**: "ë¬´ì—‡(what)"<ec>— ì´ˆì , D3, ggplot2, Protovis 

