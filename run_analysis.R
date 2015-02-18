# With "UCI HAR Dataset 2" as your working directory, this script does the following: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 'mean_values.txt'
#    with the average of each variable for each activity and each subject.

# load training and test sets, and combine into one data frame:
train1 <- read.table("train/X_train.txt")
test1 <- read.table("test/X_test.txt")
data <- rbind(train1, test1)

# Using features.txt, select columns with "mean" or "std" in the name and rename them:
features <- read.table("features.txt")
index <- grep("mean\\(|std\\(", features$V2)
dataMeanStd <- data[, index]
names(dataMeanStd) <- features[index, "V2"]

# load Y_train.txt and Y_test.txt, and combine them into one data frame:
trainY <- read.table("train/Y_train.txt")
testY <- read.table("test/Y_test.txt")
combinedY <- rbind(trainY, testY)

# Using activity_labels.txt, add a column of activity labels to the main data frame:
activityLabels <- read.table("activity_labels.txt")$V2
labeledY <- activityLabels[combinedY$V1]
dataMeanStd$activity = labeledY

# load subject data, combine them, and add a column to the main data frame:
trainSubject <- read.table("train/subject_train.txt")
testSubject <- read.table("test/subject_test.txt")
combinedSubject <- rbind(trainSubject, testSubject)
dataMeanStd$subject = combinedSubject$V1

# split the data into a different group for each activity/subject combination:
splitter <- split(dataMeanStd, list(dataMeanStd$activity, dataMeanStd$subject))

# create new data frame with the column means of each variable in the first activity/subject group:
output <- data.frame(t(colMeans(splitter[[1]][,1:66])))
output <- cbind(splitter[[1]][1, 67:68], output) # add columns for activity and subject

# loop through the rest of the groups, and append their column means to the data frame:
for (i in 2:180) {
    splitMeans <- data.frame(t(colMeans(splitter[[i]][,1:66])))
    splitMeans <- cbind(splitter[[i]][1, 67:68], splitMeans)
    output <- rbind(output, splitMeans)
}

# create a new file for this data set:
write.table(output, "mean_values.txt", row.names = FALSE)
