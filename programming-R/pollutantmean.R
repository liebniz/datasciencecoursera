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


    check <- c("sulfate","nitrate")
    if ( ! pollutant %in% check ) stop(sprintf("invalid pollutant %s", pollutant))

    uids <- unique(id)

    if ( max(uids) >= 333 || min(uids) < 1 )
        stop(sprintf("input out of range: %d to %d", min(uids), max(uids)))

    ## format input
    ## 2 nice solutions below - i like sprintf for nostalgic reasons
    fileSuffix <- sprintf("%03d.csv", uids)
                                        # files <- paste(formatC(a, width=3, flag="0"), ".csv", sep="")

    fileNames <- file.path(directory, fileSuffix)
    
    ## now open the files and process them

    ## also csv$sulfate works but is not dynamic
    ## pollutant<-"sulfate"
    ## mn<-mean(csv[[pollutant]],na.rm=TRUE)



    ## initialize zero length vector to append to
    dataPoints <- vector(mode="numeric", length=0)

    fileNames
    
    for (fname in fileNames) {
        csv <- read.csv(fname, header = TRUE)
        dataPoints <- c(dataPoints,csv[[pollutant]])
    }

    mn<-mean(dataPoints,na.rm=TRUE)   

    return (mn)
}

## dir <- "/root/Documents/datasciencecoursera/programming-R/specdata"
## id <- 5:67
## poll <- "sulfate"

## mn <- pollutantmean(dir,poll,id)

## print (mn)


complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  uids <- unique(id)
  
  if ( max(uids) >= 333 || min(uids) < 1 )
    stop(sprintf("input out of range: %d to %d", min(uids), max(uids)))
  
  ## format input
  fileSuffix <- sprintf("%03d.csv", uids)
  fileNames <- file.path(directory, fileSuffix)

  
  ## initialize preallocated data frame - nope inefficient according to 
  ## stack overflow. Use matrix and cast to dataframe after the fact
  
  temp <- matrix(ncol=2, nrow=length(uids))

  ## process files
  counter <- 0
  for (fname in fileNames) {
    counter<- counter +1
    csv <- read.csv(fname, header = TRUE)
    temp[counter, 1] <- csv$ID[1]
    temp[counter, 2] <- sum(complete.cases(csv)== TRUE)
  }
  
  dataFrame <- data.frame(id = temp[,1],nobs = temp[,2])

  return (dataFrame)  
}

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  ## 1) get the whole directory by "*.csv"
  ## 2) filter out by threshold
  ## 3) build vector for each pollutant with code like below
  
  nitrate<-vector() ## for each file, append to x as follows
  nitrate<-c(nitrate,csv[complete.cases(csv),]$nitrate)
}

