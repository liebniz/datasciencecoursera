# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == 06037). Which city has seen greater changes over time in motor 
# vehicle emissions?# How have emissions from motor vehicle sources changed 
# from 1999–2008 

library(dplyr)
library(ggplot2)
library(grid)
library(gridExtra)


SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# find motor vehicle sources
# from eye-balling the unique sectors, looks like 'vehicle' will get it
grep(unique(SCC$EI.Sector), pattern = "Vehicles")
# [1] 21 22 23 24

# filter sectors contaning the word Vehicle
SCC_Vehicles <- filter(SCC, grepl(EI.Sector, pattern = "Vehicles")) 
# filter out baltimore city
NEI_Baltimore <- filter(NEI, fips == "24510") 
# now get Los Angelos
NEI_LA <- filter(NEI, fips == "06037") 


# join the two data frames
NEI_Vehicles_BMore <- merge(NEI_Baltimore, SCC_Vehicles)
NEI_Vehicles_LA <- merge(NEI_LA, SCC_Vehicles)

# group the whole mess by year
NEI_Vehicles_BMore_by_year <- group_by(NEI_Vehicles_BMore, year)
NEI_Vehicles_LA_by_year <- group_by(NEI_Vehicles_LA, year)

# now get the mean by year 
sumB <- summarize(NEI_Vehicles_BMore_by_year, mean = mean(Emissions, na.rm = T))
sumLA <- summarize(NEI_Vehicles_LA_by_year, mean = mean(Emissions, na.rm = T))

# plot it ( linear regression seems to work well )
p1 <- ggplot(data=sumB, aes(year , mean)) +
  ggtitle("Baltimore City - Vehicle Emissions by Year") +
  scale_x_continuous(name="Year") +
  scale_y_continuous(name="PM2.5 Emissions (tons per yr)", limits=c(0,2)) +
  geom_point() + 
  geom_smooth(aes(group=1), method="lm")

p2 <- ggplot(data=sumLA, aes(year , mean)) +
  ggtitle("L.A. - Vehicle Emissions by Year") +
  scale_x_continuous(name="Year") +
  scale_y_continuous(name="PM2.5 Emissions (tons per yr)", limits=c(0,110)) +
  geom_point() + 
  geom_smooth(aes(group=1), method="lm")


grid.arrange(grobs = list(p1, p2), nrow=2)



