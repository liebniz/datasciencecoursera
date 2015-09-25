# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


NEI <- readRDS("summarySCC_PM25.rds")

# turn year into factor
NEI <- transform(NEI, year = factor(year))
NEI <- transform(NEI, type = factor(type))

baltimore <- filter(NEI, fips == "24510")

summary(baltimore)


# function to remove outliers 
# http://stackoverflow.com/questions/4787332/how-to-remove-outliers-from-a-dataset
remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

# get rid of outliers
emissions <- remove_outliers(baltimore$Emissions)


# add them to data frame (i guess not necessary)
baltimore <- mutate(baltimore, emit_clean = emissions)

# plot emissions vs year facetted by 'type'. Smooth using linear regression
p <- qplot(main = "Baltimore County PM2.5 Emmisions by Type" , xlab = "Year" , ylab="Emission PM2.5 (tons per year)" ,
           year, emit_clean, data = baltimore, facets = . ~ type)  + geom_smooth(aes(group=1), method="lm")

print(p)

