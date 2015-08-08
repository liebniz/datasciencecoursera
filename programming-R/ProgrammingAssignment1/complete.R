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
