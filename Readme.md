<h1>Getting and Cleaning Data Course Project<h1>
<h3>Author: Aljoscha K<h3>

This readme describes how the data of the project assignment was processed.

<h3>1. Data Origin<h3>
This assignment was about the processing of wearable computing data, recorded by
test persons wearing a smartphone during different activities. The smartphone 
recorded all movements in x,y and z direction producing multiple measures. 

The original data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A precise description can be obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

<h3>2. Objective<h3>
The objective was to create a tidy data set which contains only the mean and standard deviation 
of each measurement and average these measurements for each activity and subject. 

<h3>3. Transformations and Scripts used<h3>
All transformations were executed within the RScript '<run_analysis.R>'. Input was the unzipped data from the source described in *1. Data Origin*.
The following steps and transformations were done: 
1. Specifying the filenames of all files that were read in and written after transformations.
2. Reading of the files with data and column and row labels
3. Assigning column names to the data
4. Merging training and test data
5. Filtering to extract only columns that contain the strings *mean()* or *std()* using regular expressions.
6. Joining activity ID and activity names as addtional columns. 
7. Adding subject ID as additional column.
8. Calculate all average values of all data columns for each subject and activity. 
9. Write calculated values into a new table saved as '<Tidy_Data_Set.csv>'. 