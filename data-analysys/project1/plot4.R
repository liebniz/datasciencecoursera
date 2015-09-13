source("project1/read_data.R")

#create sample.csv - proper subset of all the data
read_data()


input <- read.csv(file="./project1/data/sample.csv",header=T)

x <- strptime(paste(input$Date, input$Time, sep = ","), format="%d/%m/%Y,%H:%M:%S")

# make 2x2 matrix for plots
par(mfrow=c(2,2))

# upper left
plot(x = x , y= input$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
# upper right
plot(x = x , y= input$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

# lower left
plot(x = x , y= input$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
points(x = x , y= input$Sub_metering_2, type="l", col="red")
points(x = x , y= input$Sub_metering_3, type="l", col="blue")

legend(x="topright", # places a legend at the appropriate place 
       c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), # puts text in the legend
       cex=0.5, # reduce text size - seems to be the ticket      
       # other crap that i tried --- pch=1, pt.cex = 1,
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(1,1,1), #line width
       bty = "n",
       col=c("black","red","blue"))
# lower right
plot(x = x , y= input$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
