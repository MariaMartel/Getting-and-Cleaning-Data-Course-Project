# Getting and Cleaning Data Course Project CodeBook

Here are described the variables, the data, and any transformations or work needed to clean up the Course Project Data.

These data represent data collected from the accelerometers from the Samsung Galaxy S Smartphone, as part as the experiment called “Human Activity Recognition Using Smartphones Data Set”, where 30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset was randomly partitioned into two sets, the training data and the test data, and were recorded various features.

The full description can be readed in: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## The data.
The data were downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
And include several files with the data, and information and description about them. Here it has been selected the files corresponding to set, subject and label for both training and test data (which were merged further).

## The variables.
There are 180 observations = 6 activities (walking, walking_upstairs, walking_downstairs, sitting, standing, laying) x 30 voluntaires.
And there are 68 variables corresponding to the mean and the standard deviation of the different physical features measured in the experiment (for example: “tbodyacc.mean.x” is the mean of body acceleration signal obtained by subtracting the gravity from the total acceleration, on the x-axis, or “tbodygyrojerk.std.z” is the standard deviation of the angular velocity, on the z-axis). The full description can be read in the file "features.info.txt", which is included in the downloaded dataset.

## Work and transformations.
First of all, the working directory was setted and the data were downloaded from the link mentioned above.

Then, the script called “run_analysis.R” does the following:

* Merges the training and the test sets to create one data set (training and test sets, training and test subjects and training and test labels).

* Extracts only the measurements on the mean and standard deviation for each measurement (searching for matches to arguments mean and std, removing "()" and "-", translating upper to lower case).

* Uses descriptive activity names to name the activities in the data set (again translating upper to lower case, asignning labels to activities and names to label).

* Appropriately labels the data set with descriptive variable names (joining the 3 parts and writing the 1st dataset, named "merg_clean_data.txt").

* From the 1st data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject (forming the the data matrix, coercing to a data frame, setting the column names, calculating the mean of each measurement for each combination, and finally writing out the final data frame).

The result is a 180x68 data frame, saved as "tidy_data_set_with_averages.txt" (with write.table() using row.name=FALSE).
