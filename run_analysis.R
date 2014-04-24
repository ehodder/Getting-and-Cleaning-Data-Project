## get testing and training sets
xTest <- read.table("UCI HAR Dataset//test//X_test.txt")
xTrain <- read.table("UCI HAR Dataset//train//X_train.txt")
## combine testing and training sets
dfCombined <- rbind(xTest, xTrain)
## get column names
features <- read.table("UCI HAR Dataset//features.txt")
## add column names
colnames(dfCombined) <- features[, 2]
## get and add subjects
## get and add activities with labels

## extract only mean and std columns
mean <- names(dfCombined)[grep("mean()", names(dfCombined), fixed=TRUE)]
std <- names(dfCombined)[grep("std()", names(dfCombined), fixed=TRUE)]
cols <- c(mean, std)
dfReduced <- dfCombined[, cols]


