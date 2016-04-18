# coursera course project from Getting and Cleaning Data

# set the desired working directory

# downlowad data and save it to the 'data' directory 

fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileURL, destfile = 'project_data.zip')
unzip('project_data.zip', exdir = 'data')

# load required libraries
library(dplyr)

# reading each test and training file
test_subject <- read.table('data/UCI HAR Dataset/test/subject_test.txt')
test_x <- read.table('data/UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('data/UCI HAR Dataset/test/y_test.txt')
train_subject <- read.table('data/UCI HAR Dataset/train/subject_train.txt')
train_x <- read.table('data/UCI HAR Dataset/train/X_train.txt')
train_y <- read.table('data/UCI HAR Dataset/train/y_train.txt')

# reading features file

features <- read.table('data/UCI HAR Dataset/features.txt')

#read activity labels

activities <- read.table('data/UCI HAR Dataset/activity_labels.txt')


# for the first part of the assignment 'Merges the training and the test sets to create one data set.'
# will merge test and train and assing the subjects and activities for each observation

# make the test_y data a factor so you can replace numbers for readable names 
# with this the third part of the assignment is addressed 'Uses descriptive 
# activity names to name the activities in the data set'

test_y_factorized <- factor(test_y$V1, levels = c(1, 2, 3, 4, 5, 6), labels = c('walking', 
                        'walking_upstairs','walking_downstairs', 'sitting', 'standing', 'laying'))

# merge train_y_factorized and subject_train with train_x

test <- cbind(test_subject, test_y_factorized, test_x)

# renaming variables in an attempt to complete the fourth part of the assignment:
# 'Appropriately labels the data set with descriptive variable names.'
# note that the variable names are very complicated so consider leaving the 
# original names to correlate better to the features_info.txt file.

features_tidy <- gsub('^t', 'time', features$V2)
features_tidy <- gsub('^f', 'frecuency', features_tidy)
features_tidy <- gsub('Acc', 'Accelerometer', features_tidy)
features_tidy <- gsub('Gyro', 'Gyroscope', features_tidy)
features_tidy <- gsub('Mag', 'Magnitude', features_tidy)

# name the variables in the merged 'test' dataset

colnames(test) <- c('subject', 'activity', as.character(features_tidy))

# same process for the train data

train_y_factorized <- factor(train_y$V1, levels = c(1, 2, 3, 4, 5, 6), labels = c('walking', 
                     'walking_upstairs','walking_downstairs', 'sitting', 'standing', 'laying'))

train <- cbind(train_subject, train_y_factorized, train_x)

colnames(train) <- c('subject', 'activity', as.character(features_tidy))

# merge the train and test datasets 

merged_datasets <- rbind(test, train) # this is the output to item 1 in the assignment
# that includes the subject and activity variables

# for the second part 'Extracts only the measurements on the mean 
# and standard deviation for each measurement.'

# from features, extract all the column indexes that contain 'mean()' or 'std()'
means_and_stds_indexes <- c(grep('mean()', colnames(merged_datasets)), 
                            grep('std()', colnames(merged_datasets)))

# use the means_and_stds vector to subset the merged_datasets table
# any of the following can be the second part output
# either including the subject and activity variables or not
filtered_dataset <- merged_datasets[, means_and_stds_indexes]
filtered_dataset_plus <- merged_datasets[, c(1,2,means_and_stds_indexes)]


# summarize by subject and activity

by_both <- filtered_dataset_plus %>% group_by(subject, activity) %>% 
  summarise_each(funs(mean))
# assign matching colnames


# create an output directory in your working directory
dir.create('output')
# write the required file output into the output folder

write.table(by_both, 'output/output_table.csv', row.names = FALSE,
            col.names = TRUE, quote = FALSE, sep = ',')

# this is the fifth point of the assgnment: 'From the data set in step 4,
# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.'

