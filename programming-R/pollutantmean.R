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
    

    ## create and view an object with file names and full paths
    files <- paste(  id, ".dat", collapse = ',', sep='')

    f <- file.path("http://www.ats.ucla.edu/stat/data", files )

#    f <- file.path("http://www.ats.ucla.edu/stat/data", c("auto.dta",
#                                                          "cancer.dta", "efa_cf#a.dta", "hsbmar.dta"))
}
