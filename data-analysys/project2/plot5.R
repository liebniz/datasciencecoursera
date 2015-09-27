# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City? 

library(dplyr)
library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# find motor vehicle sources
# from eye-balling the unique sectors, looks like 'vehicle' will get it
grep(unique(SCC$EI.Sector), pattern = "Vehicles")
# [1] 21 22 23 24

# filter sectors contaning the word Coal
SCC_Vehicles <- filter(SCC, grepl(EI.Sector, pattern = "Vehicles")) 
# filter out baltimore city
NEI_Baltimore <- filter(NEI, fips == "24510") 


# join the two data frames
NEI_Vehicles <- merge(NEI_Baltimore, SCC_Vehicles)

# group the whole mess by year
NEI_Vehicles_by_year <- group_by(NEI_Vehicles, year)

# now get the mean by year 
sum <- summarize(NEI_Vehicles_by_year, mean = mean(Emissions, na.rm = T))

# plot it ( linear regression seems to work well )
ggplot(data=sum, aes(year , mean)) +
  ggtitle("Baltimore City Vehicles Source Emissions by Year") +
  scale_x_continuous(name="Year") +
  scale_y_continuous(name="Vehicle Source PM2.5 Emissions (tons per yr)") +
  geom_point() + 
  geom_smooth(aes(group=1), method="lm")



