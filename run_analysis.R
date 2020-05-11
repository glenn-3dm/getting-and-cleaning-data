## Getting and Cleaning Data Course Project

## Load Pertinent Packages
library(tidyr)
library(dplyr)
library(stringr)

## Import Activity ID #'s
test.activities <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/test/y_test.txt', header = FALSE)
train.activities <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/train/y_train.txt', header = FALSE)
colnames(test.activities) <- "Activity Number"
test.activities$order <- 1:nrow(test.activities)
colnames(train.activities) <- 'Activity Number'
train.activities$order <- 1:nrow(train.activities)

## Convert Activity #'s to Activity Names
activity.names <- readLines('C:/RStudio/newproj/UCI HAR Dataset/activity_labels.txt')
activity.names <- as.data.frame(strsplit(as.character(activity.names)," "))
activity.names <- data.frame(t(activity.names))
colnames(activity.names) <- c('Activity Number','Activity Name')
activity.names[,1] <- as.integer(activity.names[,1])

test.activities <- right_join(test.activities,activity.names,by = NULL)
test.activities <- test.activities[order(test.activities$order),]
train.activities <- right_join(train.activities,activity.names,by = NULL)
train.activities <- train.activities[order(train.activities$order),]

## Import Observation (Features) ID #'s
observation.names <- readLines('C:/RStudio/newproj/UCI HAR Dataset/features.txt')
observation.names <- as.data.frame(strsplit(as.character(observation.names),' '))

## Import Subject ID #'s 
test.subject <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/test/subject_test.txt',header = FALSE)
colnames(test.subject) <- 'Test Subject ID Number'
train.subject <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/train/subject_train.txt',header = FALSE)
colnames(train.subject) <- 'Train Subject ID Number'

## Import and Separate Cells in Data Files
test.data <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/test/X_test.txt', header = FALSE, sep = '')
train.data <- read.csv('C:/RStudio/newproj/UCI HAR Dataset/train/X_train.txt', header = FALSE, sep = '')

## Merge Activity, Subject, and Observation Data Frames
##  -- save test and train versions separately
colnames(test.data) <- as.character(unlist(observation.names[2,]))
colnames(train.data) <- as.character(unlist(observation.names[2,]))

test.data <- test.data[!duplicated(names(test.data))]
train.data <- train.data[!duplicated(names(train.data))]

test.mean.std <- select(test.data,contains('mean'),contains('std'))
train.mean.std <- select(train.data,contains('mean'),contains('std'))

test.final <- cbind.data.frame(test.subject[,1],test.activities[,3],test.mean.std)
names(test.final)[1:2] <- c('Test Subject ID Number','Activity Name')
train.final <- cbind.data.frame(train.subject[,1],train.activities[,3],train.mean.std)
names(train.final)[1:2] <- c('Train Subject ID Number','Activity Name')

## Create Dataset Showing Average of Each Variable
## for Each Activity and Each Subject
test.summary <- test.final  %>%
      group_by(`Test Subject ID Number`,`Activity Name`)  %>%
      summarise_all(list(mean = mean))

train.summary <- train.final  %>%
      group_by(`Train Subject ID Number`,`Activity Name`)  %>%
      summarise_all(list(mean = mean))
  