# With "UCI HAR Dataset 2" as your working directory, this script does the following: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 'mean_values.txt'
#    with the average of each variable for each activity and each subject.

# (package dependencies: reshape2)

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

# melt the data frame so that the average can be aggregated over each variable:
library(reshape2)
dataMelt <- melt(dataMeanStd, id = c("activity", "subject"))
dataFinal <- dcast(dataMelt, activity + subject ~ variable, mean)

# create a new file for this data set:
write.table(dataFinal, "mean_values.txt", row.names = FALSE)
