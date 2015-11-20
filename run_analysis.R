setwd("C:/Users/SPL-M804-2/Desktop/R coursera/Getting and cleaning data/UCI HAR Dataset")


### this script

# Merges the training and the test sets to create one data set.
    
# Extracts only the measurements on the mean and standard deviation for each measurement. 
    
# Uses descriptive activity names to name the activities in the data set
    
# Appropriately labels the data set with descriptive variable names. 
    
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# load dplyr package
library(dplyr)

### read label files

features<-read.table("./features.txt")
activity<-read.table("./activity_labels.txt")
colnames(activity)<-c("activityId","activityType")


### read the train data

x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/Y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

# add labels

colnames(x_train)<-as.character(features[,2])
colnames(y_train)<-"activityId"
colnames(subject_train)<-"subjectId"


# eliminate duplicate column names in x_train
x_train<-x_train[!duplicated(names(x_train))]

# extract only the measurements for mean and std
extract<- select(x_train, matches(".*[Mm]ean.*|.*[Ss]td.*"))

# merge the training set
train<-cbind(extract, y_train, subject_train)

### read the test data

x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/Y_test.txt")
subject_test<-read.table("./test/subject_test.txt")

# add labels

colnames(x_test)<-as.character(features[,2])
colnames(y_test)<-"activityId"
colnames(subject_test)<-"subjectId"

# eliminate duplicate column names in x_test
x_test<-x_test[!duplicated(names(x_test))]

# extract only the measurements for mean and std
extract<-select(x_test, matches(".*[Mm]ean.*|.*[Ss]td.*"))

# merge the test set
test<-cbind(extract, y_test, subject_test)

# merge both sets 
dat<-rbind(train, test)

### add desriptive labels:

dat<-merge(dat,activity,by="activityId",all.x=T)

names<-colnames(dat)

# make some replacements so that the labels are more descriptive

names <- gsub("^t","Time",names)
names <- gsub("^f","Frequency",names)
names <- gsub("-?mean[(][)]-?","Mean",names)
names <- gsub("-?std[(][)]-?","Std",names)
names <- gsub("-?meanFreq[()][)]-?","MeanFrequency",names)
names <- gsub("BodyBody","Body",names)

colnames(dat)<-names

# create a tidy data set with the average of each variable for each activity and each subject. 

# remove the activity type column from the data
newdat<-select(dat, -activityType)

# create the tidy data set
tidy<-aggregate(newdat[,names(newdat)!=c("activityId","subjectId")], by=list(activityId=newdat$activityId,subjectId = newdat$subjectId),mean)

# bring back the activity type column
tidy<-merge(tidy,activity,by="activityId",all.x=T)

# write the tidy data into a txt file
write.table(tidy, './tidyData.txt',row.names=F,sep='\t')




