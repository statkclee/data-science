### 교재 참조 사이트: http://statkclee.github.io/r-novice-inflammation/index-kr.html
## 보충학습 - 데이터 다루기, 요인(factor) 이해하기
# working directory: ~/swc/data-science


# 데이터 불러오기

dat<-read.csv(file='data/sample.csv',header=TRUE, stringsAsFactors=FALSE)

# 데이터 살펴보기

class(dat)
dim(dat)
head(dat)


# 데이터 뽑아내기: 인덱스

dat[1,1]

dat[c(1,5,7,9),1:5]

# 데이터 뽑아내기: 명칭으로

names(dat)

dat$Gender

head(dat[,c('Age','Gender')])


# 데이터 뽑아내기: 논리 인덱스

c(TRUE,TRUE,FALSE,FALSE,TRUE)

x<-c(1,2,3,11,12,13)
x < 10

x %in% 1:10

index <- dat$Group == 'Control'
dat[index,]$BloodPressure

plot(dat[dat$Group=='Control',]$BloodPressure)

x<-c(1,2,3,11,12,13)
x[x < 10] <- 0
x

#------------------------------------------------
# 요인(Factor)
#------------------------------------------------

sex <- factor(c("male", "female", "female", "male"))

levels(sex)

nlevels(sex)

food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)

food <- factor(food, levels=c("low", "medium", "high"))
levels(food)
min(food) ## 돌아가지 않는다.

food <- factor(food, levels=c("low", "medium", "high"), ordered=TRUE)
levels(food)

min(food) ## 정상 동작한다!


# 요인 변환하기

f<-factor(c(3.4, 1.2, 5))
as.numeric(f)

levels(f)[f]


f<-levels(f)[f]
f<-as.numeric(f)


# 요인 사용하기
dat<-read.csv(file='data/sample.csv', stringsAsFactors=TRUE)

str(dat)

summary(dat)

table(dat$Group)

barplot(table(dat$Group))

barplot(table(dat$Gender))

dat$Gender[dat$Gender=='M']<-'m'

plot(x=dat$Gender,y=dat$BloodPressure)

dat$Gender<-droplevels(dat$Gender)
plot(x=dat$Gender,y=dat$BloodPressure)


levels(dat$Gender)[2] <- 'f'
plot(x = dat$Gender, y = dat$BloodPressure) 