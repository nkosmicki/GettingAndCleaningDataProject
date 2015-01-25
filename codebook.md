# Overview

The course project for Getting and Cleaning Data script, `run_analysis.R`, follows the required five steps outlined below from the project description:

* Merges the training and the test sets to create one data set.

* Extracts only the measurements on the mean and standard deviation 
for each measurement. 

* Uses descriptive activity names to name the activities in the data set

* Appropriately labels the data set with descriptive variable names. 

* From the data set in step 4, creates a second, independent tidy data 
set with the average of each variable for each activity and each subject.


# Implementation

* The data files are downloaded and unzipped (code is listed in the `run_analysis.r` script). 
* The pertinent files are uploaded to RStudio using `read.table()`. `x_test.txt` is uploaded as `xTest`, `x_train.txt` is uploaded as `xTrain`, `subject_test.txt` is uploaded as `subjectTest`, `subject_train.txt` is uploaded as `subjectTrain`, `y_test.txt` is uploaded as `yTest`, and `y_train.txt` is uploaded as `yTrain`. 
* From the downloaded data `activity_labels.txt` is uploaded as `activities`, and `features.txt` is uploaded as `features`.  
* Each related file is merged together using `rbind` into `xMerge`, `yMerge`, and `subjectMerge`.
* Using `grep()` the mean and standard deviation are extracted from `features` and saved to `meanStdDev`.
* The mean and standard deviation are merged with the applicable `xMerge` table.
* The y data in the table `yMerge` is merged with the `activities` table to apply the correct activity names and IDs.
* The names are updated using the `names()` function in all three merged files.
* The data is all combined using `cbind` into one table called `finalDataTable`.
* The first 66 columns are averaged (excluded 67 & 68 as these are not numeric columns) as `averagedData` using `colMeans()` from the `plyr` package.
* The final product is written out to the working direction using `write.table()` as `averagedData.txt`.


# Variables

* `xTest`, `xTrain`, `subjectTest`, `subjectTrain`, `yTest`, `yTrain`, `activities`, and `features` are variables used to store data from the downloaded file.
* All merges are completed using `rbind`. `xTest` and `xTrain` are merged into `xMerge`, `yTest` and `yTrain` and merged into `yMerge`, `subjectTest` and `subjectTrain` are merged into `subjectMerge`.
* `finalDataTable` contains all the cleaned results of `xMerge`, `yMerge`, and `subjectMerge` combined via `cbind`.
* The averages are calculated and stored in `averagedData`.
* The final file is written out as `averagedData.txt`.
