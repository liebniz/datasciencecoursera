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
