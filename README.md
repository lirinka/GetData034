# GetData034
Getting and cleaning data Course project



The script operates on the Human Activity Recognition Using Smartphones Dataset,
source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The run_analysis script 
1 reads the labels files "features" and "activity"

2 reads the training data files
3 adds labels to the training files from the "features" file
4 subsets for only the measurements of the mean and strandart deviation for each measurement
5 merges the training set together

6 performs steps 2-5 for test data files

7 merges the training and test data together

8 adds descriptive labels to the data set from the "activity labels" file

9 performs a series of replacements in column names to make them more clear and descriptive (e.g. substituting "t" with "time")

10 creates a tidy data set with the average of each variable for each activity and each subject

 