#
# homework week 1
#

# 1. Install and load the package UsingR and load the father.son data with data(father.son).
# Get the linear regression fit where the son’s height is the outcome and the father’s height is
# the predictor. Give the intercept and the slope, plot the data and overlay the fitted regression
# line.

# sheight(y) = b0 + b1 * fheight(x)

library(UsingR)
data("father.son")
data("galton")
data <- father.son

summary(data)
class(data)

model <- lm(data$sheight ~ data$fheight)
summary(model)

# modelg <- lm(galton$child ~ galton$parent)
# summary(modelg)


g <- ggplot(data, aes(x = fheight, y = sheight))
g <- g + xlab("father height")
g <- g + ylab("son height")
#g <- g +scale_x_continuous(name = "father height")
#g <- g +scale_y_continuous(name = "son height")
g <- g + geom_point(color="blue")
g <- g + geom_abline(slope = model$coefficients[2], intercept = model$coefficients[1])
g


# Refer to problem 1. Center the father and son variables and refit the model omitting the
# intercept. Verify that the slope estimate is the same as the linear regression fit from problem
# 1. 

datac <- data.frame( data$fheight - mean(data$fheight), data$sheight - mean(data$sheight) )
names(datac) <- c("fheight","sheight")
summary(datac)

datac$fheight <- data$fheight - mean(data$fheight)
datac$sheight <- data$sheight - mean(data$sheight)

model_centered <- lm(datac$sheight ~ datac$fheight)
summary(model_centered)
g <- ggplot(datac, aes(x = fheight, y = sheight))
g <- g +scale_x_continuous(name = "fheight centered")
g <- g +scale_y_continuous(name = "sheight centered")
g <- g + geom_point(color="blue")
#g <- g + geom_abline(slope = model_centered$coefficients[2], intercept = model_centered$coefficients[1])
g <- g + geom_smooth(method="lm")
g

# 3. Refer to problem 1. Normalize the father and son data and see that the fitted slope is the
# correlation. 

son_norm <- (father.son$sheight - mean(father.son$sheight)) / sd (father.son$sheight)
father_norm <- (father.son$fheight - mean(father.son$fheight)) / sd (father.son$fheight)

model_normalized <- lm(son_norm ~ father_norm)

cor_norm <- cor(son_norm,father_norm)

cor_norm

model_normalized$coefficients[2]

# 4. Go back to the linear regression line from Problem 1. If a father’s height was 63 inches, what
# would you predict the son’s height to be? 

son_height = model$coefficients[1] + 63 * model$coefficients[2]
son_height
# 66.27447

# 5. Consider a data set where the standard deviation of the outcome variable is double that of
# the predictor. Also, the variables have a correlation of 0.3. If you fit a linear regression model,
# what would be the estimate of the slope?

# beta1 = cor(y,x) * ( sd(y) / sd(x) )
0.3 * 2

# 0.6

# 6. Consider the previous problem. The outcome variable has a mean of 1 and the predictor has
# a mean of 0.5. What would be the intercept?

# beta0 = Ybar - beta1(Xbar)

1 - ( .6 * .5)

# 0.7

#
# Quiz 1
#

# 1
w <- c(2, 1, 3, 1)
x <- c(0.18, -1.54, 0.42, 0.95)
# adding appropriate factors based on weight =>
x <- c(0.18, 0.18, -1.54, 0.42, 0.42, 0.42, 0.95)
mean (x)


#2

x2 <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y2 <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

# had to google this one  - ?lm details
mod2 = lm (y2 ~ x2 + 0)
?lm
summary(mod2)


g <- ggplot(data.frame(x2,y2), aes(x = x2, y = y2))
g <- g +scale_x_continuous(name = "x2")
g <- g +scale_y_continuous(name = "y2")
g <- g + geom_point(color="blue")
#g <- g + geom_abline(slope = model_centered$coefficients[2], intercept = model_centered$coefficients[1])
g <- g + geom_smooth(method="lm")
g

# 3
data("mtcars")

mtcars$
mod3 = lm(mpg ~ wt, data = mtcars)
summary(mod3)

# 4

# Consider data with an outcome (Y) and a predictor (X). 
# The standard deviation of the predictor is one half that of the outcome. 
# The correlation between the two variables is .5. What value would the slope coefficient 
# for the regression model with Y as the outcome and X as the predictor?


# 5

1.5 * .4

# 6

# normalize and find value of first point

x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

x_norm <- ( x - mean(x)) / sd(x)

x_norm[1]
# -0.97

#7

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

mod4 <- lm(y~x)
coef(mod4)

# 8

# 0

#9

mean( c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42) )
# 0.573
