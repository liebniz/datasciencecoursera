library(dplyr)

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  colNum <- 0
  if ( outcome == "heart attack")
    colNum <- 11
  else if ( outcome == "heart failure")
    colNum <- 17
  else if ( outcome == "pneumonia")
    colNum <- 23
  else
    stop("invalid outcome")
  
  nth <- 0
  if (num == "best")
    nth <- 1
  else if (num == "worst")
    nth <-0 # special meaning later
  else if ( is.numeric(num))
    nth <- num
  else
    stop("invalid num input")
  
  # open input file
  inData <- read.csv("hospdata/outcome-of-care-measures.csv", colClasses = "character")
  
  # filter by the state we are looking for
  
  inData <- filter(inData, State == state)
  
  if ( nrow(inData) == 0 )
    stop("invalid state")
  
  # now pick out the columns we are interested in including outcome column selected
  # from input
  inData <- select(inData, Hospital.Name, State, colNum)
  
  # filter out n/a s
  
  inData <- filter(inData, inData[,3] != "Not Available")
  # add artificial column which is numeric values for outcome column
  
  inData <- mutate(inData, asNumeric = as.numeric(inData[,3]))

  # sort by asNumeric then hospital name for tie breaker
  inData <- inData[order(inData$asNumeric, inData$Hospital.Name),]
  
  # sanity checks
  nrows <- nrow(inData)
  if (nth > nrows)
    return ("NA")
  if (nth == 0) # "worst" from above
    nth <- nrows
    
  # return the hospital name (column 1)
  inData[nth, 1]

}
