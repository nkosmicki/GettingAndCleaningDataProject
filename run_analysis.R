# # This file downloads a dataset and prepares it for analysis
# according to the "tidy data" principles following the steps required for the 
# course project outlined below:
#   
#  
# 1. Merges the training and the test sets to create one data set.
# 
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 
# 3. Uses descriptive activity names to name the activities in the data set
# 
# 4. Appropriately labels the data set with descriptive variable names. 
# 
# 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.


library(data.table)
library(plyr)

# Download and unzip the file from the source

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- file.path(getwd(), "getdata_projectfiles_UCI_HAR_Dataset.zip")

download.file(url, file)
unzip("getdata_projectfiles_UCI_HAR_Dataset.zip")

# Upload the applicable files, subject_text, x_test, y_test,
# subject_train, x_train, y_train, features, activities

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Using rbind to add related test and train files together 

xMerge <- rbind(xTest, xTrain)
yMerge <- rbind(yTest,yTrain)
subjectMerge <- rbind(subjectTest,subjectTrain)


# Using grep and the features file sort for the mean and standard deviation

meanStdDev <- grep("-(mean|std)\\(\\)", features[, 2])

# create subset of required columns

xMerge <- xMerge[, meanStdDev]


# Update merged data with correct names

yMerge[, 1] <- activities[yMerge[, 1], 2]


# Update merged data with correct column headers

names(yMerge) <- "activity"

names(subjectMerge) <- "subject"

names(xMerge) <- features[meanStdDev, 2]


# merge all tables into one

finalDataTable <- cbind(xMerge, yMerge, subjectMerge)

# average all columns except 67 & 68 (which are not numeric)

averagedData <- ddply(finalDataTable, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Write table to working directory with final tidy data

write.table(averagedData, "averagedData.txt", row.name=FALSE)

