library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (SIN $)")
g = g + geom_smooth(method = "lm", colour = "black")
# alpha accounts for overplotting
g = g + geom_point(size = 7, colour = "black", alpha=0.5) 
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g


?geom_point
?geom_ribbon
?predict


x = diamond$carat
y = diamond$price

fit = lm (y ~ x)

fit
newx = data.frame(x = seq(min(x),max(x), len = 100))

summary(newx)
head(newx)
length(newx$x)


p1 = data.frame(predict(fit,newdata = newx,interval = "confidence"))
p2 = data.frame(predict(fit,newdata = newx,interval = "prediction"))

p1$x = newx$x
p2$x = newx$x
p1$interval="confidence"
p2$interval="prediction"
p1$k=4
p2$k=7

dat = rbind(p1,p2)
head(dat)
names(dat)[1] = "y"
g = ggplot(dat, aes(x=x,y=y))
g = g + geom_ribbon(data=p2, aes(x=x,y=fit,ymin=lwr,ymax=upr),col="grey35")
g = g + geom_ribbon(data=p1, aes(x=x,y=fit,ymin=lwr,ymax=upr), fill="grey70", col="grey70")
g = g + geom_line(col="white")
g = g + geom_point(data=data.frame(x=x,y=y),col="red")
g

