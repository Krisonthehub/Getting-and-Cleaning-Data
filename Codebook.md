This codebook explains how the dataset AvgData.txt was created using data sourced from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

More information about the source data can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This data transformation exercise was performed as the basis of the course project for the 
Coursera course Getting and Cleaning Data, November 2015 and uses physical movement data collected from the 
accelerometers from the Samsung Galaxy S smartphone. 

When read into R, the file AvgData.txt is a dataframe containing 6 observations of 80 variables. 
Each value is an average value of the measurements taken for one of 6 Activites.

The 6 activities measured were:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

The measurements taken for each of these activities were collected via gyroscope 
and accelerometer and include Jerk signals (body linear acceleration and angular velocity) and
magnitude. 

The base list of signals collected were:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Although a much larger set of variables was included in the original data, the AvgData.txt 
dataset is a subset containined only those measurements of mean value (mean) and 
standard deviation (std). 

The analysis performed to create the AvgData.txt dataset involved the following steps and is
provided as R code in the run_analysis.R file in the repo:



##1. Import the data 

* Train<-read.csv("train\\X_train.txt", header=FALSE, sep="") ##read in training data

* Test<-read.csv("test\\X_test.txt", header=FALSE, sep="") ##read in test data

* TrainLabels<-read.csv("train\\y_train.txt", header=FALSE, sep="") ##read in data for training labels

* TestLabels<-read.csv("test\\y_test.txt", header=FALSE, sep="") ##read in labels for test data



##2. Apply meaningful labels to data and combine as one

* from<-c("1", "2", "3", "4", "5", "6") ##identify label vectors for activities measured

* to<-c("WALKING", "WALKING_UP", "WALKING_DOWN", "SITTING", "STANDING", "LAYING") ##create new desired labels 

* gsub2 <- function(pattern, replacement, x, ...) { ##write sub function to substitute numbers with names

* for(i in 1:length(pattern))
* x <- gsub(pattern[i], replacement[i], x, ...)
* x
* }

* TrainLabels<- gsub2(from, to, TrainLabels$V1) ##apply gsub2 function to training data labels

* TestLabels<-gsub2(from, to, TestLabels$V1) ##apply gsub2 function to test data labels

* TrainData<-cbind(TrainLabels, Train) ##bind training data labels to training data as new column

* TestData<-cbind(TestLabels, Test) ##bind test data labels to test data as new column

* setnames(TrainData, "TrainLabels", "Activity") ##rename TrainLabels column ready for binding

* setnames(TestData, "TestLabels", "Activity") ##rename TestLabels column ready for binding

* AllData<-rbind(TrainData, TestData) ##Merges the training and the test sets to create one data set.



##3. Source variable names and apply to dataset

* Varnames<-read.csv("features.txt", header=FALSE, sep="", colClasses = "character") ##read in list of variable names

* Varnames<-Varnames[1:561, "V2"] ##subset to isolate column of interest

* setnames(AllData, colnames(AllData[,2:562]), Varnames) ##change variable names to more meaningful names



##4. Extract only those variables related to mean and std

* SubData1<- AllData[grep("mean",colnames(AllData))] ##extract only measurements on mean

* SubData2<-AllData[grep("std", colnames(AllData))] ##extract only measurements on std

* ExtractData<-cbind(SubData1, SubData2)##combine meand std data into one dataset

* ExtractData<-cbind(AllData["Activity"], ExtractData)



##5. Create a new clean dataset that calculates the average of each variable by activity

* AvgData<-aggregate(.~Activity, data=ExtractData, mean) ##create a separate clean dataset with average of each variable

 

