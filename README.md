---
title: "Getting and Cleaning Data Course Project"
author: "Maru"
date: "April 17, 2016"
output: html_document
---

### Contents

This is a repo containing the script and code book for the Coursera 'Getting and Cleaning Data' course final assignment. 

The file CodeBook.md contains the explanation of the data, the variables, and considerations about the script.

The file run_analysis.R contains the acual script used to process the data. It downloads the data into a folder named 'data' in your working directory. 

The file README.md contains the information you are reading now.


### Notes

The analysis uses the *dplyr* package.

The required file will be written in a folder called 'output' inside the working directory. 


### Aim of the script 

The run_analysis.R does the following:

1-Merges the training and the test sets to create one data set.

2-Extracts only the measurements on the mean and standard deviation for each measurement.

3-Uses descriptive activity names to name the activities in the data set.

4-Appropriately labels the data set with descriptive variable names.

5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

