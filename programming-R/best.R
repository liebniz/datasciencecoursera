library(dplyr)

best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  colNum <- 0
  if ( outcome == "heart attack")
    colNum <- 11
  else if ( outcome == "heart failure")
    colNum <- 17
  else if ( outcome == "pneumonia")
    colNum <- 23
  else
    stop("invalid outcome")

  # open input file
  inData <- read.csv("hospdata/outcome-of-care-measures.csv", colClasses = "character")
  
  # filter by the state we are looking for
  
  inData <- filter(inData, State == state)
  
  if ( nrow(inData) == 0 )
    stop("invalid state")
  
  # now pick out the columns we are interested in including outcome column selected
  # from input
  inData <- select(inData, Hospital.Name, State, colNum)
  
  # add artificial column which is numeric values for outcome column
  
  inData <- mutate(inData, asNumeric = as.numeric(inData[,3]))
  
  #calculate the minimum from the new asNumeric column
  minOutcome <- min(inData$asNumeric,na.rm = TRUE)

  # now find the matching row(s)
  inData <- filter(inData, asNumeric == minOutcome)

  # return hospital name in first row  
  inData[1,1]
}
