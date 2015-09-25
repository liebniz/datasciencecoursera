# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

library(dplyr)
library(ggplot2)


SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

grep(unique(SCC$EI.Sector), pattern = "Coal")
# [1]  1  6 11

# filter sectors contaning the word Coal
SCC_Coal <- filter(SCC, grepl(SCC$EI.Sector, pattern = "Coal")) 

# join the two data frames
NEI_Coal <- merge(NEI, SCC_Coal)

# group the whole mess by year
NEI_Coal_by_year <- group_by(NEI_Coal, year)

# now get the mean by year 
sum <- summarize(NEI_Coal_by_year, mean = mean(Emissions, na.rm = T))

# plot it ( linear regression seems to work well )
ggplot(data=sum, aes(year , mean)) + 
  ggtitle("Coal Source Emissions by Year") +
  scale_x_discrete(name="Year") +
  scale_y_continuous(name="Coal Source PM2.5 Emissions (tons per yr)") +
  geom_point() + 
  geom_smooth(aes(group=1), method="lm")


