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
  
  results<-vector()

  fileNames<-list.files(path=directory, pattern="\\.*csv", full.names=TRUE)
  for (fname in fileNames) {
    csv <- read.csv(fname, header = TRUE)
    #print(length(complete.cases(csv)== TRUE))
    #print ( length(complete.cases(csv)== TRUE) >= threshold )
    completeCases <- csv[(complete.cases(csv)== TRUE),]
    len <- length(completeCases$ID)
    if ( len >= threshold & len > 0) {
      nitrate<-completeCases$nitrate
      sulfate<-completeCases$sulfate
      results <- c(results, cor(sulfate,nitrate))
    }
		
  }
	
  return (results)
}

