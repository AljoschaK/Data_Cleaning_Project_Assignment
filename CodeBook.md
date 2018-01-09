# Getting and Cleaning Data Course Project
## Codebook
### Author: Aljoscha K

This Codebook describes how the data of the project assignment was processed.

### 1. Data Origin
This assignment was about the processing of wearable computing data, recorded by
test persons wearing a smartphone during different activities. The smartphone 
recorded all movements in x,y and z direction producing multiple measures. 

The original data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
It includes an explanation about the variables that are given. 

A precise description can be obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### 2. Objective
The objective was to create a tidy data set which contains only the mean and standard deviation 
of each measurement and average these measurements for each activity and subject. 

### 3. Input Variables and Data
From the original downloaded and unzipped data following files were used: 

/train/X_train.txt
--> This file contains the first part of the wearable measurement data, originally training data. 
/test/X_test.txt
--> This file contains the second part of the wearable measurement data, originally test data. 
----> This is the original data that we want to use for calculation.

/train/y_train.txt
-->This file contains the first part of the activity ID labels, belonging to the training data. 
/test/y_test.txt
-->This file contains the second part of the activity ID labels, belonging to the test data. 
----> These IDs are used in my transformation to join the activity names to the data.

/activity_labels.txt
--> These are the actual activity labels
----> These labels are joined over the ID

/train/subject_train.txt
/test/subject_test.txt
-->These files contain the information about the subject IDs, that identify the persons who carried the wearables during measurements. 
----> This information is joined to the data during transformation.

### 4. Transformations and Scripts used
All transformations were executed within the RScript `<run_analysis.R>`. Input was the unzipped data from the source described in *1. Data Origin*.
The following steps and transformations were done: 
1. Specifying the filenames of all files that were read in and written after transformations.
2. Reading of the files with data and column and row labels
3. Assigning column names to the data
4. Merging training and test data
5. Filtering to extract only columns that contain the strings *mean()* or *std()* using regular expressions.
6. Joining activity ID and activity names as addtional columns. 
7. Adding subject ID as additional column.
8. Calculate all average values of all data columns for each subject and activity. 
9. Write calculated values into a new table saved as `<Tidy_Data_Set.csv>`. 

### 5. Variables and Data created during transformation
#### Filenames
* train_x_path: String storing the file location of the input data file
* test_x_path_path: String storing the file location of the input data file

* train_y_path: String storing the file location of the activity label IDs
* test_y_path: String storing the file location of the activity label IDs
* activity_mapping_path: String storing the file location of the activity names

* col_names_path: String storing the file location of the column (measure) names

* train_subjects_path: String storing the file location of the subject identifiers
* test_subjects_path: String storing the file location of the subject identifiers

* output_path: String storing the path to the Tidy_Data_Set.csv output file

#### Data Read In
* train_x: Data Frame where the read in data of the training data is stored
* test_x: Data Frame where the read in data of the test data is stored

* train_y: Data Frame where the activity ID labels for each row of the training data is stored
* test_y: Data Frame where the activities ID labels for each row of the test data is stored

* activities: Data Frame where the read in activity labels and their respective ID is stored for later mapping to the data

* train_subjects: Data Frame where the read in identifiers of the persons wearing the devices for each row is stored
* test_subjects:  Data Frame where the read in identifiers of the persons wearing the devices for each row is stored

* col_names_table: Data Frame where the read in column names of the measures are stored

#### Transformed Data
* col_names: Column names of the measures (only the second column of the col_names_table is needed)

* all_data: Data Frame with combined data of training and test data

* mean_and_stdv: Data Frame based on all_data, but filtered by regex to contain only columns of which the name contains either *mean()* or *std()*. 
*Note: There are more column names with the word mean but I read the task as to use only columns that are the actual mean and stdev of one measure category. There are more than one solution, I guess. I did not use them on purpose.*

* data_with_activity_ID: Data Frame based on mean_and_stdv, but with additional column containing the activity label ID of each row

* data_with_activity_names: Data Frame based on data_with_activity_ID, but with the actual activity labels joined

* data_with_act_and_sub_desc: Data Frame based on data_with_activity_names but with the subject ID added for each row

* tidy_data_set: Data Frame based on data_with_act_and_sub_desc which is aggregated by the activity name and subject ID. For each it contains the average value of each measure column. This file is used to create the output file.

### Output Created
The tidy_data_set data frame is written to `<Tidy_Data_Set.csv`> which is stored on GitHub.

