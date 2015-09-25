
NEI <- readRDS("summarySCC_PM25.rds")

# turn year into factor
NEI <- transform(NEI, year = factor(year))

baltimore <- filter(NEI, fips == "24510")

# take quick look at data
summary(baltimore$Emissions)

#
#Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#0.0000    0.0031    0.0600    5.0960    0.8700 1044.0000 


# outline = FALSE filters out 'outliers'
with(baltimore, 
     boxplot(Emissions ~ year, 
     xlab = "Year", 
     ylab = "PM2.5 Emitted (tons)", 
     outline = FALSE))

#plot indicates the PM2.5 emissions are decreasing since 1999

