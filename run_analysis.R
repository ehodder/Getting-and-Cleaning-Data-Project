## get testing and training sets
## add subject and activity IDs

## test
xTest <- read.table("UCI HAR Dataset//test//X_test.txt")
activityTest <- read.table("UCI HAR Dataset//test//Y_test.txt")
subjectTest <- read.table("UCI HAR Dataset//test//subject_test.txt")
test <- cbind(subjectTest, activityTest, xTest)

## train
xTrain <- read.table("UCI HAR Dataset//train//X_train.txt")
activityTrain <- read.table("UCI HAR Dataset//train//Y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset//train//subject_train.txt")
train <- cbind(subjectTrain, activityTrain, xTrain)

## combined test and train data sets
df <- rbind(test, train)

## get and add column names
features <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors = FALSE)
colnames(df) <- c("Subject", "Activity", features[, 2])

## find columns with mean and standard deviation data and extract those columns plus subject and activity
mean <- names(df)[grep("mean()", names(df), fixed=TRUE)]
std <- names(df)[grep("std()", names(df), fixed=TRUE)]
cols <- c("Subject", "Activity", mean, std)
dfReduced <- df[, cols]

## get activity names and add them
activityLabels <- read.table("UCI HAR Dataset//activity_labels.txt")
colnames(activityLabels) <- c("Activity", "Activity_Name")
dfFinal <- merge(activityLabels, dfReduced, by = "Activity")

## get averages of numeric data by subject and activity
## change column names to reflect that they are now averages
dfMeans <- aggregate(dfFinal[, 4:69], by=dfFinal[, 2:3], FUN=mean)
x <- paste0(names(dfMeans[, 3:68]), "_Average")
colnames(dfMeans) <- c("Activity_Name", "Subject", x)

## write out the results
write.table(dfMeans, "ProjectTidyData.txt", row.names=FALSE, sep=",")
