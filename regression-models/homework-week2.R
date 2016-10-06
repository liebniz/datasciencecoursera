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

x <- father.son$fheight
y <- father.son$sheight
f <- lm( y  ~  x)
summary(f)
e <- resid(f)
#1.a
plot (x,e) # this is correct

pf <- qplot(y=r,x=predict(f))
pf <- pf + geom_point(alpha=.2, size=2,color="blue")
#pf <- pf + geom_smooth(method="lm")
pf
plot ()
plot(f)

#2. Refer to question 1. Directly estimate the residual variance and compare this estimate to the
#output of lm

n = length(x)
sum(e^2) / (n - 2)

# 5.93

summary(f)


2.437^2

# 3. Refer to question 1. Give the R squared for this model

yhat = predict(f)
ymean = mean (y)

rs = sum((yhat - ymean) ^2) / sum((y - ymean)^2)
rs

# 0.2513


# 4-6 are same but with mtcars dataset

# exercises pg 52

#1

# 1. Test whether the slope coefficient for the father.son data is different from zero (father as
# predictor, son as outcome).

summary(f)
# fheight      0.51409    0.02705   19.01   <2e-16 ***

# p-value almost zero - so reject null hyp -> slope not 0

# 2. Refer to question 1. Form a confidence interval for the slope coefficient
x <- father.son$fheight
y <- father.son$sheight
newx <- data.frame(fheight = seq(min(x), max(x), length = 100))

pr <- predict(f,newdata=data.frame(newx),interal="confidence")
summary(pr)

sumCoef <- summary(f)$coefficients
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = f$df) * sumCoef[2, 2])
# [1] 0.4610188 0.5671673

# w/ 97.5% confidence inch of fheight -> .46-.57 inch of sheight

# 
confint(f)
# gives same result

# 3. Refer to question 1. Form a confidence interval for the intercept (center the fathers’ heights
# first to get an intercept that is easier to interpret
fcentered <- lm ( sheight ~ I(fheight - mean(fheight)), data = father.son)
confint(fcentered)

# 2.5 %     97.5 %
# (Intercept)                68.5384554 68.8296839
# I(fheight - mean(fheight))  0.4610188  0.5671673

# 4. Refer to question 1. Form a mean value interval for the expected son’s height at the average
# father’s height.
m = mean(x)
predict(fit_centered, newdata = data.frame(fheight=m), interval = "confidence")

#
#fit      lwr      upr
# 68.68407 68.53846 68.82968

# 5. Refer to question 1. Form a prediction interval for the son’s height at the average father’s
# height

predict(fit_centered, newdata = data.frame(fheight=m), interval = "prediction")
# fit      lwr      upr
# 1 68.68407 63.90091 73.46723

# NOTE: band is

"
6. Load the mtcars dataset. Fit a linear regression with miles per gallon as the outcome
 and horsepower as the predictor. Test whether or not the horsepower power coefficient is
 statistically different from zero. Interpret your test.
"

# 6
fmpg <- lm ( mpg ~ hp, data=mtcars)
summary(fmpg)$coefficients

"
Estimate Std. Error   t value     Pr(>|t|)
(Intercept) 30.09886054  1.6339210 18.421246 6.642736e-18
hp          -0.06822828  0.0101193 -6.742389 1.787835e-07

-valu8e very small -> reject hyp b1 = 0 -> b1 != 0
"

# 7

"
7. Refer to question 6. Form a confidence interval for the slope coefficient"


sumCoef <- summary(fmpg)$coefficients
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = f$df) * sumCoef[2, 2])

# [1] -0.08808408 -0.04837247    

"8. Refer to quesiton 6. Form a confidence interval for the intercept (center the HP variable first)."

fmpg <- lm ( mpg ~ I(hp - mean(hp)), data=mtcars)
confint(fmpg)

"                        2.5 %     97.5 %
(Intercept)      18.69599452 21.4852555
I(hp - mean(hp)) -0.08889465 -0.0475619"


"9. Refer to question 6. Form a mean value interval for the expected MPG for the average HP"
m = mean(mtcars$hp)
predict(fmpg, newdata = data.frame(hp=m), interval = "confidence")

"       fit      lwr      upr
1 20.09062 18.69599 21.48526
"

"10. Refer to question 6. Form a prediction interval for the expected MPG for the average HP."

m = mean(mtcars$hp)
predict(fmpg, newdata = data.frame(hp=m), interval = "prediction")

"       fit      lwr      upr
1 20.09062 12.07908 28.10217
"

"11. Refer to question 6. Create a plot that has the fitted regression line plus curves at the expected
value and prediction intervals."


p2 <- qplot(x=hp,y=mpg,data=mtcars)
p2 <- p2 + geom_point(alpha=.2, size=5,color="blue")
p2 <- p2 + geom_smooth(method="lm")
p2


library(datasets)
data("Seatbelts")
seatbelts = as.data.frame(Seatbelts)
head(seatbelts)

