library(UsingR)
f <- father.son$fheight
s <- father.son$sheight



# exercises page 32
# 1

# Hs = B0 + B1 Hf + e
# H0:B1=0
# Ha:B1 not = 0
#
# t-value   Pr(>|t|)
# 19.01   <2e-16 ***
#
# t-value high and p almost 0 -> reject null hypothysis

# Pvalue < alpha of , say, 0.05 (95 percentile)

fit <-  lm ( sheight ~ fheight, father.son)
summary(fit)

#2
fit_centered <-  lm ( sheight ~ I(fheight - mean(fheight)), father.son)
summary(fit_centered)

#3

predict(fit, newdata = data.frame(fheight= c(80)))
# 75.01 - extrapolation beyond dataset so not accurate



# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                68.68407    0.07421  925.53   <2e-16 ***
#   I(fheight - mean(fheight))  0.51409    0.02705   19.01   <2e-16 ***

?lm

p <- ggplot(father.son, aes(x=f,y=s))
p <- p + geom_point(alpha=.5, size=2,color="red")
p <- p + geom_smooth(method="lm")
p

data(galton)
f2 <- galton$parent
s2 <- galton$child

p2 <- qplot(x=f2,y=s2)
p2 <- p2 + geom_point(alpha=.2, size=5,color="blue")
p2 <- p2 + geom_smooth(method="lm")
p2

fit2 <-  lm ( s2 ~ f2 - 1)
summary(fit2)


#4

fit3 = lm ( mpg ~ hp, mtcars)
summary(fit3)
#5
p3 <- qplot(data=mtcars,x=hp,y=mpg)
p3 <- p3 + geom_point(alpha=.2, size=5,color="blue")
p3 <- p3 + geom_smooth(method="lm")
p3

#6
predict(fit3,newdata=data.frame(hp=c(111)))
# 22.5


# exercises pg 45 residuals

#1

f <- lm( sheight  ~  . , data=father.son)
fitmt <- lm( mpg  ~  . , data=mtcars)
summary(f)
pf <- qplot(data=father.son,x=fheight,y=sheight)
pf <- pf + geom_point(alpha=.2, size=5,color="blue")
pf <- pf + geom_smooth(method="lm")
pf

#2. Refer to question 1. Directly estimate the residual variance and compare this estimate to the
#output of lm

n = length(father.son$fheight)
sqrt(sum(resid(f)^2) / (n - 2))

# 2.437

# 3. Refer to question 1. Give the R squared for this model

yhat = predict(f)
y = father.son$sheight
ymean = mean (y)

rs = sum((yhat - ymean) ^2) / sum((y - yhat)^2)
rs

# 0.33572

