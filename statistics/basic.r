# HSG GasaGGI

# 중심극한정리 시뮬레이션
par(mfrow = c(1, 2))
no <- 30
m <- rep(NA, no)
for(i in 1:no){
  m[i] <- mean(rexp(30, 10))
}
hist(m, prob= T, col = 'wheat')
hist(scale(m), prob= T, col = 'skyblue')
curve(dnorm(x, 0, 1), -3, 3, col = 'red', add = TRUE)

par(mfrow = c(1, 2))
no <- 100
m <- rep(NA, no)
for(i in 1:no){
  m[i] <- mean(rexp(30, 10))
}
hist(m, prob= T, col = 'wheat')
hist(scale(m), prob= T, col = 'skyblue')
curve(dnorm(x, 0, 1), -3, 3, col = 'red', add = TRUE)

par(mfrow = c(1, 2))
no <- 10000
m <- rep(NA, no)
for(i in 1:no){t <- data.frame(iris)
t <- t[-c(101:150),]
data <- data.frame(species = c(1:100), sepal = c(1:100))
for(i in 1:100){
  data$species[i] <- t$Species[i]
  data$sepal[i] <- t$Sepal.Length[i]
}
view(data)
  m[i] <- mean(rexp(30, 10))
}
hist(m, prob= T, col = 'wheat')
hist(scale(m), prob= T, col = 'skyblue')
curve(dnorm(x, 0, 1), -3, 3, col = 'red', add = TRUE)

# 단일표본 t 검정
data <- c(35,40,12,15,21,14,46,10,28,48,16,30,32,48,31,22,12,39,19,25)
shapiro.test(data)
t.test(data, mu = 25, alternative = 'two.sided')
boxplot(data, ylim = c(0, 60))

# 대응표본 t 검정
data <- data.frame(before = c(0.430,0.266,0.567,0.531,0.707,0.716,0.651,0.589,0.469,0.723),
                   after = c(0.415,0.238,0.390,0.410,0.605,0.609,0.632,0.523,0.411,0.612))
View(data)
var.test(data$before, data$after)
boxplot(data, ylim = c(0, 0.8))
t.test(data$before, data$after, paired = TRUE)

diff <- data$before - data$after
shapiro.test(diff)
t.test(diff, mu = 0)

# 독립표본 t 검정
t <- data.frame(iris)
t <- t[-c(101:150),]
data <- data.frame(species = c(1:100), sepal = c(1:100))
for(i in 1:100){
  data$species[i] <- t$Species[i]
  data$sepal[i] <- t$Sepal.Length[i]
}
View(data)
boxplot(data$sepal ~ data$species)
aggregate(sepal ~ species, data = data, FUN = mean)
aggregate(sepal ~ species, data = data, FUN = var)
bartlett.test(sepal ~ species, data = data)
t.test(sepal ~ species, var.equal = FALSE, data = data)
install.packages('car')
library('car')
leveneTest(sepal ~ as.factor(species), data = data)

# 카이제곱 검정 
x <-  matrix(c(324,371.28,78,79.56,261,212.16), nrow=2, 
             dimnames = list(c("관찰", "기대"), c("제품A", "제품B", "제품C")))
barplot(x, beside = TRUE, legend = TRUE)
chisq.test(x = x[c(1),], p = c(0.56, 0.12, 0.32))
px <- seq(0, 20, length.out = 101)
plot(px, dchisq(px, 2), type = 'l', col = 'blue')
xa <- qchisq(0.95, 2)
lines(c(xa, xa), c(1, 0), lty = 2)
xc <- qchisq(1 - 0.0001756, 2)
lines(c(xc, xc), c(1, 0), col = 'red')
library("descr")
x <-  matrix(c(269,155,83,57,215,181), nrow = 2,
             dimnames = list(c("여성", "남성"), c("제품1", "제품2", "제품3")))
CrossTable(x, expected = TRUE, prop.r = FALSE, prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE)
chisq.test(x)

#상관관계 분석
library(readxl)
cor01 <- read_excel("C:/Users/sungh/Downloads/cor01.xlsx")
colnames(cor01) <- c('sales', 'gdp1')
plot(cor01)
hist(cor01$gdp1, breaks = 7)
cor.test(cor01$sales, cor01$gdp1, method = 'pearson')
cor.test(cor01$sales, cor01$gdp1, method = 'kendall')
cor.test(cor01$sales, cor01$gdp1, method = 'spearman')

# 제 1,2종 오류 
library("ggplot2")
a <- 0.05
a.line <- qnorm(1 - a, 0, 1)

fn0 <- function(x){
  dnorm(x, 0, 1)
}

fn0a <- function(x){
  r <- fn0(x)
  r[ x <  a.line] <- NA
  return(r)
}

fn1 <- function(x){
  dnorm(x, 2.5, 1)
}

fn1a <- function(x){
  r <- fn1(x)
  r[ x > a.line ] <- NA
  return(r)
}

ggplot(data.frame(x = c(-3.5, 6), y = c(0, 0.5)), aes(x = x, y = y)) +
  stat_function(fun = fn0, color = "blue") +
  stat_function(fun = fn1, color = "red") +
  stat_function(fun = fn0a, geom = "area", fill = "sky blue", alpha = .8) +
  stat_function(fun = fn1a, geom = "area", fill = "pink", alpha = .8) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = a.line, linetype  ="dashed") +
  geom_text(x = 0, y = 0.36, label= "H0") +
  geom_text(x = 2.5, y = 0.36, label= "H1") +
  geom_text(x = -0.5, y = 0.1, label= "1-α") +
  geom_text(x = 1, y = 0.03, label= "β") +
  geom_text(x = 2, y = 0.03, label= "α") +
  geom_text(x = 3, y = 0.1, label= "1-β") +
  ggtitle("α-error & β-error") +
  theme_bw()

# 일원 분산 분석 
data <- PlantGrowth
data$group = factor(data$group, labels = c("Control", "Treatment 1", "Treatment 2"))
require(ggplot2)
ggplot(data, aes(x = group, y = weight)) +
  geom_boxplot(fill = "grey80", colour = "blue") +
  scale_x_discrete() + xlab("Treatment Group") +
  ylab("Dried weight of plants")
data.mod1 = lm(weight ~ group, data = data)
summary(data.mod1)
anova(data.mod1)
confint(data.mod1)
data.mod = data.frame(Fitted = fitted(data.mod1),
                      Residuals = resid(data.mod1), Treatment = data$group)
ggplot(data.mod, aes(Fitted, Residuals, color = Treatment)) + 
  geom_point()
r.aov <- aov(weight ~ group, data = data)
summary(r.aov)
bartlett.test(weight ~ group, data = data)

# 단순선형 회귀 분석 
x <- women$height
y <- women$weight
cor.test(x,y)
plot(x,y)
m <- lm(y~x)
summary(m)
abline(m)
plot(x,y, xlim = c(0,80), ylim = c(-100,170))
abline(h=0, col="black")
abline(m, col = "red")
shapiro.test(m$res)
qqplot(m$res, m$fitted)
library("lmtest")
dwtest(m)
plot(scale(m$fitted), scale(m$res))
abline(h=0)

# 다중선형회귀분석 
states <- as.data.frame(state.x77[,c("Murder", "Population", "Illiteracy", "Income", "Frost")])
m <- lm(Murder~Population+Illiteracy+Income+Frost,data=states)
summary(m)
confint(m)
par(mfrow=c(2,2))
plot(m)
par(mfrow=c(1,1))
qqPlot(m, labels=row.names(states), id.method="identify", simulate=TRUE)
fitted(m)["Nevada"]
residplot <- function(m, nbreaks=10) {
  z <- rstudent(m)
  hist(z, breaks=nbreaks, freq=FALSE, xlab="Studentized Residual", main="Distribution of Errors")
  rug(jitter(z), col="brown")
  curve(dnorm(x, mean=mean(z), sd=sd(z)), add=TRUE, col="blue", lwd=2)
  lines(density(z)$x, density(z)$y, col="red", lwd=2, lty=2)
  legend("topright", legend = c( "Normal Curve", "Kernel Density Curve"),
         lty=1:2, col=c("blue", "red"), cex=.7)
}
residplot(m)
#독립성
durbinWatsonTest(m)
#선형성
crPlots(m)
#등분산성
ncvTest(m)
spreadLevelPlot(m)
require(car)
vif(m)
summary(m)
m2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(m2)

# 로지스틱 회귀분석
# 확률
p <- seq(0, 1, length.out = 201)
# 오즈
odds <- p / (1 - p)
# 플롯
plot(p, odds, type = "l", col = "red", ylim = c(0, 10))
# 확률 p = 0.5 참조선 추가
lines(c(0.5, 0.5), c(0, 10), lty = "dashed", col = "blue")
text(0.5, 5, "p = 0.5")
# odds = 1 참조선 추가
lines(c(0, 1), c(1, 1), lty = "dashed", col = "blue")
text(0.25, 1.5, "odds = 1")
# 로그오즈
logOdds = log(odds)
# 플롯
plot(p, logOdds, type = "l", col = "red", ylim = c(-5, 5))
# 확률 p = 0.5 참조선 추가
lines(c(0.5, 0.5), c(-5, 5), lty = "dashed", col = "blue")
text(0.5, 5, "p = 0.5")
# logOdds = 1 참조선 추가
lines(c(0, 1), c(0, 0), lty = "dashed", col = "blue")
text(0.25, 0.5, "logOdds = 0")
# 예측변수 x
x <- seq(-5, 5, length.out = 201)
# 임시로 회귀계수를 지정
beta0 <- 0
beta1 <- 1
# 확률 px
px <- 1 / (1 + exp(-(beta0 + beta1 * x)))
# 플롯
plot(x, px, type = "l", col = "red", ylim = c(0, 1))
# 예측변수 x = 0 참조선 추가
lines(c(0, 0), c(0, 1), lty = "dashed", col = "blue")
text(0, 0.8, "x = 0")
# 확률 px = 0.5 참조선 추가
lines(c(-5, 5), c(0.5, 0.5), lty = "dashed", col = "blue")
text(-3, 0.55, "px = 0.5")
# 표준정규분포 누적분포함수
phi <- pnorm(x, 0, 1)
# 플롯
plot(x, phi, type = "l", col = "red", ylim = c(0, 1))
# 예측변수 x = 0 참조선 추가
lines(c(0, 0), c(0, 1), lty = "dashed", col = "blue")
text(0, 0.8, "x = 0")
# 확률 px = 0.5 참조선 추가
lines(c(-5, 5), c(0.5, 0.5), lty = "dashed", col = "blue")
text(-3, 0.55, "px = 0.5")
lines(x, px, type = "l")
or = (62/183)/(45/156)=1.174499
        