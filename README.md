Getting-and-Cleaning-Data-Project
=================================

Coursera Getting and Cleaning Data Project

You can look at the results of this project by reading the output file called ProjectTidyData.csv using read.table.

In order to reproduce the results of this project:
- Clone the repository at https://github.com/ehodder/Getting-and-Cleaning-Data-Project into your working directory
- Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Extract the zipped data into your working directory
- Open the run_analysis.R file


The when you execute run_analysis.R the script will 
- pull together the research testing and training sets 
- include subject IDs
- add activity names
- reduce the data set to include only mean and standard deviation columns
- average all mean and standard deviation data by subject and activity

