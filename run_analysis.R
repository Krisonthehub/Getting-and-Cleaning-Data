Train<-read.csv("train\\X_train.txt", header=FALSE, sep="") ##read in training data
Test<-read.csv("test\\X_test.txt", header=FALSE, sep="") ##read in test data
TrainLabels<-read.csv("train\\y_train.txt", header=FALSE, sep="") ##read in data for training labels
TestLabels<-read.csv("test\\y_test.txt", header=FALSE, sep="") ##read in labels for test data
from<-c("1", "2", "3", "4", "5", "6") ##identify label vectors for activities measured
to<-c("WALKING", "WALKING_UP", "WALKING_DOWN", "SITTING", "STANDING", "LAYING") ##create new desired labels 

gsub2 <- function(pattern, replacement, x, ...) { ##write sub function to substitute numbers with names
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
  x
}
TrainLabels<- gsub2(from, to, TrainLabels$V1) ##apply gsub2 function to training data labels
TestLabels<-gsub2(from, to, TestLabels$V1) ##apply gsub2 function to test data labels
TrainData<-cbind(TrainLabels, Train) ##bind training data labels to training data as new column
TestData<-cbind(TestLabels, Test) ##bind test data labels to test data as new column
setnames(TrainData, "TrainLabels", "Activity") ##rename TrainLabels column ready for binding
setnames(TestData, "TestLabels", "Activity") ##rename TestLabels column ready for binding
AllData<-rbind(TrainData, TestData) ##Merges the training and the test sets to create one data set.
Varnames<-read.csv("features.txt", header=FALSE, sep="", colClasses = "character") ##read in list of variable names
Varnames<-Varnames[1:561, "V2"] ##subset to isolate column of interest
setnames(AllData, colnames(AllData[,2:562]), Varnames) ##change variable names to more meaningful names
SubData1<- AllData[grep("mean",colnames(AllData))] ##extract only measurements on mean
SubData2<-AllData[grep("std", colnames(AllData))] ##extract only measurements on std
ExtractData<-cbind(SubData1, SubData2)##combine meand std data into one dataset
ExtractData<-cbind(AllData["Activity"], ExtractData)
AvgData<-aggregate(.~Activity, data=ExtractData, mean) ##create a separate clean dataset with average of each variable
