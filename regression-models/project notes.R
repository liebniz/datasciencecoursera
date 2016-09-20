data(mtcars)
library(sqldf)

# exploratory data analysis


sqldf('select distinct(cyl), count(*), avg(mpg) from mtcars where am = 1 group by cyl')
# cyl count(*) avg(mpg)
# 1   4        8 28.07500
# 2   6        3 20.56667
# 3   8        2 15.40000

sqldf('select distinct(cyl), count(*), avg(mpg) from mtcars where am = 0 group by cyl')
# cyl count(*) avg(mpg)
# 1   4        3   22.900
# 2   6        4   19.125
# 3   8       12   15.050

manual <- sqldf("select * from mtcars where am = 0")
automatic <- sqldf("select * from mtcars where am = 1")


fit_manual <- lm(mpg )



