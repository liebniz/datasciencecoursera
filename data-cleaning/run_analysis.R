
library(dplyr)
library(data.table)

#
# Common to both data sets
#

# 1) read in the names of all the variables
feats_dt <- fread("UCI HAR Dataset/features.txt")

# 2) read in the names of all the activities (stand, sit, etc)
activity_labels_dt <- fread("UCI HAR Dataset/activity_labels.txt")

# 3) pull out the variables with 'mean()' or 'std()' in them
mean_std_cols <- feats_dt[V2 %like% "-mean\\(\\)" | V2 %like% "-std\\(\\)"]

# dont need this data set anymore
rm(feats_dt)

#
## TEST data set specific processing
#

# fread() was causing 'out-of-memory' so fell back to read.table()
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# integers converted to their factor value
activity_factored <- factor(y_test$V1,labels = c(activity_labels_dt$V2) )

# extract the columns we are concerned with
x_test <- select(x_test, mean_std_cols$V1)

# change column names to something more readable
colnames(x_test) <- mean_std_cols$V2

# add in the activity column
x_test <- mutate(x_test, activity = activity_factored, subject = c(subjects_test$V1))



## TRAIN data set

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# integers converted to their factor value
activity_factored <- factor(y_train$V1,labels = c(activity_labels_dt$V2) )

# extract the columns we are concerned with
x_train <- select(x_train, mean_std_cols$V1)

# change column names to something more readable
colnames(x_train) <- mean_std_cols$V2

# add in the activity column
x_train <- mutate(x_train, activity = activity_factored, subject = c(subjects_train$V1))

# combine train and test
data_set = rbind(x_test,x_train)

#clean up memory
rm(x_test,x_train)

data_set_dt <- data.table(data_set)

#
# Create new data set
#


# Perform aggregation by subject/activity
# 
# refer to http://stackoverflow.com/questions/8212699/summation-of-multiple-columns-grouped-by-multiple-columns-in-r-and-output-result
# in summary, we are grouping by subject and activity. ".SD" refers to all of the other columns (ikr - crazy)
# then we are applying the mean function. Powerful but inscrutible.

meanOfMeans <- data_set_dt[, lapply(.SD,mean), by=list(subject,activity)]

# change the column names to indicate that we have taken mean()
new_col_names <- sprintf("mean(%s)", names(meanOfMeans))
# change back 'subject' and 'activity'
new_col_names[1] <- "subject"
new_col_names[2] <- "activity"

# now apply the new column names
colnames(meanOfMeans) <- new_col_names 


# finally write out the dataset
write.table(meanOfMeans, "tidy-summary.txt", row.names = FALSE)





