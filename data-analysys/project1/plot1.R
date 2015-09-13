source("project1/read_data.R")

#create sample.csv - proper subset of data for 2/1 and 2/2
read_data()


input <- read.csv(file="./project1/data/sample.csv",header=T)


hist(x = input$Global_active_power, col = "red", 
     xlab = "GlobalActive Power (kilowatts)", main = "Global Active Power")
