#The data for the project are from:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#First set WD!

#This R script called run_analysis.R does the following:

#1)Merges the training and the test sets to create one data set.

#1.1)training and test sets:
training_dset <- read.table("train/X_train.txt")
test_dset <- read.table("test/X_test.txt")
Dset <- rbind(training_dset, test_dset)

#1.2)training and test subjects:
training_subject <- read.table("train/subject_train.txt")
test_subject <- read.table("test/subject_test.txt")
Subject <- rbind(training_subject, test_subject)

#1.3)training and test labels:
training_label <- read.table("train/y_train.txt")
table(training_label)
test_label <- read.table("test/y_test.txt")
table(test_label)
Label <- rbind(training_label, test_label)

#2)Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("features.txt")
#search for matches to arguments mean and std:
mean_and_std_features <- grep("mean\\(\\)|std\\(\\)", features[, 2])
Dset <- Dset[, mean_and_std_features]
# remove "()":
names(Dset) <- gsub("\\(\\)", "", features[mean_and_std_features, 2])
# remove "-":
gsub("-", "", names(Dset))  
#translate upper to lower case:
names(Dset) <- tolower(names(Dset))

#3)Uses descriptive activity names to name the activities in the data set.
activities <- read.table("activity_labels.txt")
#again translate upper to lower case:
activities[, 2] <-tolower(gsub("_", "", activities[, 2]))
substr(activities[2, 2], 8, 8) <- toupper(substr(activities[2, 2], 8, 8))
substr(activities[3, 2], 8, 8) <- toupper(substr(activities[3, 2], 8, 8))
#asign labels to activities:
activities_Label <- activities[Label[, 1], 2]
Label[, 1] <- activities_Label
#asign name to Label:
names(Label) <- "activity"

#4)Appropriately labels the data set with descriptive variable names. 
names(Subject) <- "subject"
#join 3 parts:
Dcleaned <- cbind(Subject, Label, Dset)
# write the 1st dataset:
write.table(Dcleaned, "merg_clean_data.txt")

#5)From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

num_Subjects <- length(table(Subject))
num_Activities <- dim(activities)[1]
num_Cols <- dim(Dcleaned)[2]
#form the data matrix:
result <- Dcleaned[1:(num_Subjects*num_Activities), ] 
#Coerce to a Data Frame:
result <- as.data.frame(result)
#Set the column Names:
colnames(result) <- colnames(Dcleaned)

#Calculate the mean of each measurement for each combination:

row = 1
for (i in 1:numSubjects) {
  for (j in 1:numActivities) {
    result[row, 1] = uniqueSubjects[i]
    result[row, 2] = activities[j, 2]
    tmp <- cleaned[cleaned$subject==i & cleaned$activity==activities[j, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
#The result is a 180x68 data frame, saved as "tidy_data_set_with_averages.txt":
head(result)
write.table(result,"tidy_data_set_with_averages.txt",row.names = FALSE)




