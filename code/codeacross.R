install.packages("devtools")
devtools::install_github("rstudio/EDAWR")
library(EDAWR)
?storms
?cases
?pollution
?tb

# 변수, 행 뽑아내기
storms$storm
storms$wind
storms$pressure
storms$date

cases$country
names(cases)[-1]
unlist(cases[1:3,2:4])

pollution$city[1,3,5]
pollution$amount[1,3,5]
pollution$amount[2,4,6]

# 깔끔한 데이터란... tidyr
library(tidyr)
gather(cases, year, n, 2:4, -country)
gather(cases, year, n, `2011`:`2013`, -country)
gather(cases, year, n, `2011`:`2013`)
