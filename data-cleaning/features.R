
library(dplyr)
library(data.table)


# variable definitions
feats_dt <- fread("UCI HAR Dataset/features.txt")

# activity definitions
activity_labels_dt <- fread("UCI HAR Dataset/activity_labels.txt")

mean_std_cols <- feats_dt[V2 %like% "-mean\\(\\)" | V2 %like% "-std\\(\\)"]

# free memory
rm(feats_dt)

col_names <- make.names(mean_std_cols$V2)
col_indices <- mean_std_cols$V1


## TEST data set
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
subjects_train <- read.table("UCI HAR Dataset/train/subject_test.txt")

# integers converted to their factor value
activity_factored <- factor(y_train$V1,labels = c(activity_labels_dt$V2) )

# extract the columns we are concerned with
x_train <- select(x_train, mean_std_cols$V1)

# add in the activity column
x_train <- mutate(x_train, activity = activity_factored, subject = c(subjects$V1))







