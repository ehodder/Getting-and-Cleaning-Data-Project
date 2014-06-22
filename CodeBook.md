Getting-and-Cleaning-Data-Project
=================================

Code Book

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The output of this project gathers the above data into a single, tidy dataset that includes averages for mean and standard deviation columns grouped by subject and activity.

The data is split into test and training sets. The first goal is to read those files and include the subject and activity IDs.

```{r eval=FALSE}
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
```

The testing and training data sets are combined and descriptive column names are added.

```{r eval=FALSE}
## combined test and train data sets
df <- rbind(test, train)

## get and add column names
features <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors = FALSE)
colnames(df) <- c("Subject", "Activity", features[, 2])
```

The project guidelines only require data columns related to means and standard deviations. Find those columns and use them the rest of the way while keeping the subject and activity IDs.

```{r eval=FALSE}
## find columns with mean and standard deviation data and extract those columns plus subject and activity
mean <- names(df)[grep("mean()", names(df), fixed=TRUE)]
std <- names(df)[grep("std()", names(df), fixed=TRUE)]
cols <- c("Subject", "Activity", mean, std)
dfReduced <- df[, cols]
```

Get activity names and add them to the data.
```{r eval=FALSE}
## get activity names and add them
activityLabels <- read.table("UCI HAR Dataset//activity_labels.txt")
colnames(activityLabels) <- c("Activity", "Activity_Name")
dfFinal <- merge(activityLabels, dfReduced, by = "Activity")
```
Next, compute averages of mean and standard deviation data by subject and activity.
```{r eval=FALSE}
## get averages of numeric data by subject and activity
## change column names to reflect that they are now averages
dfMeans <- aggregate(dfFinal[, 4:69], by=dfFinal[, 2:3], FUN=mean)
x <- paste0(names(dfMeans[, 3:68]), "_Average")
colnames(dfMeans) <- c("Activity_Name", "Subject", x)
```
Finally, write the data to a file. This can be read into R using read.table.
```{r eval=FALSE}
## write out the results
write.table(dfMeans, "ProjectTidyData.csv", row.names=FALSE, sep=",")
```
