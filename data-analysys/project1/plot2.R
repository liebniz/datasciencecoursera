source("project1/read_data.R")

#create sample.csv - proper subset of all the data
read_data()


input <- read.csv(file="./project1/data/sample.csv",header=T)

x <- strptime(paste(input$Date, input$Time, sep = ","), format="%d/%m/%Y,%H:%M:%S")

plot(x = x , y= input$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")


