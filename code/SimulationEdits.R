rm(list=ls())

?rnorm

rnorm(10)
rnorm(10)

set.seed(123)
rnorm(10)
set.seed(123)

#1 Simul. from distrib
rnorm(10)
rpois(10, 2)

#2 Simulate from the model
#2.1 Simple linear regression

names(iris)
mO = lm(Sepal.Length ~ Sepal.Width, data = iris)
n = nrow(iris)
e = rnorm(n, sd = sd(mO$residuals))
a = coef(mO)[1]
b = coef(mO)[2]
Sepal.Length.Sim = a - b * iris$Sepal.Width + e

par(mfrow = c(2, 1))
hist(iris$Sepal.Length)
hist(Sepal.Length.Sim)

n <- 1000 #Sample size
x <- rnorm(n) #independent variable
y <- 2*x + rnorm(n) #dependent variable
#DGP: y = 2x + e, e~i.i.d. N(0,1)
out <- lm(y ~ x)
summary(out)

set.seed(123)
N = 1000
pv = rep(NA, N)
for (i in 1:N) {
    x <- rnorm(n) #independent variable
    y <- 2*x + rnorm(n) #dependent variable
    #DGP: y = 2x + e, e~i.i.d. N(0,1)
    out <- lm(y ~ x)
    s <- summary(out)
    pv[i] = s$coefficients[2, "Pr(>|t|)"]
}

mean(pv < 0.05)

#2.2 Generalized linear model -- GLM (Poisson model)
beta0 <- 0.1
beta1 <- 0.5
logY <- beta0 + beta1*x
#Y <- exp(logY) #do not get integers
Y <- rpois(n, exp(logY))
plot(x, Y)

#sapply(c(1:(K/2)), function(x) arima.sim(n=n+100, list(order=c(length(phi1),0,0),ar=phi1)))[101:(n+100),]

#2.3 ARIMA time series
phi <- 0.5
tmp <- arima.sim(n, model=list(order=c(1,0,0), ar=phi))
ts.plot(tmp)
plot(tmp)

#Need "burn-in"
tmp <- arima.sim(n+100, model=list(order=c(1,0,0), ar=phi))[101:(n+100)]
ts.plot(tmp)