
library(dplyr)
library(data.table)

feats_dt <- fread("UCI HAR Dataset/features.txt")

mean_std_cols <- feats_dt[V2 %like% "-mean\\(\\)" | V2 %like% "-std\\(\\)"]

# free memory
rm(feats_dt)

col_names <- make.names(mean_std_cols$V2)
col_indices <- mean_std_cols$V1

# fread() was causing 'ot=of-memory' so fell back to read.table()
x <- read.table("UCI HAR Dataset/test/X_test.txt")

# extract the columns we are concerned with
x <- select(x, mean_std_cols$V1)

# change column names to something more readable
colnames(x) <- mean_std_cols$V2


