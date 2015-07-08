pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  dir <-
    "/home/jzendle/Documents/datasciencecoursera/programming-R/specdata"
  
  
  id <- 1:2
  # 2 nice solutions below - i like sprintf for nostalgic reasons
  fileSuffix <- sprintf("%03d.csv", id)
  # files <- paste(formatC(a, width=3, flag="0"), ".csv", sep="")
  ## create and view an object with file names and full paths

  fileName <- file.path(dir, fileSuffix)
  
  # now open the files and process them

  reslist <- lapply(fileName, function(name) { 
    
    print(name)
    csv <- read.csv(name, header = TRUE)
    print(csv) 
    }
    
    )
}
