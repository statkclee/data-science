---
layout: page
title: 데이터 과학
subtitle: 그래프 한장에 찍기
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



### 패싯이 만병통치약은 아니다. [^viz-multiple-plots]

[^viz-multiple-plots]: [Multiple plots on a page](https://stat545-ubc.github.io/block020_multiple-plots-on-a-page.html)

패싯 기능은 유사한 그래프를 배열형태로 생성하는데 적합한데, 각 패널은 요인에 대한 수준 혹은 다수 요인에 대한 
수준 조합을 표현한다. 실용적인 형태변환(reshape)이 다수 그래프 문제를 이런 "외양"으로 처리하게 만든다.
하지만, 이런 접근법이 실제 세계에 산재한 다중 그래프 요구에 대한 전체 영역을 다루지는 못한다.
때때로, 가상 페이지 한장에 그래프 하나 이상 필요하지만, 이런 그래프가 연관되지 않을 수도 있다.
이런 경우 어떻게 할 것인가?

### `gridExtra` 팩키지를 검토하라 

`ggplot2`를 까보면, `ggplot2`는 `grid` 팩키지를 사용해서 그림을 생성한다.
`gridExtra` 팩키지는 추가로 몇가지 좋은 기능을 제공한다. 가상 페이지 한장에 `ggplot2` 그래프 다수를
위치시켜 도식화할 수 있다.

`gridExtra` 팩키지를 설치하고 나서 확실히 불러온다.


~~~{.r}
# install.packages("gridExtra")
library(gridExtra)
~~~



~~~{.output}
Error in library(gridExtra): there is no package called 'gridExtra'

~~~

### `gapminder` 데이터와 `ggplot2` 팩키지를 불러온다. 


~~~{.r}
library(gapminder)
~~~



~~~{.output}
Error in library(gapminder): there is no package called 'gapminder'

~~~



~~~{.r}
library(ggplot2)
~~~

### `arrangeGrob()` 함수와 친구를 사용

구성되는 그림을 그림객체로 저장하고 나서 `arrangeGrob()` 함수에 전달한다.


~~~{.r}
p_dens <- ggplot(gapminder, aes(x = gdpPercap)) + geom_density() + scale_x_log10() +
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank())
~~~



~~~{.output}
Error in ggplot(gapminder, aes(x = gdpPercap)): object 'gapminder' not found

~~~



~~~{.r}
p_scatter <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10()
~~~



~~~{.output}
Error in ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)): object 'gapminder' not found

~~~



~~~{.r}
#p_both <- arrangeGrob(p_dens, p_scatter, nrow = 2, heights = c(0.35, 0.65))
#print(p_both)
grid.arrange(p_dens, p_scatter, nrow = 2, heights = c(0.35, 0.65))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): could not find function "grid.arrange"

~~~

[R Graph Catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/)에 `arrangeGrob()`를 사용한 사례를 많이 찾을 수 있다.

### `multiplot()` 함수를 사용 

[Cookbook for R](http://www.cookbook-r.com/) 책에서, 윈스턴 창(Winston Chang)이 `grid` 팩키지를 사용해서
`multiplot()` 함수 기능을 구현했다.


~~~{.r}
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
~~~

`p1`, `p2`, `p3`, `p4` 그림 객체가 사전에 정의되었다고 가정하면, 다음과 같이
함수를 호출한다.



~~~{.r}
multiplot(p1, p2, p3, p4, cols = 2)
~~~

[Multiple graphs on one page (ggplot2)](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/)
웹사이트를 방문해서 상기 함수를 사용한 사례를 살펴본다.

### `cowplot` 팩키지 사용

`cowplot` 팩키지([CRAN](https://cran.r-project.org/web/packages/cowplot/index.html),
	[GitHub](https://github.com/wilkelab/cowplot))는 (최소한) 두가지 기능을 수행한다:

- `ggplot2`를 위한 출판할 수 있는 테마를 제공한다.
- 그래프 다수룰 조합해서 그림 하나로 만들 수 있는 기능을 제공한다.

[소품문](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)을 살펴보고 실제 사용법을 확인한다.





