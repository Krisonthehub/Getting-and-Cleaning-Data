# Getting-and-Cleaning-Data
Assessment materials for Coursera course Getting and Cleaning Data November 2015.
The script run_analysis.R contains the code for importing and cleaning from two separate datasets to create a final clean dataset which is ready for further analysis. This final clean dataset is titled AvgData. 

To run this script the following R packages are required:
* write.table
* dplyr


The source data was taken from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Further information about the data contained in the original sorce data can be found at : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


In order the generate the AvgData.txt dataset the following steps were performed on the X_train/text and y_train/test files contained in the source data files. The raw data contained in the Inertial Signals files was not used. 

##1. The test and training data and corresponding labels were all imported using the read.csv command 
##2. The Activity labels file was used to apply meaningful labels to data and the training and test datasets were combined as one
##3. The features.txt file was used to provide meaningful names for all the measurement variables 
##4. The measurements relating to mean and std were extracted and combined with the Activity column to created a new dataset (named ExtractData) which included only those measurements realting to mean and standard deviation
##5. A new clean dataset (named AvgData) was created that calculates the average of each variable by activity

This new clean dataset was then written as a txt file for uploading to github. 
