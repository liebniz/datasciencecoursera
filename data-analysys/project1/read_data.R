
library(dplyr)


read_data <- function () {
  # define classes we want to import data as
  classes <- c(
    "character", "character",
    "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"
  )
  
  # chug it in - make "?" be NA
  input <-
    read.table(
      file = "./project1/data/household_power_consumption.txt",
      colClasses = classes, header = T, sep = ";", na.strings = "?"
    ) # 2075259 observations
  
  # combine first 2 columns into proper data/time
  input <-
    mutate(input, DateTime = as.Date(sprintf("%s %s", Date, Time),
                                        format = "%d/%m/%Y %H:%M:%S"))


  # select Feb 1,2 2007
  data <-
    filter(input, DateTime >= "2007-02-01" &
             DateTime < "2007-02-03") #2880 observations
  
  #save it so we dont have to go through this again :-)
  write.csv(data, file = "./project1/data/sample.csv", row.names = F)
  
  # cleanup
  rm(input,data,classes)
  
}
