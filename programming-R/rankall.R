rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
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
  
  # pick just the columns we want
  inData <- select(inData, Hospital.Name, State, colNum)
  
  # filter out "Not Available"
  inData <- filter(inData, inData[,3] != "Not Available")
  
  # add asNumeric column
  inData <- mutate(inData, asNumeric = as.numeric(inData[,3]))
  
  # sort by, state,AsNumeric,Hospital.Name
  inData <- inData[order(inData$State, inData$asNumeric, inData$Hospital.Name),]
  
  # split by state
  inData <- split(inData,inData$State)
  
  
  
  states <- lapply(inData,function(x,nth) {
    
    if ( nth == 0) # worst
      nth = nrow(x)
    
    x[nth,1]
    
  } , nth)

  data.frame(hospital=unlist(states), state=unlist(names(states)))
  
}
