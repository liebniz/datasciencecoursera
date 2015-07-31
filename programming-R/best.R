library(dplyr)

best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  
  ## notes
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  sel<-select(outcome, Hospital.Name, State,11)
  filt<-filter(sel, State=="TX")
  mut<-mutate(filt, numeric = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
  m<-min(mut$numeric,na.rm = T)
  
  ans<-filter(mut,numeric == m)
}
